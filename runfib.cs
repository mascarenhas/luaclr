using Lua;
using System;
using foo;

public class runfib {
  public static void Main(string[] args) {
    Table env = new Table();
    Value k, v;
    k.N = 0;
    k.O = new Lua.String("print");
    v.N = 0;
    v.O = new Print();
    env[k] = v;
    Lua.String s = new Lua.String("tonumber");
    k.O = s;
    v.O = new ToNumber();
    env[k] = v;
    k.O = new Lua.String("os");
    Table os = new Table();
    v.O = os;
    env[k] = v;
    k.O = new Lua.String("clock");
    v.O = new Clock();
    os[k] = v;
    function1 f = new function1();
    f.Env = env;
    f.Invoke();
  }
}
