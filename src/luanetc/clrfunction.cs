using System;

namespace Lua {
  public abstract class CLRFunction : Closure {

    public override Value[] Invoke() {
      return this.Invoke(new Value[] {});
    }
    public override Value[] Invoke(Value a1) {
      return this.Invoke(new Value[] { a1 });
    }
    public override Value[] Invoke(Value a1, Value a2) {
      return this.Invoke(new Value[] { a1, a2 });
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3) {
      return this.Invoke(new Value[] { a1, a2, a3 });
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4) {
      return this.Invoke(new Value[] { a1, a2, a3, a4 });
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5) {
      return this.Invoke(new Value[] { a1, a2, a3, a4, a5 });
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5, Value a6) {
      return this.Invoke(new Value[] { a1, a2, a3, a4, a5, a6 });
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5, Value a6,
				   Value a7) {
      return this.Invoke(new Value[] { a1, a2, a3, a4, a5, a6, a7 });
    }
    
  }
}