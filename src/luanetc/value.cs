using System;

namespace Lua {
  public struct Value {
    public double N;
    public Reference O;

    public static bool operator==(Value v1, Value v2) {
      if(v1.O == null && v2.O == null)
	return v1.N == v2.N;
      else
	return v1.O == v2.O;
    }

    public override string ToString() {
      if(this.O == null)
	return this.N.ToString();
      else
	return this.O.ToString();
    }

    public static bool operator!=(Value v1, Value v2) {
      return !(v1 == v2);
    }

    public override bool Equals(object o) {
      return (o is Value) && ((Value)o == this);
    }

    public override int GetHashCode() {
      if(this.O == null)
	return this.N.GetHashCode();
      else
	return this.O.GetHashCode();
    }

    static Table Meta;

    public Table Metatable {
      get {
	if(this.O == null)
	  return Value.Meta;
	else
	  return this.O.Metatable;
      }
      set {
	if(this.O == null)
	  Value.Meta = value;
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
	if(this.O == null)
	  throw new Exception("you cannot index a number");
	return this.O[key];
      }
      set {
	if(this.O == null)
	  throw new Exception("you cannot index a number");
	this.O[key] = value;
      }
    }

    public Value[] Invoke(Value[] args) {
      if(this.O == null)
	throw new Exception("you cannot call a number");
      return this.O.Invoke(args);
    }
    public Value[] Invoke() {
      if(this.O == null)
	throw new Exception("you cannot call a number");
      return this.O.Invoke();
    }
    public Value[] Invoke(Value a1) {
      if(this.O == null)
	throw new Exception("you cannot call a number");
      return this.O.Invoke(a1);
    }
    public Value[] Invoke(Value a1, Value a2) {
      if(this.O == null)
	throw new Exception("you cannot call a number");
      return this.O.Invoke(a1, a2);
    }
    public Value[] Invoke(Value a1, Value a2, Value a3) {
      if(this.O == null)
	throw new Exception("you cannot call a number");
      return this.O.Invoke(a1, a2, a3);
    }
    public Value[] Invoke(Value a1, Value a2, Value a3, Value a4) {
      if(this.O == null)
	throw new Exception("you cannot call a number");
      return this.O.Invoke(a1, a2, a3, a4);
    }
    public Value[] Invoke(Value a1, Value a2, Value a3, Value a4, Value a5) {
      if(this.O == null)
	throw new Exception("you cannot call a number");
      return this.O.Invoke(a1, a2, a3, a4, a5);
    }
    public Value[] Invoke(Value a1, Value a2, Value a3, Value a4, Value a5,
			  Value a6) {
      if(this.O == null)
	throw new Exception("you cannot call a number");
      return this.O.Invoke(a1, a2, a3, a4, a5, a6);
    }
    public Value[] Invoke(Value a1, Value a2, Value a3, Value a4, Value a5,
			  Value a6, Value a7) {
      if(this.O == null)
	throw new Exception("you cannot call a number");
      return this.O.Invoke(a1, a2, a3, a4, a5, a6, a7);
    }
  }
}
