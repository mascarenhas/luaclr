using System;
using System.Collections;

namespace Lua
{
  class Node 
  {
    public static readonly Node DummyNode = new Node();
    public static readonly Node NilNode = new Node();

    public object key;
    public object val;
    public Node next;

    public Node() 
    {
      key = Nil.Instance;
      val = Nil.Instance;
      next = null;
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

    Table _meta;

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
      i = (1 << this.logSizeNode);
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
	newArr[i] = new Node();
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
	      this.node[i] = new Node();
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
      Node[] temp = new Node[] { new Node() };
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
	  if (old.val != Nil.Instance)
	    Set(old.key, old.val);
	}
    }

    void Rehash() 
    {
      int nasize = 0;
      int nhsize = 0;
      NumUse(ref nasize, ref nhsize);  /* compute new sizes for array and hash parts */
      Resize(nasize, FastLog2((uint)nhsize) + 1);
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
      Node newn = Get(key);  /* get new position */
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
	      if (key == n.key) return n;  /* that's it */
	      else n = n.next;
	    } while (n != null);
	  return Node.NilNode;
	}
    }

    Node GetNum(int key) 
    {
      if (1 <= key && key <= this.sizeArray) 
	{
	  return this.array[key-1];
	}
      else
	{
	  double nk = (double)key;
	  Node n = HashNum(nk);
	  do 
	    {  /* check whether `key' is somewhere in the chain */
	      if (n.key is double && (double)(n.key) == nk)
		return n;  /* that's it */
	      else n = n.next;
	    } while (n!=null);
	  return Node.NilNode;
	}
    }

    Node GetStr(String key) 
    {
      Node n = HashRef(key);
      do 
	{  /* check whether `key' is somewhere in the chain */
	  if (n.key is Reference && key.Equals((Reference)n.key))
	    return n;  /* that's it */
	  else n = n.next;
	} while (n != null);
      return Node.NilNode;
    }

    Node Get(object key) 
    {
      if(key is double) 
	{
	  int k = (int)((double)key);
	  if (((double)k) == (double)key)  /* is an integer index? */
	    return GetNum(k);  /* use specialized version */
	  else
	    return GetAny(key);
	} 
      else 
	{
	  if(key is String) 
	    return GetStr((String)(key));
	  else
	    return GetAny(key);
	}
    }

    void Set(object key, object val) 
    {
      Node p = Get(key);
      if(p != Node.NilNode) 
	{
	  p.val = val;
	} 
      else 
	{
	  if(key is double && Double.IsNaN((double)key))
	    throw new Exception("table index is NaN");
	  if(key == Nil.Instance)
	    throw new Exception("table index is nil");
	  p = NewKey(key);
	  p.val = val;
	}
    }

    void SetNum(int key, object val) 
    {
      Node p = GetNum(key);
      if(p != Node.NilNode) 
	{
	  p.val = val;
	} 
      else 
	{
	  p = NewKey((double)key);
	  p.val = val;
	}
    }

    Node MainPosition(object key) 
    {
      if(key is double)
	return HashNum((double)key);
      else 
	return HashRef((Reference)key);
    }

    Node HashNum(double n) 
    {
      uint hsh = (uint)n.GetHashCode();
      return this.node[hsh % ((this.node.Length - 1) | 1)];
    }
        
    Node HashRef(Reference r) 
    {
      return this.node[((uint)r.GetHashCode()) % ((this.node.Length - 1) | 1)];
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
	  return Get(index).val;
	}
      set 
	{
	  Set(index, value);
	}
    }

    public object this[String index] 
    {
      get 
	{
	  return GetStr(index).val;
	}
    }

    public override bool Equals(Reference r) {
      return r == this;
    }

    public override bool LessThan(Reference r) {
      throw new Exception("operation < not supported on tables");
    }

    public override bool LessThanOrEqual(Reference r) {
      throw new Exception("operation <= not supported on tables");
    }

    public override object Length() {
      return (double)this.sizeArray;
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
