using System;

namespace Lua {
  public abstract class Reference {
    public static Value Add(Value v1, Value v2) { }
    public static Value Add(double v1, Value v2) { }
    public static Value Subtract(Value v1, Value v2) { }
    public static Value Subtract(double v1, Value v2) { }
    public static Value Multiply(Value v1, Value v2) { }
    public static Value Multiply(double v1, Value v2) { }
    public static Value Divide(Value v1, Value v2) { }
    public static Value Divide(double v1, Value v2) { }
    public static Value Mod(Value v1, Value v2) { }
    public static Value Mod(double v1, Value v2) { }
    public static Value Pow(Value v1, Value v2) { }
    public static Value Pow(double v1, Value v2) { }
    public static Value Negate(Value v) { }

    public static Value Equal(Value v1, Value v2) {
      return v1.O.Equals(v2.O);
    }
    public static Value NotEqual(Value v1, Value v2) {
      Value v = v1.O.Equals(v2.O);
      if(v.O = True.Instance.O)
	v.O = False.Instance.O;
      else
	v.O = True.Instance.O;
      return v;
    }
    public static Value LessThan(Value v1, Value v2) {
      return v1.O.LessThan(v2.O);
    }
    public static Value LessThanOrEqual(Value v1, Value v2) {
      return v1.O.LessThanOrEqual(v2.O);
    }
    public static Value GreaterThan(Value v1, Value v2) {
      Value v = v1.O.LessThanOrEqual(v2.O);
      if(v.O = True.Instance.O)
	v.O = False.Instance.O;
      else
	v.O = True.Instance.O;
      return v;
    }
    public static Value GreaterThanorEqual(Value v1, Value v2) {
      Value v = v1.O.LessThan(v2.O);
      if(v.O = True.Instance.O)
	v.O = False.Instance.O;
      else
	v.O = True.Instance.O;
      return v;
    }

    public abstract Value Equals(Reference o);
    public abstract Value LessThan(Reference o);
    public abstract Value LessThanOrEqual(Reference o);

    public abstract Value[] Invoke(Value[] args);
    public abstract Value[] Invoke();
    public abstract Value[] Invoke(Value a1);
    public abstract Value[] Invoke(Value a1, Value a2);
    public abstract Value[] Invoke(Value a1, Value a2, Value a3);
    public abstract Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4);
    public abstract Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5);
    public abstract Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5, Value a6);
    public abstract Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5, Value a6,
				   Value a7);

    public abstract Value Length();

    public abstract Value this[Value key] { get; set; }

    public abstract Table Metatable { get; set; }
  }
}