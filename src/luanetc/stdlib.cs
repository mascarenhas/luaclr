using System;

namespace Lua {
  public class Print : CLRFunctionN {
    public override object[] InvokeM(object[] args) {
      return new object[] { this.InvokeS(args) };
    }
    public override object InvokeS(object[] args) {
      for(int i = 0; i < args.Length - 1; i++) {
	Console.Write(args[i].ToString());
	Console.Write("\t");
      }
      if(args.Length > 0) {
	Console.Write(args[args.Length - 1].ToString());
      }
      Console.WriteLine();
      return Nil.Instance;
    }
  }

  public class Write : CLRFunctionN {
    public override object[] InvokeM(object[] args) {
      return new object[] { this.InvokeS(args) };
    }
    public override object InvokeS(object[] args) {
      for(int i = 0; i < args.Length; i++) {
	Console.Write(args[i].ToString());
      }
      return Nil.Instance;
    }
  }

  public class ToNumber : CLRFunction1 {
    public override object InvokeS(object o) {
      if(!(o is double)) o = 0;
      return o;
    }
    public override object[] InvokeM(object o) {
      if(!(o is double)) o = 0;
      return new object[]{ o };
    }
  }

  public class Floor : CLRFunction1 {
    public override object InvokeS(object o) {
      return (object)Math.Floor((double)o);
    }
    public override object[] InvokeM(object o) {
      return new object[]{ this.InvokeS(o) };
    }
  }

  public class Clock : CLRFunction0 {
    public override object InvokeS() {
      return ((double)(DateTime.Now.Ticks))/((double)10000000);
    }
    public override object[] InvokeM() {
      return new object[] { ((double)(DateTime.Now.Ticks))/((double)10000000) };
    }
  }
  
  public class Pairs : CLRFunction1 {
    public override object InvokeS(object t) {
      return this.InvokeM(t)[0];
    }
    public override object[] InvokeM(object t) {
      object[] res = new object[3];
      res[0] = new Next();
      res[1] = t;
      res[2] = Nil.Instance;
      return res;
    }
  }

  public class SetMetatable : CLRFunction2 {
    public override object InvokeS(object t, object m) {
      Reference r = (Reference)t;
      if(m != Nil.Instance)
	r.Metatable = (Table)m;
      else
	r.Metatable = null;
      return Nil.Instance;
    }
    public override object[] InvokeM(object t, object m) {
      return new object[] { this.InvokeS(t, m) };
    }
  }

  public class Next: CLRFunction2 {
    public override object InvokeS(object t, object k) {
      return this.InvokeM(t, k)[0];
    }
    public override object[] InvokeM(object t, object k) {
      Table tab = (Table)t;
      object v;
      tab.Next(ref k, out v);
      if(v == Nil.Instance)
	return new object[] { k };
      else
	return new object[] { k, v };
    }
  }
}
