using System;

namespace Lua {
  public class String : Reference {
    public string S;

    public String(string s) {
      this.S = s;
    }

    public override int GetHashCode() { return this.S.GetHashCode(); }

    public override string ToString() { return this.S; }

    public override bool Equals(Reference o) {
      return ((o is String) && (((String)o).S == this.S));
    }
    public override bool LessThan(Reference o) {
      return ((o is String) && (string.Compare(((String)o).S, this.S) < 0));
    }
    public override bool LessThanOrEquals(Reference o) {
      return ((o is String) && (string.Compare(((String)o).S, this.S) <= 0));
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
      return (double)S.Length;
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
}