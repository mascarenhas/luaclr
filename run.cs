using Lua;
using System;
using System.Reflection;

public class run {
  public static void Main(string[] args) {
    Table env = new Table();
    Symbol k;
    object v;

    k = Lua.Symbol.Intern("print");
    v = new Print();
    env[k] = v;

    k = Lua.Symbol.Intern("setmetatable");
    v = new SetMetatable();
    env[k] = v;

    k = Lua.Symbol.Intern("pairs");
    v = new Pairs();
    env[k] = v;

    Lua.Symbol s = Lua.Symbol.Intern("tonumber");
    k = s;
    v = new ToNumber();
    env[k] = v;

    k = Lua.Symbol.Intern("os");
    Table os = new Table();
    v = os;
    env[k] = v;
    k = Lua.Symbol.Intern("clock");
    v = new Clock();
    os[k] = v;

    k = Lua.Symbol.Intern("io");
    Table io = new Table();
    v = io;
    env[k] = v;
    k = Lua.Symbol.Intern("write");
    v = new Write();
    io[k] = v;

    k = Lua.Symbol.Intern("math");
    Table math = new Table();
    v = math;
    env[k] = v;
    k = Lua.Symbol.Intern("floor");
    v = new Floor();
    math[k] = v;

    Closure c = (Closure)Assembly.LoadFrom(args[0] + ".dll").
      GetType(args[0] + ".function1").GetConstructor(new Type[0]).
      Invoke(new object[0]);
    c.Env = env;
    c.InvokeS();
    for(int i = 0; i <= System.GC.MaxGeneration; i++)
      Console.WriteLine(System.GC.CollectionCount(i));
  }
}
