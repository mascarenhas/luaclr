using System;

namespace Lua {
  public abstract class Singleton : Reference {
    public override bool Equals(Reference o) {
      return (o == this);
    }
    public override bool LessThan(Reference o) {
      throw new Exception("not supported");
    }
    public override bool LessThanOrEqual(Reference o) {
      throw new Exception("not supported");
    }

    public override Value[] Invoke(Value[] args) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke() {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5, Value a6) {
      throw new Exception("not supported");
    }
    public override Value[] Invoke(Value a1, Value a2, Value a3,
				   Value a4, Value a5, Value a6,
				   Value a7) {
      throw new Exception("not supported");
    }

    public override Value Length() {
      throw new Exception("not supported");
    }

    public override Value this[Value key] { 
      get {
      throw new Exception("not supported");
      }
      set {
      throw new Exception("not supported");
      }
    }
    
    public override Table Metatable { 
      get {
      throw new Exception("not supported");
      }
      set {
      throw new Exception("not supported");
      }
    }
  }

  public class Nil : Singleton {
    public static readonly Reference Instance = new Nil();

    public Nil() { }
  }

  public class True : Singleton {
    public static readonly Reference Instance = new True();

    public True() { }
  }

  public class False : Singleton {
    public static readonly Reference Instance = new False();

    public False() { }
  }
}