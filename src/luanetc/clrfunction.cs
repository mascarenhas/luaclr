using System;

namespace Lua {
  public abstract class CLRFunction : Closure {

    public override object[] InvokeM(object[] args) {
      return this.Invoke(args);
    }
    public override object[] InvokeM() {
      return this.Invoke(new object[] {});
    }
    public override object[] InvokeM(object a1) {
      return this.Invoke(new object[] { a1 });
    }
    public override object[] InvokeM(object a1, object a2) {
      return this.Invoke(new object[] { a1, a2 });
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      return this.Invoke(new object[] { a1, a2, a3 });
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4) {
      return this.Invoke(new object[] { a1, a2, a3, a4 });
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5) {
      return this.Invoke(new object[] { a1, a2, a3, a4, a5 });
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5, object a6) {
      return this.Invoke(new object[] { a1, a2, a3, a4, a5, a6 });
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5, object a6,
				    object a7) {
      return this.Invoke(new object[] { a1, a2, a3, a4, a5, a6, a7 });
    }
    public override object InvokeS(object[] args) {
      object[] r = this.Invoke(args);
      return r.Length > 0 ? r[0] : new object();
    }
    public override object InvokeS() {
      object[] r = this.Invoke(new object[] {});
      return r.Length > 0 ? r[0] : new object();
    }
    public override object InvokeS(object a1) {
      object[] r = this.Invoke(new object[] { a1 });
      return r.Length > 0 ? r[0] : new object();
    }
    public override object InvokeS(object a1, object a2) {
      object[] r = this.Invoke(new object[] { a1, a2 });
      return r.Length > 0 ? r[0] : new object();
    }
    public override object InvokeS(object a1, object a2, object a3) {
      object[] r = this.Invoke(new object[] { a1, a2, a3 });
      return r.Length > 0 ? r[0] : new object();
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4) {
      object[] r = this.Invoke(new object[] { a1, a2, a3, a4 });
      return r.Length > 0 ? r[0] : new object();
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5) {
      object[] r = this.Invoke(new object[] { a1, a2, a3, a4, a5 });
      return r.Length > 0 ? r[0] : new object();
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5, object a6) {
      object[] r = this.Invoke(new object[] { a1, a2, a3, a4, a5, a6 });
      return r.Length > 0 ? r[0] : new object();
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5, object a6,
				  object a7) {
      object[] r = this.Invoke(new object[] { a1, a2, a3, a4, a5, a6, a7 });
      return r.Length > 0 ? r[0] : new object();
    }
    
  }
}