.assembly extern lua
{
  .ver 0:0:0:0
}
.assembly fib {}
.class public auto ansi beforefieldinit foo.function1 extends [lua]Lua.Closure
{
  .field public static valuetype [lua]Lua.Value LiteralNil
  .field public static valuetype [lua]Lua.Value Literal7
  .field public static valuetype [lua]Lua.Value Literal8
  .field public static valuetype [lua]Lua.Value Literal9
  .field public static valuetype [lua]Lua.Value Literal1
  .field public static valuetype [lua]Lua.Value Literal3
  .field public static valuetype [lua]Lua.Value Literal6
  .field public static valuetype [lua]Lua.Value Literal5
  .field public static valuetype [lua]Lua.Value Literal4
  .field public static valuetype [lua]Lua.Value Literal2
  .method private hidebysig specialname rtspecialname static void .cctor() cil managed
  {
  .locals init (valuetype [lua]Lua.Value V_0)
        ldloca 0
        initobj valuetype [lua]Lua.Value
        ldloca 0
        ldc.r8 1
        stfld float64 [lua]Lua.Value::N
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function1::Literal7
        ldloca 0
        ldc.r8 10
        stfld float64 [lua]Lua.Value::N
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function1::Literal8
        ldloca 0
        ldsfld class [lua]Lua.Reference [lua]Lua.True::Instance
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function1::Literal9
        ldloca 0
        ldstr "Y"
        newobj instance void [lua]Lua.String::.ctor(string)
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function1::Literal1
        ldloca 0
        ldstr "factorial"
        newobj instance void [lua]Lua.String::.ctor(string)
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function1::Literal3
        ldloca 0
        ldstr "test"
        newobj instance void [lua]Lua.String::.ctor(string)
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function1::Literal6
        ldloca 0
        ldstr "Fact 1 to 10"
        newobj instance void [lua]Lua.String::.ctor(string)
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function1::Literal5
        ldloca 0
        ldstr "print"
        newobj instance void [lua]Lua.String::.ctor(string)
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function1::Literal4
        ldloca 0
        ldstr "F"
        newobj instance void [lua]Lua.String::.ctor(string)
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function1::Literal2
        ldloca 0
        ldsfld class [lua]Lua.Reference [lua]Lua.Nil::Instance
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function1::LiteralNil
        ret 
  }
  .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
  {
        ldarg.0 
        call instance void [lua]Lua.Closure::.ctor()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1) cil managed
  {
        ldarg.0 
        call instance valuetype [lua]Lua.Value[] foo.function1::Invoke()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2) cil managed
  {
        ldarg.0 
        call instance valuetype [lua]Lua.Value[] foo.function1::Invoke()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3) cil managed
  {
        ldarg.0 
        call instance valuetype [lua]Lua.Value[] foo.function1::Invoke()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4) cil managed
  {
        ldarg.0 
        call instance valuetype [lua]Lua.Value[] foo.function1::Invoke()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5) cil managed
  {
        ldarg.0 
        call instance valuetype [lua]Lua.Value[] foo.function1::Invoke()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6) cil managed
  {
        ldarg.0 
        call instance valuetype [lua]Lua.Value[] foo.function1::Invoke()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6, valuetype [lua]Lua.Value arg7) cil managed
  {
        ldarg.0 
        call instance valuetype [lua]Lua.Value[] foo.function1::Invoke()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke() cil managed
  {
        .maxstack 12
        .locals init (valuetype [lua]Lua.Value i, valuetype [lua]Lua.Value temp_1, class [lua]Lua.Reference temp_2, valuetype [lua]Lua.Value[] temp_3, valuetype [lua]Lua.Value[] temp_4, int32 temp_5, valuetype [lua]Lua.Value temp_6, valuetype [lua]Lua.Value[] temp_7, valuetype [lua]Lua.Value temp_8)
        ldloca i
        initobj valuetype [lua]Lua.Value
        ldloca temp_1
        newobj instance void foo.function2::.ctor()
        dup 
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc temp_1
        stloc temp_1
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal1
        ldloc temp_1
        callvirt instance void [lua]Lua.Reference::set_Item(valuetype [lua]Lua.Value, valuetype [lua]Lua.Value)
        ldloca temp_1
        newobj instance void foo.function6::.ctor()
        dup 
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc temp_1
        stloc temp_1
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal2
        ldloc temp_1
        callvirt instance void [lua]Lua.Reference::set_Item(valuetype [lua]Lua.Value, valuetype [lua]Lua.Value)
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal1
        callvirt instance valuetype [lua]Lua.Value [lua]Lua.Reference::get_Item(valuetype [lua]Lua.Value)
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal2
        callvirt instance valuetype [lua]Lua.Value [lua]Lua.Reference::get_Item(valuetype [lua]Lua.Value)
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        stloc temp_4
        ldloc temp_4
        ldlen 
        stloc temp_5
        ldc.i4 0
        ldloc temp_5
        bge label1
        ldloc temp_4
        ldc.i4 0
        ldelem valuetype [lua]Lua.Value
        br label2
label1:
        ldsfld valuetype [lua]Lua.Value foo.function1::LiteralNil
label2:
        stloc temp_1
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal3
        ldloc temp_1
        callvirt instance void [lua]Lua.Reference::set_Item(valuetype [lua]Lua.Value, valuetype [lua]Lua.Value)
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal4
        callvirt instance valuetype [lua]Lua.Value [lua]Lua.Reference::get_Item(valuetype [lua]Lua.Value)
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal5
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        pop 
        ldloca temp_1
        newobj instance void foo.function8::.ctor()
        dup 
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc temp_1
        stloc temp_1
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal6
        ldloc temp_1
        callvirt instance void [lua]Lua.Reference::set_Item(valuetype [lua]Lua.Value, valuetype [lua]Lua.Value)
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal7
        stloc i
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal8
        stloc temp_1
        br label3
label4:
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal6
        callvirt instance valuetype [lua]Lua.Value [lua]Lua.Reference::get_Item(valuetype [lua]Lua.Value)
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc i
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        pop 
        ldloca temp_8
        dup 
        ldloc i
        dup 
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        brtrue label6
        ldfld float64 [lua]Lua.Value::N
        ldc.r8 1
        add 
        stfld float64 [lua]Lua.Value::N
        ldnull 
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        br label8
label6:
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal7
        call valuetype [lua]Lua.Value [lua]Lua.Reference::Add(valuetype [lua]Lua.Value, valuetype [lua]Lua.Value)
        stloc temp_8
        pop 
        pop 
        br label8
label8:
        ldloc temp_8
        stloc i
label3:
        ldloc i
        dup 
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        brtrue label10
        ldfld float64 [lua]Lua.Value::N
        ldloc temp_1
        dup 
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        brtrue label11
        ldfld float64 [lua]Lua.Value::N
        bgt label9
        ldsfld valuetype [lua]Lua.Value foo.function1::LiteralNil
        br label12
label9:
        ldsfld valuetype [lua]Lua.Value foo.function1::Literal9
        br label12
label10:
        ldloc temp_1
        call bool [lua]Lua.Reference::GreaterThan(valuetype [lua]Lua.Value, valuetype [lua]Lua.Value)
        brtrue label9
        ldsfld valuetype [lua]Lua.Value foo.function1::LiteralNil
        br label12
label11:
        pop 
        pop 
        ldsfld valuetype [lua]Lua.Value foo.function1::LiteralNil
        br label12
label12:
        stloc temp_8
        ldloc temp_8
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldsfld class [lua]Lua.Reference [lua]Lua.Nil::Instance
        beq label4
        ldloc temp_8
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldsfld class [lua]Lua.Reference [lua]Lua.False::Instance
        beq label4
label5:
        ldnull 
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value[] args) cil managed
  {
        .locals init (int32 V_0)
        ldarg.1 
        ldlen 
        stloc.0 
        ldarg.0 
        call instance valuetype [lua]Lua.Value[] foo.function1::Invoke()
        ret 
  }
}

.class public auto ansi beforefieldinit foo.function2 extends [lua]Lua.Closure
{
  .field public static valuetype [lua]Lua.Value LiteralNil
  .method private hidebysig specialname rtspecialname static void .cctor() cil managed
  {
  .locals init (valuetype [lua]Lua.Value V_0)
        ldloca 0
        initobj valuetype [lua]Lua.Value
        ldloca 0
        ldsfld class [lua]Lua.Reference [lua]Lua.Nil::Instance
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function2::LiteralNil
        ret 
  }
  .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
  {
        ldarg.0 
        call instance void [lua]Lua.Closure::.ctor()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value g) cil managed
  {
        .maxstack 12
        .locals init (valuetype [lua]Lua.Value a, valuetype [lua]Lua.Value[] g, valuetype [lua]Lua.Value temp_2, valuetype [lua]Lua.Value[] temp_3, class [lua]Lua.Reference temp_4, valuetype [lua]Lua.Value[] temp_5)
        ldloca a
        initobj valuetype [lua]Lua.Value
        ldc.i4.1 
        newarr valuetype [lua]Lua.Value
        stloc g
        ldloc g
        ldc.i4.0 
        ldarg g
        stelem valuetype [lua]Lua.Value
        ldloca temp_2
        newobj instance void foo.function3::.ctor()
        dup 
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc temp_2
        stloc a
        ldloc a
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloca temp_2
        ldloc g
        newobj instance void foo.function4::.ctor(valuetype [lua]Lua.Value[] g)
        dup 
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc temp_2
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        ret 
        ldnull 
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function2::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function2::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function2::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function2::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function2::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6, valuetype [lua]Lua.Value arg7) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function2::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke() cil managed
  {
        ldarg.0 
        ldsfld valuetype [lua]Lua.Value foo.function2::LiteralNil
        call instance valuetype [lua]Lua.Value[] foo.function2::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value[] args) cil managed
  {
        .locals init (int32 V_0)
        ldarg.1 
        ldlen 
        stloc.0 
        ldarg.0 
        ldc.i4 1
        ldloc.0 
        bgt label1
        ldarg.1 
        ldc.i4 0
        ldelem valuetype [lua]Lua.Value
        br label2
label1:
        ldsfld valuetype [lua]Lua.Value foo.function2::LiteralNil
label2:
        call instance valuetype [lua]Lua.Value[] foo.function2::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
}

.class public auto ansi beforefieldinit foo.function3 extends [lua]Lua.Closure
{
  .field public static valuetype [lua]Lua.Value LiteralNil
  .method private hidebysig specialname rtspecialname static void .cctor() cil managed
  {
  .locals init (valuetype [lua]Lua.Value V_0)
        ldloca 0
        initobj valuetype [lua]Lua.Value
        ldloca 0
        ldsfld class [lua]Lua.Reference [lua]Lua.Nil::Instance
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function3::LiteralNil
        ret 
  }
  .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
  {
        ldarg.0 
        call instance void [lua]Lua.Closure::.ctor()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value f) cil managed
  {
        .maxstack 12
        .locals init (valuetype [lua]Lua.Value[] temp_0, class [lua]Lua.Reference temp_1, valuetype [lua]Lua.Value[] temp_2)
        ldarg f
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldarg f
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        ret 
        ldnull 
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function3::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function3::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function3::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function3::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function3::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6, valuetype [lua]Lua.Value arg7) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function3::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke() cil managed
  {
        ldarg.0 
        ldsfld valuetype [lua]Lua.Value foo.function3::LiteralNil
        call instance valuetype [lua]Lua.Value[] foo.function3::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value[] args) cil managed
  {
        .locals init (int32 V_0)
        ldarg.1 
        ldlen 
        stloc.0 
        ldarg.0 
        ldc.i4 1
        ldloc.0 
        bgt label1
        ldarg.1 
        ldc.i4 0
        ldelem valuetype [lua]Lua.Value
        br label2
label1:
        ldsfld valuetype [lua]Lua.Value foo.function3::LiteralNil
label2:
        call instance valuetype [lua]Lua.Value[] foo.function3::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
}

.class public auto ansi beforefieldinit foo.function4 extends [lua]Lua.Closure
{
  .field public static valuetype [lua]Lua.Value LiteralNil
  .field public valuetype [lua]Lua.Value[] g
  .method private hidebysig specialname rtspecialname static void .cctor() cil managed
  {
  .locals init (valuetype [lua]Lua.Value V_0)
        ldloca 0
        initobj valuetype [lua]Lua.Value
        ldloca 0
        ldsfld class [lua]Lua.Reference [lua]Lua.Nil::Instance
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function4::LiteralNil
        ret 
  }
  .method public hidebysig specialname rtspecialname instance void .ctor(valuetype [lua]Lua.Value[] g) cil managed
  {
        ldarg.0 
        call instance void [lua]Lua.Closure::.ctor()
        ldarg.0 
        ldarg 1
        stfld valuetype [lua]Lua.Value[] foo.function4::g
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value f) cil managed
  {
        .maxstack 12
        .locals init (valuetype [lua]Lua.Value[] f, valuetype [lua]Lua.Value[] temp_1, class [lua]Lua.Reference temp_2, valuetype [lua]Lua.Value[] temp_3, valuetype [lua]Lua.Value temp_4)
        ldc.i4.1 
        newarr valuetype [lua]Lua.Value
        stloc f
        ldloc f
        ldc.i4.0 
        ldarg f
        stelem valuetype [lua]Lua.Value
        ldarg.0 
        ldfld valuetype [lua]Lua.Value[] foo.function4::g
        ldc.i4.0 
        ldelem valuetype [lua]Lua.Value
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloca temp_4
        ldloc f
        newobj instance void foo.function5::.ctor(valuetype [lua]Lua.Value[] f)
        dup 
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc temp_4
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        ret 
        ldnull 
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function4::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function4::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function4::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function4::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function4::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6, valuetype [lua]Lua.Value arg7) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function4::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke() cil managed
  {
        ldarg.0 
        ldsfld valuetype [lua]Lua.Value foo.function4::LiteralNil
        call instance valuetype [lua]Lua.Value[] foo.function4::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value[] args) cil managed
  {
        .locals init (int32 V_0)
        ldarg.1 
        ldlen 
        stloc.0 
        ldarg.0 
        ldc.i4 1
        ldloc.0 
        bgt label1
        ldarg.1 
        ldc.i4 0
        ldelem valuetype [lua]Lua.Value
        br label2
label1:
        ldsfld valuetype [lua]Lua.Value foo.function4::LiteralNil
label2:
        call instance valuetype [lua]Lua.Value[] foo.function4::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
}

.class public auto ansi beforefieldinit foo.function5 extends [lua]Lua.Closure
{
  .field public static valuetype [lua]Lua.Value LiteralNil
  .field public valuetype [lua]Lua.Value[] f
  .method private hidebysig specialname rtspecialname static void .cctor() cil managed
  {
  .locals init (valuetype [lua]Lua.Value V_0)
        ldloca 0
        initobj valuetype [lua]Lua.Value
        ldloca 0
        ldsfld class [lua]Lua.Reference [lua]Lua.Nil::Instance
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function5::LiteralNil
        ret 
  }
  .method public hidebysig specialname rtspecialname instance void .ctor(valuetype [lua]Lua.Value[] f) cil managed
  {
        ldarg.0 
        call instance void [lua]Lua.Closure::.ctor()
        ldarg.0 
        ldarg 1
        stfld valuetype [lua]Lua.Value[] foo.function5::f
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value x) cil managed
  {
        .maxstack 12
        .locals init (valuetype [lua]Lua.Value c, class [lua]Lua.Reference temp_1, valuetype [lua]Lua.Value[] temp_2, valuetype [lua]Lua.Value[] temp_3, int32 temp_4, valuetype [lua]Lua.Value[] temp_5)
        ldloca c
        initobj valuetype [lua]Lua.Value
        ldarg.0 
        ldfld valuetype [lua]Lua.Value[] foo.function5::f
        ldc.i4.0 
        ldelem valuetype [lua]Lua.Value
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldarg.0 
        ldfld valuetype [lua]Lua.Value[] foo.function5::f
        ldc.i4.0 
        ldelem valuetype [lua]Lua.Value
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        stloc temp_3
        ldloc temp_3
        ldlen 
        stloc temp_4
        ldc.i4 0
        ldloc temp_4
        bge label1
        ldloc temp_3
        ldc.i4 0
        ldelem valuetype [lua]Lua.Value
        br label2
label1:
        ldsfld valuetype [lua]Lua.Value foo.function5::LiteralNil
label2:
        stloc c
        ldloc c
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldarg x
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        ret 
        ldnull 
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function5::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function5::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function5::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function5::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function5::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6, valuetype [lua]Lua.Value arg7) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function5::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke() cil managed
  {
        ldarg.0 
        ldsfld valuetype [lua]Lua.Value foo.function5::LiteralNil
        call instance valuetype [lua]Lua.Value[] foo.function5::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value[] args) cil managed
  {
        .locals init (int32 V_0)
        ldarg.1 
        ldlen 
        stloc.0 
        ldarg.0 
        ldc.i4 1
        ldloc.0 
        bgt label1
        ldarg.1 
        ldc.i4 0
        ldelem valuetype [lua]Lua.Value
        br label2
label1:
        ldsfld valuetype [lua]Lua.Value foo.function5::LiteralNil
label2:
        call instance valuetype [lua]Lua.Value[] foo.function5::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
}

.class public auto ansi beforefieldinit foo.function6 extends [lua]Lua.Closure
{
  .field public static valuetype [lua]Lua.Value LiteralNil
  .method private hidebysig specialname rtspecialname static void .cctor() cil managed
  {
  .locals init (valuetype [lua]Lua.Value V_0)
        ldloca 0
        initobj valuetype [lua]Lua.Value
        ldloca 0
        ldsfld class [lua]Lua.Reference [lua]Lua.Nil::Instance
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function6::LiteralNil
        ret 
  }
  .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
  {
        ldarg.0 
        call instance void [lua]Lua.Closure::.ctor()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value f) cil managed
  {
        .maxstack 12
        .locals init (valuetype [lua]Lua.Value[] f, valuetype [lua]Lua.Value[] temp_1, valuetype [lua]Lua.Value temp_2)
        ldc.i4.1 
        newarr valuetype [lua]Lua.Value
        stloc f
        ldloc f
        ldc.i4.0 
        ldarg f
        stelem valuetype [lua]Lua.Value
        ldc.i4 1
        newarr valuetype [lua]Lua.Value
        stloc temp_1
        ldloc temp_1
        ldc.i4 0
        ldloca temp_2
        ldloc f
        newobj instance void foo.function7::.ctor(valuetype [lua]Lua.Value[] f)
        dup 
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc temp_2
        stelem valuetype [lua]Lua.Value
        ldloc temp_1
        ret 
        ldnull 
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function6::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function6::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function6::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function6::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function6::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6, valuetype [lua]Lua.Value arg7) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function6::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke() cil managed
  {
        ldarg.0 
        ldsfld valuetype [lua]Lua.Value foo.function6::LiteralNil
        call instance valuetype [lua]Lua.Value[] foo.function6::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value[] args) cil managed
  {
        .locals init (int32 V_0)
        ldarg.1 
        ldlen 
        stloc.0 
        ldarg.0 
        ldc.i4 1
        ldloc.0 
        bgt label1
        ldarg.1 
        ldc.i4 0
        ldelem valuetype [lua]Lua.Value
        br label2
label1:
        ldsfld valuetype [lua]Lua.Value foo.function6::LiteralNil
label2:
        call instance valuetype [lua]Lua.Value[] foo.function6::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
}

.class public auto ansi beforefieldinit foo.function7 extends [lua]Lua.Closure
{
  .field public static valuetype [lua]Lua.Value LiteralNil
  .field public static valuetype [lua]Lua.Value Literal3
  .field public static valuetype [lua]Lua.Value Literal2
  .field public static valuetype [lua]Lua.Value Literal1
  .field public valuetype [lua]Lua.Value[] f
  .method private hidebysig specialname rtspecialname static void .cctor() cil managed
  {
  .locals init (valuetype [lua]Lua.Value V_0)
        ldloca 0
        initobj valuetype [lua]Lua.Value
        ldloca 0
        ldc.r8 1
        stfld float64 [lua]Lua.Value::N
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function7::Literal3
        ldloca 0
        ldc.r8 0
        stfld float64 [lua]Lua.Value::N
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function7::Literal2
        ldloca 0
        ldsfld class [lua]Lua.Reference [lua]Lua.True::Instance
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function7::Literal1
        ldloca 0
        ldsfld class [lua]Lua.Reference [lua]Lua.Nil::Instance
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function7::LiteralNil
        ret 
  }
  .method public hidebysig specialname rtspecialname instance void .ctor(valuetype [lua]Lua.Value[] f) cil managed
  {
        ldarg.0 
        call instance void [lua]Lua.Closure::.ctor()
        ldarg.0 
        ldarg 1
        stfld valuetype [lua]Lua.Value[] foo.function7::f
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value n) cil managed
  {
        .maxstack 12
        .locals init (valuetype [lua]Lua.Value temp_0, valuetype [lua]Lua.Value[] temp_1, valuetype [lua]Lua.Value[] temp_2, class [lua]Lua.Reference temp_3, valuetype [lua]Lua.Value[] temp_4, valuetype [lua]Lua.Value temp_5, valuetype [lua]Lua.Value[] temp_6)
        ldarg n
        dup 
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        brtrue label4
        ldfld float64 [lua]Lua.Value::N
        ldc.r8 0
        beq label3
        ldsfld valuetype [lua]Lua.Value foo.function7::LiteralNil
        br label6
label3:
        ldsfld valuetype [lua]Lua.Value foo.function7::Literal1
        br label6
label4:
        ldsfld valuetype [lua]Lua.Value foo.function7::Literal2
        call bool [lua]Lua.Reference::Equal(valuetype [lua]Lua.Value, valuetype [lua]Lua.Value)
        brtrue label3
        ldsfld valuetype [lua]Lua.Value foo.function7::LiteralNil
        br label6
label6:
        stloc temp_0
        ldloc temp_0
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldsfld class [lua]Lua.Reference [lua]Lua.Nil::Instance
        beq label2
        ldloc temp_0
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldsfld class [lua]Lua.Reference [lua]Lua.False::Instance
        beq label2
        ldc.i4 1
        newarr valuetype [lua]Lua.Value
        stloc temp_1
        ldloc temp_1
        ldc.i4 0
        ldsfld valuetype [lua]Lua.Value foo.function7::Literal3
        stelem valuetype [lua]Lua.Value
        ldloc temp_1
        ret 
        br label1
label2:
        ldc.i4 1
        newarr valuetype [lua]Lua.Value
        stloc temp_2
        ldloc temp_2
        ldc.i4 0
        ldloca temp_0
        dup 
        ldarg n
        dup 
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        brtrue label7
        ldfld float64 [lua]Lua.Value::N
        ldarg.0 
        ldfld valuetype [lua]Lua.Value[] foo.function7::f
        ldc.i4.0 
        ldelem valuetype [lua]Lua.Value
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloca temp_5
        dup 
        ldarg n
        dup 
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        brtrue label10
        ldfld float64 [lua]Lua.Value::N
        ldc.r8 1
        sub 
        stfld float64 [lua]Lua.Value::N
        ldnull 
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        br label12
label10:
        ldsfld valuetype [lua]Lua.Value foo.function7::Literal3
        call valuetype [lua]Lua.Value [lua]Lua.Reference::Subtract(valuetype [lua]Lua.Value, valuetype [lua]Lua.Value)
        stloc temp_5
        pop 
        pop 
        br label12
label12:
        ldloc temp_5
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        ldc.i4.0 
        ldelem valuetype [lua]Lua.Value
        dup 
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        brtrue label8
        ldfld float64 [lua]Lua.Value::N
        mul 
        stfld float64 [lua]Lua.Value::N
        ldnull 
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        br label9
label7:
        ldarg.0 
        ldfld valuetype [lua]Lua.Value[] foo.function7::f
        ldc.i4.0 
        ldelem valuetype [lua]Lua.Value
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloca temp_5
        dup 
        ldarg n
        dup 
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        brtrue label13
        ldfld float64 [lua]Lua.Value::N
        ldc.r8 1
        sub 
        stfld float64 [lua]Lua.Value::N
        ldnull 
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        br label15
label13:
        ldsfld valuetype [lua]Lua.Value foo.function7::Literal3
        call valuetype [lua]Lua.Value [lua]Lua.Reference::Subtract(valuetype [lua]Lua.Value, valuetype [lua]Lua.Value)
        stloc temp_5
        pop 
        pop 
        br label15
label15:
        ldloc temp_5
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        ldc.i4.0 
        ldelem valuetype [lua]Lua.Value
        call valuetype [lua]Lua.Value [lua]Lua.Reference::Multiply(valuetype [lua]Lua.Value, valuetype [lua]Lua.Value)
        stloc temp_0
        pop 
        pop 
        br label9
label8:
        call valuetype [lua]Lua.Value [lua]Lua.Reference::Multiply(float64, valuetype [lua]Lua.Value)
        stloc temp_0
        pop 
        pop 
label9:
        ldloc temp_0
        stelem valuetype [lua]Lua.Value
        ldloc temp_2
        ret 
label1:
        ldnull 
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function7::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function7::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function7::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function7::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function7::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6, valuetype [lua]Lua.Value arg7) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function7::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke() cil managed
  {
        ldarg.0 
        ldsfld valuetype [lua]Lua.Value foo.function7::LiteralNil
        call instance valuetype [lua]Lua.Value[] foo.function7::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value[] args) cil managed
  {
        .locals init (int32 V_0)
        ldarg.1 
        ldlen 
        stloc.0 
        ldarg.0 
        ldc.i4 1
        ldloc.0 
        bgt label1
        ldarg.1 
        ldc.i4 0
        ldelem valuetype [lua]Lua.Value
        br label2
label1:
        ldsfld valuetype [lua]Lua.Value foo.function7::LiteralNil
label2:
        call instance valuetype [lua]Lua.Value[] foo.function7::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
}

.class public auto ansi beforefieldinit foo.function8 extends [lua]Lua.Closure
{
  .field public static valuetype [lua]Lua.Value LiteralNil
  .field public static valuetype [lua]Lua.Value Literal1
  .field public static valuetype [lua]Lua.Value Literal2
  .method private hidebysig specialname rtspecialname static void .cctor() cil managed
  {
  .locals init (valuetype [lua]Lua.Value V_0)
        ldloca 0
        initobj valuetype [lua]Lua.Value
        ldloca 0
        ldstr "print"
        newobj instance void [lua]Lua.String::.ctor(string)
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function8::Literal1
        ldloca 0
        ldstr "factorial"
        newobj instance void [lua]Lua.String::.ctor(string)
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function8::Literal2
        ldloca 0
        ldsfld class [lua]Lua.Reference [lua]Lua.Nil::Instance
        stfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldloc.0 
        stsfld valuetype [lua]Lua.Value foo.function8::LiteralNil
        ret 
  }
  .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
  {
        ldarg.0 
        call instance void [lua]Lua.Closure::.ctor()
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value x) cil managed
  {
        .maxstack 12
        .locals init (class [lua]Lua.Reference temp_0, valuetype [lua]Lua.Value[] temp_1, int32 temp_2, class [lua]Lua.Reference temp_3, valuetype [lua]Lua.Value[] temp_4)
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        ldsfld valuetype [lua]Lua.Value foo.function8::Literal1
        callvirt instance valuetype [lua]Lua.Value [lua]Lua.Reference::get_Item(valuetype [lua]Lua.Value)
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldarg.0 
        ldfld class [lua]Lua.Reference [lua]Lua.Closure::Env
        ldsfld valuetype [lua]Lua.Value foo.function8::Literal2
        callvirt instance valuetype [lua]Lua.Value [lua]Lua.Reference::get_Item(valuetype [lua]Lua.Value)
        ldfld class [lua]Lua.Reference [lua]Lua.Value::O
        ldarg x
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value)
        stloc temp_1
        ldloc temp_1
        ldlen 
        stloc temp_2
        ldloc temp_1
        ldc.i4.0 
        ldloc temp_2
        ldc.i4 1
        add 
        newarr valuetype [lua]Lua.Value
        stloc temp_1
        ldloc temp_1
        ldc.i4 1
        ldloc temp_2
        call void [mscorlib]System.Array::Copy(class [mscorlib]System.Array,int32,class [mscorlib]System.Array,int32,int32)
        ldloc temp_1
        ldc.i4 0
        ldarg x
        stelem valuetype [lua]Lua.Value
        ldloc temp_1
        callvirt instance valuetype [lua]Lua.Value[] [lua]Lua.Reference::Invoke(valuetype [lua]Lua.Value[])
        pop 
        ldnull 
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function8::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function8::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function8::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function8::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function8::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value arg1, valuetype [lua]Lua.Value arg2, valuetype [lua]Lua.Value arg3, valuetype [lua]Lua.Value arg4, valuetype [lua]Lua.Value arg5, valuetype [lua]Lua.Value arg6, valuetype [lua]Lua.Value arg7) cil managed
  {
        ldarg.0 
        ldarg 1
        call instance valuetype [lua]Lua.Value[] foo.function8::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke() cil managed
  {
        ldarg.0 
        ldsfld valuetype [lua]Lua.Value foo.function8::LiteralNil
        call instance valuetype [lua]Lua.Value[] foo.function8::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
  .method public hidebysig virtual instance valuetype [lua]Lua.Value[] Invoke(valuetype [lua]Lua.Value[] args) cil managed
  {
        .locals init (int32 V_0)
        ldarg.1 
        ldlen 
        stloc.0 
        ldarg.0 
        ldc.i4 1
        ldloc.0 
        bgt label1
        ldarg.1 
        ldc.i4 0
        ldelem valuetype [lua]Lua.Value
        br label2
label1:
        ldsfld valuetype [lua]Lua.Value foo.function8::LiteralNil
label2:
        call instance valuetype [lua]Lua.Value[] foo.function8::Invoke(valuetype [lua]Lua.Value)
        ret 
  }
}

