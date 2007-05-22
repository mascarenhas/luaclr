using Lua;
using System;
using foo;

public class runfib {
  public static void Main(string[] args) {
    Table env = new Table();
    object k, v;
    k = new Lua.String("print");
    v = new Print();
    env[k] = v;
    Lua.String s = new Lua.String("tonumber");
    k = s;
    v = new ToNumber();
    env[k] = v;
    k = new Lua.String("os");
    Table os = new Table();
    v = os;
    env[k] = v;
    k = new Lua.String("clock");
    v = new Clock();
    os[k] = v;
    function1 f = new function1();
    f.Env = env;
    f.InvokeS();
  }
}
