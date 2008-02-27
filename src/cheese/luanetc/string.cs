using System;
using System.Collections.Generic;

namespace Lua {
  public class Symbol : String {
    public static Dictionary<string, Symbol> interned = new Dictionary<string, Symbol>();

    public static Symbol Intern(string s) {
      Symbol sym;
      interned.TryGetValue(s, out sym);
      if(sym == null) {
	sym = new Symbol(s);
	interned[s] = sym;
      }
      return sym;
    }

    private Symbol(string s) : base(s) {
    }

    public override bool Equals(Reference o) {
      if(o is Symbol)
	return this == o;
      else if(o is String)
	return ((String)o).S == this.S;
      else return false;
    }

  }

  public class String : Reference {
    public string S;
    public uint hash;
  
    public String(string s) {	
      this.S = s;
      this.hash = (uint)this.S.GetHashCode();
    }

    public override int GetHashCode() { return (int)hash; }

    public override string ToString() { return this.S; }

    public override bool Equals(Reference o) {
      return (o is String) && ((String)o).S == this.S;
    }
    public override bool LessThan(Reference o) {
      return ((o is String) && (string.Compare(((String)o).S, this.S) < 0));
    }
    public override bool LessThanOrEquals(Reference o) {
      return ((o is String) && (string.Compare(((String)o).S, this.S) <= 0));
    }

    public override object[] InvokeM(object[] args) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM() {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5, object a6) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5, object a6,
				    object a7) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object[] args) {
      throw new Exception("not supported");
    }
    public override object InvokeS() {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2, object a3) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5, object a6) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5, object a6,
				  object a7) {
      throw new Exception("not supported");
    }

    public override object Length() {
      return (double)S.Length;
    }

    public override object this[object key] { 
      get {
      throw new Exception("not supported");
      }
      set {
      throw new Exception("not supported");
      }
    }
    
    public override Table Metatable { 
      get {
      throw new Exception("not supported");
      }
      set {
      throw new Exception("not supported");
      }
    }
    
  }
}