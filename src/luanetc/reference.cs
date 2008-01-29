using System;

namespace Lua {
  public abstract class Reference {

    public static object Concat(object o1, object o2) {
      if(o1 is String) {
	if(o2 is String) {
	  return new String(((String)o1).S + ((String)o2).S);
	} else if(o2 is double) {
	  return new String(((String)o1).S + o2.ToString());
	} else {
	  throw new Exception("not implemented");
	}
      } else if(o1 is double) {
	if(o2 is String) {
	  return new String(o1.ToString() + ((String)o2).S);
	} else if(o2 is double) {
	  return new String(o1.ToString() + o2.ToString());
	} else {
	  throw new Exception("not implemented");
	}
      } else throw new Exception("not implemented");
    }

    public object Add(object o) { throw new Exception("not implemented"); }
    public object Subtract(object o) { throw new Exception("not implemented"); }
    public object Multiply(object o) { throw new Exception("not implemented"); }
    public object Divide(object o) { throw new Exception("not implemented"); }
    public object Mod(object o) { throw new Exception("not implemented"); }
    public object Pow(object o) { throw new Exception("not implemented"); }

    public object Add(double o) { throw new Exception("not implemented"); }
    public object Subtract(double o) { throw new Exception("not implemented"); }
    public object Multiply(double o) { throw new Exception("not implemented"); }
    public object Divide(double o) { throw new Exception("not implemented"); }
    public object Mod(double o) { throw new Exception("not implemented"); }
    public object Pow(double o) { throw new Exception("not implemented"); }

    public object Negate() { throw new Exception("not implemented"); }

    public abstract bool Equals(Reference o);
    public abstract bool LessThan(Reference o);
    public abstract bool LessThanOrEquals(Reference o);

    public bool NotEquals(Reference o) {
      return !this.Equals(o);
    }
    public bool GreaterThan(Reference o) {
      return !this.LessThanOrEquals(o);
    }
    public bool GreaterThanOrEquals(Reference o) {
      return !this.LessThan(o);
    }

    public virtual object[] Invoke(object[] args) {
      return ((Reference)this).InvokeM(args);
    }

    public abstract object[] InvokeM(object[] args);
    public abstract object[] InvokeM();
    public abstract object[] InvokeM(object a1);
    public abstract object[] InvokeM(object a1, object a2);
    public abstract object[] InvokeM(object a1, object a2, object a3);
    public abstract object[] InvokeM(object a1, object a2, object a3,
				   object a4);
    public abstract object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5);
    public abstract object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5, object a6);
    public abstract object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5, object a6,
				    object a7);
    public abstract object InvokeS(object[] args);
    public abstract object InvokeS();
    public abstract object InvokeS(object a1);
    public abstract object InvokeS(object a1, object a2);
    public abstract object InvokeS(object a1, object a2, object a3);
    public abstract object InvokeS(object a1, object a2, object a3,
				  object a4);
    public abstract object InvokeS(object a1, object a2, object a3,
				  object a4, object a5);
    public abstract object InvokeS(object a1, object a2, object a3,
				  object a4, object a5, object a6);
    public abstract object InvokeS(object a1, object a2, object a3,
				  object a4, object a5, object a6,
				  object a7);

    public abstract object Length();

    public abstract object this[object key] { get; set; }

    public abstract Table Metatable { get; set; }
  }
}