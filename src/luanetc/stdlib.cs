using System;

namespace Lua {
  public class Print : CLRFunction {
    public override object[] Invoke(object[] args) {
      for(int i = 0; i < args.Length - 1; i++) {
	Console.Write(args[i]);
	Console.Write("\t");
      }
      if(args.Length > 0) {
	Console.Write(args[args.Length - 1]);
      }
      Console.WriteLine();
      return new object[] { Nil.Instance };
    }
  }

  public class ToNumber : CLRFunction {
    public override object[] Invoke(object[] args) {
      object o = args[0];
      if(!(o is double)) o = 0;
      return new object[] { o };
    }
  }

  public class Clock : CLRFunction {
    public override object[] Invoke(object[] args) {
      return new object[] { ((double)(DateTime.Now.Ticks))/((double)10000000) };
    }
  }
}
