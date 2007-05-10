using System;

namespace Lua {
  public class String : Reference {
    public string S;

    public String(string s) {
      this.S = s;
    }

    public override int GetHashCode() { return this.S.GetHashCode(); }

    public override string ToString() { return this.S; }

    public override bool Equals(Reference o) {
      return ((o is String) && (((String)o).S == this.S));
    }
    public override bool LessThan(Reference o) {
      return ((o is String) && (string.Compare(((String)o).S, this.S) < 0));
    }
    public override bool LessThanOrEqual(Reference o) {
      return ((o is String) && (string.Compare(((String)o).S, this.S) <= 0));
    }

    public override Value[] Invoke(Value[] args) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke() {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5, Value a6) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5, Value a6,
				   Value a7) {
      throw new Exception("not supported");
    }

    public override Value Length() {
      Value v;
      v.O = null;
      v.N = S.Length;
      return v;
    }

    public override Value this[Value key] { 
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