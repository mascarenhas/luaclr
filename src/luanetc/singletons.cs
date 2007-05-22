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

    public override object[] InvokeM(object[] args) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM() {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2, object a3) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5, object a6) {
      throw new Exception("not supported");
    }
    public override object[] InvokeM(object a1, object a2, object a3,
				    object a4, object a5, object a6,
				    object a7) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object[] args) {
      throw new Exception("not supported");
    }
    public override object InvokeS() {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2, object a3) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2, object a3,
				   object a4) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2, object a3,
				   object a4, object a5) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5, object a6) {
      throw new Exception("not supported");
    }
    public override object InvokeS(object a1, object a2, object a3,
				  object a4, object a5, object a6,
				  object a7) {
      throw new Exception("not supported");
    }

    public override object Length() {
      throw new Exception("not supported");
    }

    public override object this[object key] { 
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