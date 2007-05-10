using System;

namespace Lua {
  public class Print : CLRFunction {
    public override Value[] Invoke(Value[] args) {
      for(int i = 0; i < args.Length - 1; i++) {
	Console.Write(args[i]);
	Console.Write("\t");
      }
      if(args.Length > 0) {
	Console.Write(args[args.Length - 1]);
      }
      Console.WriteLine();
      Value v;
      v.O = Nil.Instance;
      v.N = 0;
      return new Value[] { v };
    }
  }

  public class ToNumber : CLRFunction {
    public override Value[] Invoke(Value[] args) {
      Value v;
      v.O = null;
      v.N = args[0].N;
      return new Value[] { v };
    }
  }

  public class Clock : CLRFunction {
    public override Value[] Invoke(Value[] args) {
      Value v;
      v.O = null;
      v.N = ((double)(DateTime.Now.Ticks))/((double)10000000);
      return new Value[] { v };
    }
  }
}
