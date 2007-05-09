using System;

namespace Lua {
  public struct Value {
    public double N;
    public Reference O;

    public static Table Metatable = Nil.Instance;

    public Table Metatable {
      get {
	if(this.O == null)
	  return Value.Metatable;
	else
	  return this.O.Metatable;
      }
      set {
	if(this.O == null)
	  Value.Metatable = value;
	else
	  this.O.Metatable = value;
      }
    }

    public static Value Length(Value v) {
      if(v.O == null)
	throw new Exception("numbers do not have length");
      return v.O.Length();
    }

    public Value this[Value key] {
      get {
	if(v.O == null)
	  throw new Exception("you cannot index a number");
	return v.O[key];
      }
      set {
	if(v.O == null)
	  throw new Exception("you cannot index a number");
	v.O[key] = value;
      }
    }

    public Value[] Invoke(Value[] args) {
      if(v.O == null)
	throw new Exception("you cannot call a number");
      return v.O.Invoke(args);
    }
    public Value[] Invoke() {
      if(v.O == null)
	throw new Exception("you cannot call a number");
      return v.O.Invoke();
    }
    public Value[] Invoke(Value a1) {
      if(v.O == null)
	throw new Exception("you cannot call a number");
      return v.O.Invoke(a1);
    }
    public Value[] Invoke(Value a1, Value a2) {
      if(v.O == null)
	throw new Exception("you cannot call a number");
      return v.O.Invoke(a1, a2);
    }
    public Value[] Invoke(Value a1, Value a2, Value a3) {
      if(v.O == null)
	throw new Exception("you cannot call a number");
      return v.O.Invoke(a1, a2, a3);
    }
    public Value[] Invoke(Value a1, Value a2, Value a3, Value a4) {
      if(v.O == null)
	throw new Exception("you cannot call a number");
      return v.O.Invoke(a1, a2, a3, a4);
    }
    public Value[] Invoke(Value a1, Value a2, Value a3, Value a4, Value a5) {
      if(v.O == null)
	throw new Exception("you cannot call a number");
      return v.O.Invoke(a1, a2, a3, a4, a5);
    }
    public Value[] Invoke(Value a1, Value a2, Value a3, Value a4, Value a5,
			  Value a6) {
      if(v.O == null)
	throw new Exception("you cannot call a number");
      return v.O.Invoke(a1, a2, a3, a4, a5, a6);
    }
    public Value[] Invoke(Value a1, Value a2, Value a3, Value a4, Value a5,
			  Value a6, Value a7) {
      if(v.O == null)
	throw new Exception("you cannot call a number");
      return v.O.Invoke(a1, a2, a3, a4, a5, a6, a7);
    }
  }
}
