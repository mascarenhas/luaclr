using System;
using System.Collections;

namespace Lua
{
  class Node 
  {
    public static readonly Node DummyNode = new Node(0);
    public static readonly Node NilNode = new Node(0);

    public int position;
    public object key;
    public object val;
    public Node next;

    public Node(int pos) 
    {
      key = Nil.Instance;
      val = Nil.Instance;
      next = null;
      position = pos;
    }

    public void Copy(Node c) 
    {
      key = c.key;
      val = c.val;
      next = c.next;
    }
  }

  public class Table : Reference 
  {
    static readonly int MAXBITS = 32;

    static readonly byte[] log_8 = new byte[]	{
      0,
      1,1,
      2,2,2,2,
      3,3,3,3,3,3,3,3,
      4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
      5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
      6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,
      6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,
      7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
      7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
      7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
      7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
    };

    int sizeArray;
    Node[] array;
    int[] nums = new int[MAXBITS+1];

    byte logSizeNode;
    Node[] node;
    int firstFree;

    Table _meta = null;

    int ArrayIndex(object key) 
    {
      if(key is double) 
	{
	  int k = (int)((double)key);
	  if(((double)k == (double)key) && (k >= 1) && (k < Int32.MaxValue))
	    return k;
	}
      return -1;
    }

    void ComputeSizes(int[] nums, int ntotal, ref int narray, ref int nhash) 
    {
      int i;
      int a = nums[0];  /* number of elements smaller than 2^i */
      int na = a;  /* number of elements to go to array part */
      int n = (na == 0) ? -1 : 0;  /* (log of) optimal size for array part */
      for (i = 1; a < narray && narray >= (1 << (i-1)); i++) 
	{
	  if (nums[i] > 0) 
	    {
	      a += nums[i];
	      if (a >= (1 << (i-1))) 
		{  /* more than half elements in use? */
		  n = i;
		  na = a;
		}
	    }
	}
      nhash = ntotal - na;
      narray = (n == -1) ? 0 : (1 << n);
    }

    void NumUse(ref int narray, ref int nhash) 
    {
      for(int k = 0; k < nums.Length; k++) nums[k]=0;
      int i, lg;
      int totaluse = 0;
      /* count elements in array part */
      for (i = 0, lg = 0; lg <= Table.MAXBITS; lg++) 
	{  /* for each slice [2^(lg-1) to 2^lg) */
	  int ttlg = (1 << lg);  /* 2^lg */
	  if (ttlg > this.sizeArray) 
	    {
	      ttlg = this.sizeArray;
	      if (i >= ttlg) break;
	    }
	  for (; i < ttlg; i++) 
	    {
	      if (this.array[i].val != Nil.Instance) 
		{
		  nums[lg]++;
		  totaluse++;
		}
	    }
	}
      //for (; lg <= LuaTable.MAXBITS; lg++) nums[lg] = 0;  /* reset other counts */
      narray = totaluse;  /* all previous uses were in array part */
      /* count elements in hash part */
      i = this.node.Length;
      while (i-- > 0) 
	{
	  Node n = this.node[i];
	  if (n.val != Nil.Instance) 
	    {
	      int k = ArrayIndex(n.key);
	      if (k >= 0) 
		{  /* is `key' an appropriate array index? */
		  nums[FastLog2((uint)k - 1) + 1]++;  /* count as such */
		  narray++;
		}
	      totaluse++;
	    }
	}
      ComputeSizes(nums, totaluse, ref narray, ref nhash);
    }

    int FastLog2(uint x) 
    {
      if (x >= 0x00010000) 
	{
	  if (x >= 0x01000000) return Table.log_8[((x>>24) & 0xff) - 1]+24;
	  else return Table.log_8[((x>>16) & 0xff) - 1]+16;
	}
      else 
	{
	  if (x >= 0x00000100) return Table.log_8[((x>>8) & 0xff) - 1]+8;
	  else if(x!=0) return Table.log_8[(x & 0xff) - 1];
	  return -1;  /* special `log' for 0 */
	}
    }

    void SetArrayVector(int size) 
    {
      Node[] newArr=new Node[size];
      for(int i = 0; i < this.sizeArray; i++)
	newArr[i] = this.array[i];
      for(int i = this.sizeArray; i < newArr.Length; i++)
	newArr[i] = new Node(i);
      this.array = newArr;
      this.sizeArray = size;
    }

    void SetNodeVector(int lsize) 
    {
      int i;
      int size = (1 << lsize);
      if (lsize > Table.MAXBITS)
	throw new Exception("table overflow");
      if (lsize == 0) 
	{  /* no elements to hash part? */
	  this.node = new Node[1];
	  node[0] = Node.DummyNode;
	}
      else 
	{
	  this.node = new Node[size];
	  for (i=0; i < size; i++) 
	    {
	      this.node[i] = new Node(i);
	    }
	}
      this.logSizeNode = (byte)lsize;
      this.firstFree = size-1;  /* first free position to be used */
    }

    void Resize(int nasize, int nhsize) 
    {
      int i;
      int oldasize = this.sizeArray;
      int oldhsize = this.logSizeNode;
      Node[] nold;
      Node[] temp = new Node[] { new Node(0) };
      if(oldhsize != 0)
	nold = this.node;  /* save old hash ... */
      else 
	{  /* old hash is `dummynode' */
	  temp[0].key = this.node[0].key; /* copy it to `temp' */
	  temp[0].val = this.node[0].val;
	  temp[0].next = this.node[0].next;
	  nold = temp;
	  Node.DummyNode.key = Nil.Instance;  /* restate invariant */
	  Node.DummyNode.val = Nil.Instance;
	  Node.DummyNode.next = null;
	}
      if (nasize > oldasize)  /* array part must grow? */
	SetArrayVector(nasize);
      /* create new hash part with appropriate size */
      SetNodeVector(nhsize);  
      /* re-insert elements */
      if (nasize < oldasize) 
	{  /* array part must shrink? */
	  this.sizeArray = nasize;
	  /* re-insert elements from vanishing slice */
	  for (i = nasize; i < oldasize; i++) 
	    {
	      if (this.array[i].val != Nil.Instance)
		SetNum(i+1, this.array[i].val);
	    }
	  /* shrink array */
	  Node[] newarr = new Node[nasize];
	  for(i=0; i < newarr.Length; i++)
	    newarr[i] = this.array[i];
	  this.array = newarr;
	}
      /* re-insert elements in hash part */
      for (i = (1 << oldhsize) - 1; i >= 0; i--) 
	{
	  Node old = nold[i];
	  if (old.val != Nil.Instance) {
	    Set(old.key, old.val);
	  }
	}
    }

    void Rehash() 
    {
      int nasize = 0;
      int nhsize = 0;
      NumUse(ref nasize, ref nhsize);  /* compute new sizes for array and hash parts */
      /* Tries to have at least 50% free space on Hash for better performance profile */
      int l_nhsize = FastLog2((uint)nhsize);
      l_nhsize = (1<<l_nhsize)==nhsize?l_nhsize+1:l_nhsize+2;
      Resize(nasize, l_nhsize);
    }

    public Table(int narray, int lnhash) 
      {
	SetArrayVector(narray);
	SetNodeVector(lnhash);
      }

    public Table() : this(0,0) {}

    Node NewKey(object key) 
    {
      Node mp = MainPosition(key);
      if (mp.val != Nil.Instance) 
	{  /* main position is not free? */
	  Node othern = MainPosition(mp.key);  /* `mp' of colliding node */
	  Node n = this.node[this.firstFree];  /* get a free place */
	  if (othern != mp) 
	    {  /* is colliding node out of its main position? */
	      /* yes; move colliding node into free position */
	      while (othern.next != mp) othern = othern.next;  /* find previous */
	      othern.next = n;  /* redo the chain with `n' in place of `mp' */
	      n.Copy(mp); /* copy colliding node into free pos. (mp->next also goes) */
	      mp.next = null;  /* now `mp' is free */
	      mp.val = Nil.Instance;
	    }
	  else 
	    {  /* colliding node is in its own main position */
	      /* new node will go into free position */
	      n.next = mp.next;  /* chain new position */
	      mp.next = n;
	      mp = n;
	    }
	}
      mp.key = key;  /* write barrier */
      for (;;) 
	{  /* correct `firstfree' */
	  if (this.node[this.firstFree].key == Nil.Instance)
	    return mp;  /* OK; table still has a free place */
	  else if (this.firstFree == 0) break;  /* cannot decrement from here */
	  else this.firstFree = this.firstFree-1;
	}
      /* no more free places; must create one */
      mp.val = False.Instance; /* avoid new key being removed */
      Rehash();  /* grow table */
      Node newn = Get(ref key);  /* get new position */
      newn.val = Nil.Instance;
      return newn;
    }

    Node GetAny(object key) 
    {
      if (key == Nil.Instance) return Node.NilNode;
      else 
	{
	  Node n = MainPosition(key);
	  do 
	    {  /* check whether `key' is somewhere in the chain */
	      if (key.Equals(n.key)) return n;  /* that's it */
	      else n = n.next;
	    } while (n != null);
	  return Node.NilNode;
	}
    }

    Node GetInt(int key) 
    {
      if (1 <= key && key <= this.sizeArray) 
	{
	  return this.array[key-1];
	}
      else
	{
	  return GetDouble(key);
	}
    }

    Node GetDouble(double key)
    {
      Node n = MainPosition(key);
      do 
	{  /* check whether `key' is somewhere in the chain */
	  if (n.key is double && (double)(n.key) == key)
	    return n;  /* that's it */
	  else n = n.next;
	} while (n!=null);
      return Node.NilNode;
   }

    Node GetSymbol(Symbol key) 
    {
      Node n = this.node[key.hash % ((this.node.Length - 1) | 1)];
      do {  /* check whether `key' is somewhere in the chain */
	if (key == n.key)
	  return n;  /* that's it */
	else n = n.next;
      } while (n != null);
      return Node.NilNode;
    }

    Node Get(ref object key) 
    {
      if(key is double) 
	{
	  double kd = (double)key;
	  int k = (int)kd;
	  if ((double)k == kd)  /* is an integer index? */
	    return GetInt(k);  /* use specialized version */
	  else
	    return GetDouble(kd);
	} 
      else if(key is Symbol) 
	{
	  return GetSymbol((Symbol)key);
	}
      else if(key is String)
	{
	  Symbol s = Symbol.Intern(((String)key).S);
	  key = s;
	  return GetSymbol(s);
	}
      else
	{
	  return GetAny(key);
	}
    }

    void Set(object key, object val) 
    {
      Node p = Get(ref key);
      if(p != Node.NilNode) 
	{
	  p.val = val;
	} 
      else if(val != Nil.Instance) 
	{
	  if(key == Nil.Instance)
	    throw new Exception("table index is nil");
	  p = NewKey(key);
	  p.val = val;
	}
    }

    void SetNum(int key, object val) 
    {
      Node p = GetInt(key);
      if(p != Node.NilNode) 
	{
	  p.val = val;
	} 
      else if(val != Nil.Instance)
	{
	  p = NewKey((double)key);
	  p.val = val;
	}
    }

    Node MainPosition(object key) 
    {
      int hash = Hash(key);
      return this.node[hash];
    }

    Node MainPosition(double key) 
    {
      int hash = Hash(key);
      return this.node[hash];
    }

    Node MainPosition(Symbol key) 
    {
      int hash = Hash(key);
      return this.node[hash];
    }

    int Hash(object o) {
      if(o is double)
	return Hash((double)o);
      else if(o is Symbol)
	return Hash((Symbol)o);
      else if(o is String)
	return Hash(Symbol.Intern(((String)o).S));
      else
	return o.GetHashCode() % ((this.node.Length - 1) | 1);
    }

    int Hash(double n) {
      uint hsh = (uint)n;
      return (int)(hsh % ((this.node.Length - 1) | 1));
    }

    int Hash(Symbol s) {
      return (int)(s.hash % ((this.node.Length - 1) | 1));
    }

    /*
    ** returns the index of a `key' for table traversals. First goes all
    ** elements in the array part, then elements in the hash part. The
    ** beginning of a traversal is signalled by -1.
    */
    public void Next (ref object key, out object val) {
      int i;
      val = Nil.Instance;
      if (key == Nil.Instance) {
	i = 0;  /* first iteration */
      } else {
	i = ArrayIndex(key);
      }
      if (key == Nil.Instance || (0 < i && i < this.sizeArray)) { /* is `key' inside array part? */
	for (; i < this.sizeArray; i++) {  /* try first array part */
	  if (this.array[i].val != Nil.Instance) {  /* a non-nil value? */
	    key = (double)i;
	    val = this.array[i].val;
	    return;
	  }
	}
      } 
      int sizeNode = this.node.Length;
      if(i == this.sizeArray) {
	for(int h = 0; h < sizeNode; h++) {
	  Node n = this.node[h];
	  if(n.val != Nil.Instance) {
	    key = n.key;
	    val = n.val;
	    return;
	  }
	}
	key = Nil.Instance;
	val = Nil.Instance;
	return;
      } else {
	int h = (int)Hash(key);
	Node n = this.node[h];
	do {
	  if(key.Equals(n.key)) break;
	  n = n.next;
	} while(n != null);
	if(n == null) throw new Exception("invalid key to next");
	h = n.position;
	for(h++; h < sizeNode; h++) {
	  n = this.node[h];
	  if(n.val != Nil.Instance) {
	    key = n.key;
	    val = n.val;
	    return;
	  }
	}
	key = Nil.Instance;
	val = Nil.Instance;
	return;
      }
    }

    public override Table Metatable 
    {
      get 
	{
	  return _meta;
	}
      set 
	{
	  _meta = value;
	}
    }
	
    public override object this[object index] 
    {
      get 
	{
	  object value = Nil.Instance;
	  if(index is Symbol) 
	    {
	      Symbol key = (Symbol)index;
	      Node n = this.node[key.hash % ((this.node.Length - 1) | 1)];
	      do {  /* check whether `key' is somewhere in the chain */
		if (key == n.key) {
		  value = n.val;
		  break;  /* that's it */
		} else n = n.next;
	      } while (n != null);
	    }
	  else if(index is double) 
	    {
	      double kd = (double)index;
	      int k = (int)kd;
	      if ((double)k == kd)  /* is an integer index? */
		value = GetInt(k).val;  /* use specialized version */
	      else
		value = GetDouble(kd).val;
	    } 
	  else if(index is String)
	    {
	      Symbol key = Symbol.Intern(((String)index).S);
	      Node n = this.node[key.hash % ((this.node.Length - 1) | 1)];
	      do {  /* check whether `key' is somewhere in the chain */
		if (key == n.key) {
		  value = n.val;  /* that's it */
		  break;
		} else n = n.next;
	      } while (n != null);
	    }
	  else
	    {
	      value = GetAny(index).val;
	    }
	  object idx_meta;
	  if(value == Nil.Instance && this._meta != null && ((idx_meta = this._meta.GetSymbol(Reference.__index).val) != Nil.Instance)) {
	    if(idx_meta is Closure)
	      value = ((Reference)idx_meta).InvokeS(this, index);
	    else
	      value = ((Table)idx_meta)[index];
	  }
	  return value;
	}
      set 
	{
	  Node p = Get(ref index);
	  if(p != Node.NilNode) 
	    {
	      p.val = value;
	    } 
	  else if(value != Nil.Instance) 
	    {
	      if(index == Nil.Instance)
		throw new Exception("table index is nil");
	      p = NewKey(index);
	      p.val = value;
	    }
	}
    }

    public override object this[Symbol key] 
    {
      get 
      {
	object value = Nil.Instance;
	object idx_meta;
	Node n = this.node[key.hash % ((this.node.Length - 1) | 1)];
	do {  /* check whether `key' is somewhere in the chain */
	  if (key == n.key) {
	    value = n.val;  /* that's it */
	    break;
	  } else n = n.next;
	} while (n != null);
	if(value == Nil.Instance && this._meta != null && ((idx_meta = this._meta.GetSymbol(Reference.__index).val) != Nil.Instance)) {
	  if(idx_meta is Closure)
	    value = ((Reference)idx_meta).InvokeS(this, key);
	  else
	    value = ((Table)idx_meta)[key];
	}
	return value;
      }
      set
	{
	  Node n = this.node[key.hash % ((this.node.Length - 1) | 1)];
	  do {  /* check whether `key' is somewhere in the chain */
	    if (key == n.key) {
	      n.val = value;
	      return;  /* that's it */
	    } else n = n.next;
	  } while (n != null);
	  if(n==null && value != Nil.Instance) {
	    n = NewKey(key);
	    n.val = value;
	  }
	}
    }

    public override bool Equals(Reference r) {
      return r == this;
    }

    public override bool LessThan(Reference r) {
      throw new Exception("operation < not supported on tables");
    }

    public override bool LessThanOrEquals(Reference r) {
      throw new Exception("operation <= not supported on tables");
    }

    public override object Length() {
      return (double)this.sizeArray;
    }

    public override string ToString() {
      return "Lua.Table: " + this.GetHashCode();
    }

    public override object[] InvokeM(object[] args) {
      throw new Exception("operation call not supported on tables");
    }

    public override object[] InvokeM() {
      throw new Exception("operation call not supported on tables");
    }

    public override object[] InvokeM(object arg1) {
      throw new Exception("operation call not supported on tables");
    }

    public override object[] InvokeM(object arg1, object arg2) {
      throw new Exception("operation call not supported on tables");
    }

    public override object[] InvokeM(object arg1, object arg2, object arg3) {
      throw new Exception("operation call not supported on tables");
    }

    public override object[] InvokeM(object arg1, object arg2, object arg3, object arg4) {
      throw new Exception("operation call not supported on tables");
    }

    public override object[] InvokeM(object arg1, object arg2, object arg3, object arg4,
				    object arg5) {
      throw new Exception("operation call not supported on tables");
    }

    public override object[] InvokeM(object arg1, object arg2, object arg3, object arg4,
				    object arg5, object arg6) {
      throw new Exception("operation call not supported on tables");
    }

    public override object[] InvokeM(object arg1, object arg2, object arg3, object arg4,
				    object arg5, object arg6, object arg7) {
      throw new Exception("operation call not supported on tables");
    }
    public override object InvokeS(object[] args) {
      throw new Exception("operation call not supported on tables");
    }

    public override object InvokeS() {
      throw new Exception("operation call not supported on tables");
    }

    public override object InvokeS(object arg1) {
      throw new Exception("operation call not supported on tables");
    }

    public override object InvokeS(object arg1, object arg2) {
      throw new Exception("operation call not supported on tables");
    }

    public override object InvokeS(object arg1, object arg2, object arg3) {
      throw new Exception("operation call not supported on tables");
    }

    public override object InvokeS(object arg1, object arg2, object arg3, object arg4) {
      throw new Exception("operation call not supported on tables");
    }

    public override object InvokeS(object arg1, object arg2, object arg3, object arg4,
				  object arg5) {
      throw new Exception("operation call not supported on tables");
    }

    public override object InvokeS(object arg1, object arg2, object arg3, object arg4,
				  object arg5, object arg6) {
      throw new Exception("operation call not supported on tables");
    }

    public override object InvokeS(object arg1, object arg2, object arg3, object arg4,
				  object arg5, object arg6, object arg7) {
      throw new Exception("operation call not supported on tables");
    }
  }
}
