namespace Lua {
  public abstract class Singleton {
    public override Value Equals(Reference o) {
      Value v;
      if(o == this)
	v.O = True.Instance;
      else
	v.O = False.Instance;
      return v;
    }
    public override Value LessThan(Reference o) {
      throw new Exception("not supported");
    }
    public override Value LessThanOrEqual(Reference o) {
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
    public static readonly Value Instance;

    static Nil() {
      Value v;
      v.O = new Nil();
      Instance = v;
    }

    public Nil() { }
  }

  public class True : Singleton {
    public static readonly Value Instance;

    static True() {
      Value v;
      v.O = new True();
      Instance = v;
    }

    public True() { }
  }

  public class False : Singleton {
    public static readonly Value Instance;

    static False() {
      Value v;
      v.O = new False();
      Instance = v;
    }

    public False() { }
  }
}