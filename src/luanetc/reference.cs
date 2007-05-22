using System;

namespace Lua {
  public abstract class Reference {

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

    public abstract bool Equals(Reference o);
    public abstract bool LessThan(Reference o);
    public abstract bool LessThanOrEqual(Reference o);

    public bool NotEqual(Reference o) {
      return !this.Equals(o);
    }
    public bool GreaterThan(Reference o) {
      return !this.LessThanOrEqual(o);
    }
    public bool GreaterThanOrEqual(Reference o) {
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