using System;

namespace Lua {
  public class String : Reference {
    public string S;

    public String(string s) {
      this.S = s;
    }

    public override Value Equals(Reference o) {
      Value v;
      if((o instanceof String) && (((String)o).S == this.S))
	v.O = True.Instance;
      else
	v.O = False.Instance;
      return v;
    }
    public override Value LessThan(Reference o) {
      Value v;
      if((o instanceof String) && (((String)o).S < this.S))
	v.O = True.Instance;
      else
	v.O = False.Instance;
      return v;
    }
    public override Value LessThanOrEqual(Reference o) {
      Value v;
      if((o instanceof String) && (((String)o).S <= this.S))
	v.O = True.Instance;
      else
	v.O = False.Instance;
      return v;
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
      v.N = S.Length();
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