using System;

namespace Lua {
  public abstract class CLRFunctionN : Closure {

    public override object[] InvokeM() {
      return this.InvokeM(new object[] {});
    }
    public override object[] InvokeM(object a1) {
      return this.InvokeM(new object[] { a1 });
    }
    public override object[] InvokeM(object a1, object a2) {
      return this.InvokeM(new object[] { a1, a2 });
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      return this.InvokeM(new object[] { a1, a2, a3 });
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4) {
      return this.InvokeM(new object[] { a1, a2, a3, a4 });
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5) {
      return this.InvokeM(new object[] { a1, a2, a3, a4, a5 });
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5, object a6) {
      return this.InvokeM(new object[] { a1, a2, a3, a4, a5, a6 });
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5, object a6,
				    object a7) {
      return this.InvokeM(new object[] { a1, a2, a3, a4, a5, a6, a7 });
    }
    public override object InvokeS() {
      return this.InvokeS(new object[] {});
    }
    public override object InvokeS(object a1) {
      return this.InvokeS(new object[] { a1 });
    }
    public override object InvokeS(object a1, object a2) {
      return this.InvokeS(new object[] { a1, a2 });
    }
    public override object InvokeS(object a1, object a2, object a3) {
      return this.InvokeS(new object[] { a1, a2, a3 });
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4) {
      return this.InvokeS(new object[] { a1, a2, a3, a4 });
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5) {
      return this.InvokeS(new object[] { a1, a2, a3, a4, a5 });
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5, object a6) {
      return this.InvokeS(new object[] { a1, a2, a3, a4, a5, a6 });
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5, object a6,
				  object a7) {
      return this.InvokeS(new object[] { a1, a2, a3, a4, a5, a6, a7 });
    }
  }    
  public abstract class CLRFunction0 : Closure {

    public override object[] InvokeM(object[] args) {
      int l = args.Length - 1;
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1) {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1, object a2) {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4) {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeM();
    }
    public override object InvokeS(object[] args) {
      int l = args.Length - 1;
      return this.InvokeS();
    }
    public override object InvokeS(object a1) {
      return this.InvokeS();
    }
    public override object InvokeS(object a1, object a2) {
      return this.InvokeS();
    }
    public override object InvokeS(object a1, object a2, object a3) {
      return this.InvokeS();
    }
    public override object InvokeS(object a1, object a2, object a3, object a4) {
      return this.InvokeS();
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeS();
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeS();
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeS();
    }
  }
  public abstract class CLRFunction1 : Closure {

    public override object[] InvokeM(object[] args) {
      int l = args.Length - 1;
      return this.InvokeM(0>l?null:args[0]);
    }
    public override object[] InvokeM() {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1, object a2) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeM(a1);
    }
    public override object InvokeS(object[] args) {
      int l = args.Length - 1;
      return this.InvokeS(0>l?null:args[0]);
    }
    public override object InvokeS() {
      return this.InvokeS();
    }
    public override object InvokeS(object a1, object a2) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2, object a3) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeS(a1);
    }
  }
  public abstract class CLRFunction2 : Closure {

    public override object[] InvokeM(object[] args) {
      int l = args.Length - 1;
      return this.InvokeM(0>l?null:args[0], 1>l?null:args[1]);
    }
    public override object[] InvokeM() {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      return this.InvokeM(a1, a2);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4) {
      return this.InvokeM(a1, a2);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeM(a1, a2);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeM(a1, a2);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeM(a1, a2);
    }
    public override object InvokeS(object[] args) {
      int l = args.Length - 1;
      return this.InvokeS(0>l?null:args[0], 1>l?null:args[1]);
    }
    public override object InvokeS() {
      return this.InvokeS();
    }
    public override object InvokeS(object a1) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2, object a3) {
      return this.InvokeS(a1, a2);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4) {
      return this.InvokeS(a1, a2);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeS(a1, a2);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeS(a1, a2);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeS(a1, a2);
    }
  }
  public abstract class CLRFunction3 : Closure {

    public override object[] InvokeM(object[] args) {
      int l = args.Length - 1;
      return this.InvokeM(0>l?null:args[0], 1>l?null:args[1], 2>l?null:args[2]);
    }
    public override object[] InvokeM() {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2) {
      return this.InvokeM(a1, a2);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4) {
      return this.InvokeM(a1, a2, a3);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeM(a1, a2, a3);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeM(a1, a2, a3);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeM(a1, a2, a3);
    }
    public override object InvokeS(object[] args) {
      int l = args.Length - 1;
      return this.InvokeS(0>l?null:args[0], 1>l?null:args[1], 2>l?null:args[2]);
    }
    public override object InvokeS() {
      return this.InvokeS();
    }
    public override object InvokeS(object a1) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2) {
      return this.InvokeS(a1, a2);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4) {
      return this.InvokeS(a1, a2, a3);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeS(a1, a2, a3);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeS(a1, a2, a3);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeS(a1, a2, a3);
    }
  }
  public abstract class CLRFunction4 : Closure {

    public override object[] InvokeM(object[] args) {
      int l = args.Length - 1;
      return this.InvokeM(0>l?null:args[0], 1>l?null:args[1], 2>l?null:args[2], 3>l?null:args[3]);
    }
    public override object[] InvokeM() {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2) {
      return this.InvokeM(a1, a2);
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      return this.InvokeM(a1, a2, a3);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeM(a1, a2, a3, a4);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeM(a1, a2, a3, a4);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeM(a1, a2, a3, a4);
    }
    public override object InvokeS(object[] args) {
      int l = args.Length - 1;
      return this.InvokeS(0>l?null:args[0], 1>l?null:args[1], 2>l?null:args[2], 3>l?null:args[3]);
    }
    public override object InvokeS() {
      return this.InvokeS();
    }
    public override object InvokeS(object a1) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2) {
      return this.InvokeS(a1, a2);
    }
    public override object InvokeS(object a1, object a2, object a3) {
      return this.InvokeS(a1, a2, a3);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeS(a1, a2, a3, a4);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeS(a1, a2, a3, a4);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeS(a1, a2, a3, a4);
    }
  }
  public abstract class CLRFunction5 : Closure {

    public override object[] InvokeM(object[] args) {
      int l = args.Length - 1;
      return this.InvokeM(0>l?null:args[0], 1>l?null:args[1], 2>l?null:args[2], 3>l?null:args[3], 4>l?null:args[4]);
    }
    public override object[] InvokeM() {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2) {
      return this.InvokeM(a1, a2);
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      return this.InvokeM(a1, a2, a3);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4) {
      return this.InvokeM(a1, a2, a3, a4);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeM(a1, a2, a3, a4, a5);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeM(a1, a2, a3, a4, a5);
    }
    public override object InvokeS(object[] args) {
      int l = args.Length - 1;
      return this.InvokeS(0>l?null:args[0], 1>l?null:args[1], 2>l?null:args[2], 3>l?null:args[3], 4>l?null:args[4]);
    }
    public override object InvokeS() {
      return this.InvokeS();
    }
    public override object InvokeS(object a1) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2) {
      return this.InvokeS(a1, a2);
    }
    public override object InvokeS(object a1, object a2, object a3) {
      return this.InvokeS(a1, a2, a3);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4) {
      return this.InvokeS(a1, a2, a3, a4);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeS(a1, a2, a3, a4, a5);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeS(a1, a2, a3, a4, a5);
    }
  }
  public abstract class CLRFunction6 : Closure {

    public override object[] InvokeM(object[] args) {
      int l = args.Length - 1;
      return this.InvokeM(0>l?null:args[0], 1>l?null:args[1], 2>l?null:args[2], 3>l?null:args[3], 4>l?null:args[4], 5>l?null:args[5]);
    }
    public override object[] InvokeM() {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2) {
      return this.InvokeM(a1, a2);
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      return this.InvokeM(a1, a2, a3);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4) {
      return this.InvokeM(a1, a2, a3, a4);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeM(a1, a2, a3, a4, a5);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeM(a1, a2, a3, a4, a5, a6);
    }
    public override object InvokeS(object[] args) {
      int l = args.Length - 1;
      return this.InvokeS(0>l?null:args[0], 1>l?null:args[1], 2>l?null:args[2], 3>l?null:args[3], 4>l?null:args[4], 5>l?null:args[5]);
    }
    public override object InvokeS() {
      return this.InvokeS();
    }
    public override object InvokeS(object a1) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2) {
      return this.InvokeS(a1, a2);
    }
    public override object InvokeS(object a1, object a2, object a3) {
      return this.InvokeS(a1, a2, a3);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4) {
      return this.InvokeS(a1, a2, a3, a4);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeS(a1, a2, a3, a4, a5);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6, object a7) {
      return this.InvokeS(a1, a2, a3, a4, a5, a6);
    }
  }
  public abstract class CLRFunction7 : Closure {

    public override object[] InvokeM(object[] args) {
      int l = args.Length - 1;
      return this.InvokeM(0>l?null:args[0], 1>l?null:args[1], 2>l?null:args[2], 3>l?null:args[3], 4>l?null:args[4], 5>l?null:args[5], 6>l?null:args[6]);
    }
    public override object[] InvokeM() {
      return this.InvokeM();
    }
    public override object[] InvokeM(object a1) {
      return this.InvokeM(a1);
    }
    public override object[] InvokeM(object a1, object a2) {
      return this.InvokeM(a1, a2);
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      return this.InvokeM(a1, a2, a3);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4) {
      return this.InvokeM(a1, a2, a3, a4);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeM(a1, a2, a3, a4, a5);
    }
    public override object[] InvokeM(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeM(a1, a2, a3, a4, a5, a6);
    }
    public override object InvokeS(object[] args) {
      int l = args.Length - 1;
      return this.InvokeS(0>l?null:args[0], 1>l?null:args[1], 2>l?null:args[2], 3>l?null:args[3], 4>l?null:args[4], 5>l?null:args[5], 6>l?null:args[6]);
    }
    public override object InvokeS() {
      return this.InvokeS();
    }
    public override object InvokeS(object a1) {
      return this.InvokeS(a1);
    }
    public override object InvokeS(object a1, object a2) {
      return this.InvokeS(a1, a2);
    }
    public override object InvokeS(object a1, object a2, object a3) {
      return this.InvokeS(a1, a2, a3);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4) {
      return this.InvokeS(a1, a2, a3, a4);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5) {
      return this.InvokeS(a1, a2, a3, a4, a5);
    }
    public override object InvokeS(object a1, object a2, object a3, object a4, object a5, object a6) {
      return this.InvokeS(a1, a2, a3, a4, a5, a6);
    }
  }
}
