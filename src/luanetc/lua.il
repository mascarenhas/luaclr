
//  Microsoft (R) .NET Framework IL Disassembler.  Version 2.0.50727.42
//  Copyright (c) Microsoft Corporation.  All rights reserved.



// Metadata version: v2.0.50727
.assembly extern mscorlib
{
  .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )                         // .z\V.4..
  .ver 2:0:0:0
}
.assembly lua
{
  .custom instance void [mscorlib]System.Runtime.CompilerServices.CompilationRelaxationsAttribute::.ctor(int32) = ( 01 00 08 00 00 00 00 00 ) 
  .custom instance void [mscorlib]System.Runtime.CompilerServices.RuntimeCompatibilityAttribute::.ctor() = ( 01 00 01 00 54 02 16 57 72 61 70 4E 6F 6E 45 78   // ....T..WrapNonEx
                                                                                                             63 65 70 74 69 6F 6E 54 68 72 6F 77 73 01 )       // ceptionThrows.
  .hash algorithm 0x00008004
  .ver 0:0:0:0
}
.module lua.dll
// MVID: {72DBCB57-0874-452F-AFE2-4514C519BD5B}
.imagebase 0x00400000
.file alignment 0x00000200
.stackreserve 0x00100000
.subsystem 0x0003       // WINDOWS_CUI
.corflags 0x00000001    //  ILONLY
// Image base: 0x00EB0000


// =============== CLASS MEMBERS DECLARATION ===================

.class public abstract auto ansi beforefieldinit Lua.Reference
       extends [mscorlib]System.Object
{
  .custom instance void [mscorlib]System.Reflection.DefaultMemberAttribute::.ctor(string) = ( 01 00 04 49 74 65 6D 00 00 )                      // ...Item..
  .method public hidebysig static valuetype Lua.Value 
          Add(valuetype Lua.Value v1,
              valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Add

  .method public hidebysig static valuetype Lua.Value 
          Add(float64 v1,
              valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Add

  .method public hidebysig static valuetype Lua.Value 
          Subtract(valuetype Lua.Value v1,
                   valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Subtract

  .method public hidebysig static valuetype Lua.Value 
          Subtract(float64 v1,
                   valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Subtract

  .method public hidebysig static valuetype Lua.Value 
          Multiply(valuetype Lua.Value v1,
                   valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Multiply

  .method public hidebysig static valuetype Lua.Value 
          Multiply(float64 v1,
                   valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Multiply

  .method public hidebysig static valuetype Lua.Value 
          Divide(valuetype Lua.Value v1,
                 valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Divide

  .method public hidebysig static valuetype Lua.Value 
          Divide(float64 v1,
                 valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Divide

  .method public hidebysig static valuetype Lua.Value 
          Mod(valuetype Lua.Value v1,
              valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Mod

  .method public hidebysig static valuetype Lua.Value 
          Mod(float64 v1,
              valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Mod

  .method public hidebysig static valuetype Lua.Value 
          Pow(valuetype Lua.Value v1,
              valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Pow

  .method public hidebysig static valuetype Lua.Value 
          Pow(float64 v1,
              valuetype Lua.Value v2) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Pow

  .method public hidebysig static valuetype Lua.Value 
          Negate(valuetype Lua.Value v) cil managed
  {
    // Code size       15 (0xf)
    .maxstack  1
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_1
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloc.1
    IL_000a:  stloc.0
    IL_000b:  br.s       IL_000d

    IL_000d:  ldloc.0
    IL_000e:  ret
  } // end of method Reference::Negate

  .method public hidebysig static bool  Equal(valuetype Lua.Value v1,
                                              valuetype Lua.Value v2) cil managed
  {
    // Code size       25 (0x19)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarga.s   v1
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldarga.s   v2
    IL_000a:  ldfld      class Lua.Reference Lua.Value::O
    IL_000f:  callvirt   instance bool Lua.Reference::Equals(class Lua.Reference)
    IL_0014:  stloc.0
    IL_0015:  br.s       IL_0017

    IL_0017:  ldloc.0
    IL_0018:  ret
  } // end of method Reference::Equal

  .method public hidebysig static bool  NotEqual(valuetype Lua.Value v1,
                                                 valuetype Lua.Value v2) cil managed
  {
    // Code size       28 (0x1c)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarga.s   v1
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldarga.s   v2
    IL_000a:  ldfld      class Lua.Reference Lua.Value::O
    IL_000f:  callvirt   instance bool Lua.Reference::Equals(class Lua.Reference)
    IL_0014:  ldc.i4.0
    IL_0015:  ceq
    IL_0017:  stloc.0
    IL_0018:  br.s       IL_001a

    IL_001a:  ldloc.0
    IL_001b:  ret
  } // end of method Reference::NotEqual

  .method public hidebysig static bool  LessThan(valuetype Lua.Value v1,
                                                 valuetype Lua.Value v2) cil managed
  {
    // Code size       25 (0x19)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarga.s   v1
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldarga.s   v2
    IL_000a:  ldfld      class Lua.Reference Lua.Value::O
    IL_000f:  callvirt   instance bool Lua.Reference::LessThan(class Lua.Reference)
    IL_0014:  stloc.0
    IL_0015:  br.s       IL_0017

    IL_0017:  ldloc.0
    IL_0018:  ret
  } // end of method Reference::LessThan

  .method public hidebysig static bool  LessThanOrEqual(valuetype Lua.Value v1,
                                                        valuetype Lua.Value v2) cil managed
  {
    // Code size       25 (0x19)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarga.s   v1
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldarga.s   v2
    IL_000a:  ldfld      class Lua.Reference Lua.Value::O
    IL_000f:  callvirt   instance bool Lua.Reference::LessThanOrEqual(class Lua.Reference)
    IL_0014:  stloc.0
    IL_0015:  br.s       IL_0017

    IL_0017:  ldloc.0
    IL_0018:  ret
  } // end of method Reference::LessThanOrEqual

  .method public hidebysig static bool  GreaterThan(valuetype Lua.Value v1,
                                                    valuetype Lua.Value v2) cil managed
  {
    // Code size       28 (0x1c)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarga.s   v1
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldarga.s   v2
    IL_000a:  ldfld      class Lua.Reference Lua.Value::O
    IL_000f:  callvirt   instance bool Lua.Reference::LessThanOrEqual(class Lua.Reference)
    IL_0014:  ldc.i4.0
    IL_0015:  ceq
    IL_0017:  stloc.0
    IL_0018:  br.s       IL_001a

    IL_001a:  ldloc.0
    IL_001b:  ret
  } // end of method Reference::GreaterThan

  .method public hidebysig static bool  GreaterThanorEqual(valuetype Lua.Value v1,
                                                           valuetype Lua.Value v2) cil managed
  {
    // Code size       28 (0x1c)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarga.s   v1
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldarga.s   v2
    IL_000a:  ldfld      class Lua.Reference Lua.Value::O
    IL_000f:  callvirt   instance bool Lua.Reference::LessThan(class Lua.Reference)
    IL_0014:  ldc.i4.0
    IL_0015:  ceq
    IL_0017:  stloc.0
    IL_0018:  br.s       IL_001a

    IL_001a:  ldloc.0
    IL_001b:  ret
  } // end of method Reference::GreaterThanorEqual

  .method public hidebysig newslot abstract virtual 
          instance bool  Equals(class Lua.Reference o) cil managed
  {
  } // end of method Reference::Equals

  .method public hidebysig newslot abstract virtual 
          instance bool  LessThan(class Lua.Reference o) cil managed
  {
  } // end of method Reference::LessThan

  .method public hidebysig newslot abstract virtual 
          instance bool  LessThanOrEqual(class Lua.Reference o) cil managed
  {
  } // end of method Reference::LessThanOrEqual

  .method public hidebysig newslot abstract virtual 
          instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value[] args) cil managed
  {
  } // end of method Reference::Invoke

  .method public hidebysig newslot abstract virtual 
          instance valuetype Lua.Value[] 
          Invoke() cil managed
  {
  } // end of method Reference::Invoke

  .method public hidebysig newslot abstract virtual 
          instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1) cil managed
  {
  } // end of method Reference::Invoke

  .method public hidebysig newslot abstract virtual 
          instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2) cil managed
  {
  } // end of method Reference::Invoke

  .method public hidebysig newslot abstract virtual 
          instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3) cil managed
  {
  } // end of method Reference::Invoke

  .method public hidebysig newslot abstract virtual 
          instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4) cil managed
  {
  } // end of method Reference::Invoke

  .method public hidebysig newslot abstract virtual 
          instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5) cil managed
  {
  } // end of method Reference::Invoke

  .method public hidebysig newslot abstract virtual 
          instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5,
                 valuetype Lua.Value a6) cil managed
  {
  } // end of method Reference::Invoke

  .method public hidebysig newslot abstract virtual 
          instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5,
                 valuetype Lua.Value a6,
                 valuetype Lua.Value a7) cil managed
  {
  } // end of method Reference::Invoke

  .method public hidebysig newslot abstract virtual 
          instance valuetype Lua.Value  Length() cil managed
  {
  } // end of method Reference::Length

  .method public hidebysig newslot specialname abstract virtual 
          instance valuetype Lua.Value  get_Item(valuetype Lua.Value key) cil managed
  {
  } // end of method Reference::get_Item

  .method public hidebysig newslot specialname abstract virtual 
          instance void  set_Item(valuetype Lua.Value key,
                                  valuetype Lua.Value 'value') cil managed
  {
  } // end of method Reference::set_Item

  .method public hidebysig newslot specialname abstract virtual 
          instance class Lua.Table  get_Metatable() cil managed
  {
  } // end of method Reference::get_Metatable

  .method public hidebysig newslot specialname abstract virtual 
          instance void  set_Metatable(class Lua.Table 'value') cil managed
  {
  } // end of method Reference::set_Metatable

  .method family hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    // Code size       7 (0x7)
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  call       instance void [mscorlib]System.Object::.ctor()
    IL_0006:  ret
  } // end of method Reference::.ctor

  .property instance valuetype Lua.Value Item(valuetype Lua.Value)
  {
    .get instance valuetype Lua.Value Lua.Reference::get_Item(valuetype Lua.Value)
    .set instance void Lua.Reference::set_Item(valuetype Lua.Value,
                                               valuetype Lua.Value)
  } // end of property Reference::Item
  .property instance class Lua.Table Metatable()
  {
    .get instance class Lua.Table Lua.Reference::get_Metatable()
    .set instance void Lua.Reference::set_Metatable(class Lua.Table)
  } // end of property Reference::Metatable
} // end of class Lua.Reference

.class public abstract auto ansi beforefieldinit Lua.Singleton
       extends Lua.Reference
{
  .custom instance void [mscorlib]System.Reflection.DefaultMemberAttribute::.ctor(string) = ( 01 00 04 49 74 65 6D 00 00 )                      // ...Item..
  .method public hidebysig virtual instance bool 
          Equals(class Lua.Reference o) cil managed
  {
    // Code size       10 (0xa)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarg.1
    IL_0002:  ldarg.0
    IL_0003:  ceq
    IL_0005:  stloc.0
    IL_0006:  br.s       IL_0008

    IL_0008:  ldloc.0
    IL_0009:  ret
  } // end of method Singleton::Equals

  .method public hidebysig virtual instance bool 
          LessThan(class Lua.Reference o) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::LessThan

  .method public hidebysig virtual instance bool 
          LessThanOrEqual(class Lua.Reference o) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::LessThanOrEqual

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value[] args) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke() cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5,
                 valuetype Lua.Value a6) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5,
                 valuetype Lua.Value a6,
                 valuetype Lua.Value a7) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value 
          Length() cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::Length

  .method public hidebysig specialname virtual 
          instance valuetype Lua.Value  get_Item(valuetype Lua.Value key) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::get_Item

  .method public hidebysig specialname virtual 
          instance void  set_Item(valuetype Lua.Value key,
                                  valuetype Lua.Value 'value') cil managed
  {
    // Code size       12 (0xc)
    .maxstack  8
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::set_Item

  .method public hidebysig specialname virtual 
          instance class Lua.Table  get_Metatable() cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (class Lua.Table V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::get_Metatable

  .method public hidebysig specialname virtual 
          instance void  set_Metatable(class Lua.Table 'value') cil managed
  {
    // Code size       12 (0xc)
    .maxstack  8
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Singleton::set_Metatable

  .method family hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    // Code size       7 (0x7)
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  call       instance void Lua.Reference::.ctor()
    IL_0006:  ret
  } // end of method Singleton::.ctor

  .property instance valuetype Lua.Value Item(valuetype Lua.Value)
  {
    .get instance valuetype Lua.Value Lua.Singleton::get_Item(valuetype Lua.Value)
    .set instance void Lua.Singleton::set_Item(valuetype Lua.Value,
                                               valuetype Lua.Value)
  } // end of property Singleton::Item
  .property instance class Lua.Table Metatable()
  {
    .set instance void Lua.Singleton::set_Metatable(class Lua.Table)
    .get instance class Lua.Table Lua.Singleton::get_Metatable()
  } // end of property Singleton::Metatable
} // end of class Lua.Singleton

.class public auto ansi Lua.Nil
       extends Lua.Singleton
{
  .field public static initonly valuetype Lua.Value Instance
  .method private hidebysig specialname rtspecialname static 
          void  .cctor() cil managed
  {
    // Code size       36 (0x24)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_0
    IL_0003:  ldc.r8     0.0
    IL_000c:  stfld      float64 Lua.Value::N
    IL_0011:  ldloca.s   V_0
    IL_0013:  newobj     instance void Lua.Nil::.ctor()
    IL_0018:  stfld      class Lua.Reference Lua.Value::O
    IL_001d:  ldloc.0
    IL_001e:  stsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_0023:  ret
  } // end of method Nil::.cctor

  .method public hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    // Code size       10 (0xa)
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  call       instance void Lua.Singleton::.ctor()
    IL_0006:  nop
    IL_0007:  nop
    IL_0008:  nop
    IL_0009:  ret
  } // end of method Nil::.ctor

} // end of class Lua.Nil

.class public auto ansi Lua.True
       extends Lua.Singleton
{
  .field public static initonly valuetype Lua.Value Instance
  .method private hidebysig specialname rtspecialname static 
          void  .cctor() cil managed
  {
    // Code size       44 (0x2c)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_0
    IL_0003:  initobj    Lua.Value
    IL_0009:  ldloca.s   V_0
    IL_000b:  ldc.r8     0.0
    IL_0014:  stfld      float64 Lua.Value::N
    IL_0019:  ldloca.s   V_0
    IL_001b:  newobj     instance void Lua.True::.ctor()
    IL_0020:  stfld      class Lua.Reference Lua.Value::O
    IL_0025:  ldloc.0
    IL_0026:  stsfld     valuetype Lua.Value Lua.True::Instance
    IL_002b:  ret
  } // end of method True::.cctor

  .method public hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    // Code size       10 (0xa)
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  call       instance void Lua.Singleton::.ctor()
    IL_0006:  nop
    IL_0007:  nop
    IL_0008:  nop
    IL_0009:  ret
  } // end of method True::.ctor

} // end of class Lua.True

.class public auto ansi Lua.False
       extends Lua.Singleton
{
  .field public static initonly valuetype Lua.Value Instance
  .method private hidebysig specialname rtspecialname static 
          void  .cctor() cil managed
  {
    // Code size       36 (0x24)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_0
    IL_0003:  ldc.r8     0.0
    IL_000c:  stfld      float64 Lua.Value::N
    IL_0011:  ldloca.s   V_0
    IL_0013:  newobj     instance void Lua.False::.ctor()
    IL_0018:  stfld      class Lua.Reference Lua.Value::O
    IL_001d:  ldloc.0
    IL_001e:  stsfld     valuetype Lua.Value Lua.False::Instance
    IL_0023:  ret
  } // end of method False::.cctor

  .method public hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    // Code size       10 (0xa)
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  call       instance void Lua.Singleton::.ctor()
    IL_0006:  nop
    IL_0007:  nop
    IL_0008:  nop
    IL_0009:  ret
  } // end of method False::.ctor

} // end of class Lua.False

.class public auto ansi beforefieldinit Lua.String
       extends Lua.Reference
{
  .custom instance void [mscorlib]System.Reflection.DefaultMemberAttribute::.ctor(string) = ( 01 00 04 49 74 65 6D 00 00 )                      // ...Item..
  .field public string S
  .method public hidebysig specialname rtspecialname 
          instance void  .ctor(string s) cil managed
  {
    // Code size       17 (0x11)
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  call       instance void Lua.Reference::.ctor()
    IL_0006:  nop
    IL_0007:  nop
    IL_0008:  ldarg.0
    IL_0009:  ldarg.1
    IL_000a:  stfld      string Lua.String::S
    IL_000f:  nop
    IL_0010:  ret
  } // end of method String::.ctor

  .method public hidebysig virtual instance bool 
          Equals(class Lua.Reference o) cil managed
  {
    // Code size       39 (0x27)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarg.1
    IL_0002:  isinst     Lua.String
    IL_0007:  brfalse.s  IL_0021

    IL_0009:  ldarg.1
    IL_000a:  castclass  Lua.String
    IL_000f:  ldfld      string Lua.String::S
    IL_0014:  ldarg.0
    IL_0015:  ldfld      string Lua.String::S
    IL_001a:  call       bool [mscorlib]System.String::op_Equality(string,
                                                                   string)
    IL_001f:  br.s       IL_0022

    IL_0021:  ldc.i4.0
    IL_0022:  stloc.0
    IL_0023:  br.s       IL_0025

    IL_0025:  ldloc.0
    IL_0026:  ret
  } // end of method String::Equals

  .method public hidebysig virtual instance bool 
          LessThan(class Lua.Reference o) cil managed
  {
    // Code size       42 (0x2a)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarg.1
    IL_0002:  isinst     Lua.String
    IL_0007:  brfalse.s  IL_0024

    IL_0009:  ldarg.1
    IL_000a:  castclass  Lua.String
    IL_000f:  ldfld      string Lua.String::S
    IL_0014:  ldarg.0
    IL_0015:  ldfld      string Lua.String::S
    IL_001a:  call       int32 [mscorlib]System.String::Compare(string,
                                                                string)
    IL_001f:  ldc.i4.0
    IL_0020:  clt
    IL_0022:  br.s       IL_0025

    IL_0024:  ldc.i4.0
    IL_0025:  stloc.0
    IL_0026:  br.s       IL_0028

    IL_0028:  ldloc.0
    IL_0029:  ret
  } // end of method String::LessThan

  .method public hidebysig virtual instance bool 
          LessThanOrEqual(class Lua.Reference o) cil managed
  {
    // Code size       45 (0x2d)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarg.1
    IL_0002:  isinst     Lua.String
    IL_0007:  brfalse.s  IL_0027

    IL_0009:  ldarg.1
    IL_000a:  castclass  Lua.String
    IL_000f:  ldfld      string Lua.String::S
    IL_0014:  ldarg.0
    IL_0015:  ldfld      string Lua.String::S
    IL_001a:  call       int32 [mscorlib]System.String::Compare(string,
                                                                string)
    IL_001f:  ldc.i4.0
    IL_0020:  cgt
    IL_0022:  ldc.i4.0
    IL_0023:  ceq
    IL_0025:  br.s       IL_0028

    IL_0027:  ldc.i4.0
    IL_0028:  stloc.0
    IL_0029:  br.s       IL_002b

    IL_002b:  ldloc.0
    IL_002c:  ret
  } // end of method String::LessThanOrEqual

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value[] args) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke() cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5,
                 valuetype Lua.Value a6) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5,
                 valuetype Lua.Value a6,
                 valuetype Lua.Value a7) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value 
          Length() cil managed
  {
    // Code size       34 (0x22)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_0
    IL_0003:  ldnull
    IL_0004:  stfld      class Lua.Reference Lua.Value::O
    IL_0009:  ldloca.s   V_0
    IL_000b:  ldarg.0
    IL_000c:  ldfld      string Lua.String::S
    IL_0011:  callvirt   instance int32 [mscorlib]System.String::get_Length()
    IL_0016:  conv.r8
    IL_0017:  stfld      float64 Lua.Value::N
    IL_001c:  ldloc.0
    IL_001d:  stloc.1
    IL_001e:  br.s       IL_0020

    IL_0020:  ldloc.1
    IL_0021:  ret
  } // end of method String::Length

  .method public hidebysig specialname virtual 
          instance valuetype Lua.Value  get_Item(valuetype Lua.Value key) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::get_Item

  .method public hidebysig specialname virtual 
          instance void  set_Item(valuetype Lua.Value key,
                                  valuetype Lua.Value 'value') cil managed
  {
    // Code size       12 (0xc)
    .maxstack  8
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::set_Item

  .method public hidebysig specialname virtual 
          instance class Lua.Table  get_Metatable() cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (class Lua.Table V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::get_Metatable

  .method public hidebysig specialname virtual 
          instance void  set_Metatable(class Lua.Table 'value') cil managed
  {
    // Code size       12 (0xc)
    .maxstack  8
    IL_0000:  nop
    IL_0001:  ldstr      "not supported"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method String::set_Metatable

  .property instance valuetype Lua.Value Item(valuetype Lua.Value)
  {
    .get instance valuetype Lua.Value Lua.String::get_Item(valuetype Lua.Value)
    .set instance void Lua.String::set_Item(valuetype Lua.Value,
                                            valuetype Lua.Value)
  } // end of property String::Item
  .property instance class Lua.Table Metatable()
  {
    .get instance class Lua.Table Lua.String::get_Metatable()
    .set instance void Lua.String::set_Metatable(class Lua.Table)
  } // end of property String::Metatable
} // end of class Lua.String

.class private auto ansi beforefieldinit Lua.Node
       extends [mscorlib]System.Object
{
  .field public static initonly class Lua.Node DummyNode
  .field public static initonly class Lua.Node NilNode
  .field public valuetype Lua.Value key
  .field public valuetype Lua.Value val
  .field public class Lua.Node next
  .method public hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    // Code size       39 (0x27)
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  call       instance void [mscorlib]System.Object::.ctor()
    IL_0006:  nop
    IL_0007:  nop
    IL_0008:  ldarg.0
    IL_0009:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_000e:  stfld      valuetype Lua.Value Lua.Node::key
    IL_0013:  ldarg.0
    IL_0014:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_0019:  stfld      valuetype Lua.Value Lua.Node::val
    IL_001e:  ldarg.0
    IL_001f:  ldnull
    IL_0020:  stfld      class Lua.Node Lua.Node::next
    IL_0025:  nop
    IL_0026:  ret
  } // end of method Node::.ctor

  .method public hidebysig instance void 
          Copy(class Lua.Node c) cil managed
  {
    // Code size       38 (0x26)
    .maxstack  8
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldarg.1
    IL_0003:  ldfld      valuetype Lua.Value Lua.Node::key
    IL_0008:  stfld      valuetype Lua.Value Lua.Node::key
    IL_000d:  ldarg.0
    IL_000e:  ldarg.1
    IL_000f:  ldfld      valuetype Lua.Value Lua.Node::val
    IL_0014:  stfld      valuetype Lua.Value Lua.Node::val
    IL_0019:  ldarg.0
    IL_001a:  ldarg.1
    IL_001b:  ldfld      class Lua.Node Lua.Node::next
    IL_0020:  stfld      class Lua.Node Lua.Node::next
    IL_0025:  ret
  } // end of method Node::Copy

  .method private hidebysig specialname rtspecialname static 
          void  .cctor() cil managed
  {
    // Code size       21 (0x15)
    .maxstack  8
    IL_0000:  newobj     instance void Lua.Node::.ctor()
    IL_0005:  stsfld     class Lua.Node Lua.Node::DummyNode
    IL_000a:  newobj     instance void Lua.Node::.ctor()
    IL_000f:  stsfld     class Lua.Node Lua.Node::NilNode
    IL_0014:  ret
  } // end of method Node::.cctor

} // end of class Lua.Node

.class public auto ansi beforefieldinit Lua.Table
       extends Lua.Reference
{
  .custom instance void [mscorlib]System.Reflection.DefaultMemberAttribute::.ctor(string) = ( 01 00 04 49 74 65 6D 00 00 )                      // ...Item..
  .field private static initonly int32 MAXBITS
  .field private static initonly uint8[] log_8
  .field private int32 sizeArray
  .field private class Lua.Node[] 'array'
  .field private int32[] nums
  .field private uint8 logSizeNode
  .field private class Lua.Node[] node
  .field private int32 firstFree
  .field private class Lua.Table _meta
  .method private hidebysig instance int32 
          ArrayIndex(valuetype Lua.Value key) cil managed
  {
    // Code size       72 (0x48)
    .maxstack  2
    .locals init (int32 V_0,
             int32 V_1,
             bool V_2)
    IL_0000:  nop
    IL_0001:  ldarga.s   key
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldnull
    IL_0009:  ceq
    IL_000b:  ldc.i4.0
    IL_000c:  ceq
    IL_000e:  stloc.2
    IL_000f:  ldloc.2
    IL_0010:  brtrue.s   IL_0042

    IL_0012:  nop
    IL_0013:  ldarga.s   key
    IL_0015:  ldfld      float64 Lua.Value::N
    IL_001a:  conv.i4
    IL_001b:  stloc.0
    IL_001c:  ldloc.0
    IL_001d:  conv.r8
    IL_001e:  ldarga.s   key
    IL_0020:  ldfld      float64 Lua.Value::N
    IL_0025:  bne.un.s   IL_0038

    IL_0027:  ldloc.0
    IL_0028:  ldc.i4.1
    IL_0029:  blt.s      IL_0038

    IL_002b:  ldloc.0
    IL_002c:  ldc.i4     0x7fffffff
    IL_0031:  clt
    IL_0033:  ldc.i4.0
    IL_0034:  ceq
    IL_0036:  br.s       IL_0039

    IL_0038:  ldc.i4.1
    IL_0039:  stloc.2
    IL_003a:  ldloc.2
    IL_003b:  brtrue.s   IL_0041

    IL_003d:  ldloc.0
    IL_003e:  stloc.1
    IL_003f:  br.s       IL_0046

    IL_0041:  nop
    IL_0042:  ldc.i4.m1
    IL_0043:  stloc.1
    IL_0044:  br.s       IL_0046

    IL_0046:  ldloc.1
    IL_0047:  ret
  } // end of method Table::ArrayIndex

  .method private hidebysig instance void 
          ComputeSizes(int32[] nums,
                       int32 ntotal,
                       int32& narray,
                       int32& nhash) cil managed
  {
    // Code size       122 (0x7a)
    .maxstack  4
    .locals init (int32 V_0,
             int32 V_1,
             int32 V_2,
             int32 V_3,
             bool V_4)
    IL_0000:  nop
    IL_0001:  ldarg.1
    IL_0002:  ldc.i4.0
    IL_0003:  ldelem.i4
    IL_0004:  stloc.1
    IL_0005:  ldloc.1
    IL_0006:  stloc.2
    IL_0007:  ldloc.2
    IL_0008:  brfalse.s  IL_000d

    IL_000a:  ldc.i4.0
    IL_000b:  br.s       IL_000e

    IL_000d:  ldc.i4.m1
    IL_000e:  stloc.3
    IL_000f:  ldc.i4.1
    IL_0010:  stloc.0
    IL_0011:  br.s       IL_0047

    IL_0013:  nop
    IL_0014:  ldarg.1
    IL_0015:  ldloc.0
    IL_0016:  ldelem.i4
    IL_0017:  ldc.i4.0
    IL_0018:  cgt
    IL_001a:  ldc.i4.0
    IL_001b:  ceq
    IL_001d:  stloc.s    V_4
    IL_001f:  ldloc.s    V_4
    IL_0021:  brtrue.s   IL_0042

    IL_0023:  nop
    IL_0024:  ldloc.1
    IL_0025:  ldarg.1
    IL_0026:  ldloc.0
    IL_0027:  ldelem.i4
    IL_0028:  add
    IL_0029:  stloc.1
    IL_002a:  ldloc.1
    IL_002b:  ldc.i4.1
    IL_002c:  ldloc.0
    IL_002d:  ldc.i4.1
    IL_002e:  sub
    IL_002f:  ldc.i4.s   31
    IL_0031:  and
    IL_0032:  shl
    IL_0033:  clt
    IL_0035:  stloc.s    V_4
    IL_0037:  ldloc.s    V_4
    IL_0039:  brtrue.s   IL_0041

    IL_003b:  nop
    IL_003c:  ldloc.0
    IL_003d:  stloc.3
    IL_003e:  ldloc.1
    IL_003f:  stloc.2
    IL_0040:  nop
    IL_0041:  nop
    IL_0042:  nop
    IL_0043:  ldloc.0
    IL_0044:  ldc.i4.1
    IL_0045:  add
    IL_0046:  stloc.0
    IL_0047:  ldloc.1
    IL_0048:  ldarg.3
    IL_0049:  ldind.i4
    IL_004a:  bge.s      IL_005d

    IL_004c:  ldarg.3
    IL_004d:  ldind.i4
    IL_004e:  ldc.i4.1
    IL_004f:  ldloc.0
    IL_0050:  ldc.i4.1
    IL_0051:  sub
    IL_0052:  ldc.i4.s   31
    IL_0054:  and
    IL_0055:  shl
    IL_0056:  clt
    IL_0058:  ldc.i4.0
    IL_0059:  ceq
    IL_005b:  br.s       IL_005e

    IL_005d:  ldc.i4.0
    IL_005e:  stloc.s    V_4
    IL_0060:  ldloc.s    V_4
    IL_0062:  brtrue.s   IL_0013

    IL_0064:  ldarg.s    nhash
    IL_0066:  ldarg.2
    IL_0067:  ldloc.2
    IL_0068:  sub
    IL_0069:  stind.i4
    IL_006a:  ldarg.3
    IL_006b:  ldloc.3
    IL_006c:  ldc.i4.m1
    IL_006d:  beq.s      IL_0077

    IL_006f:  ldc.i4.1
    IL_0070:  ldloc.3
    IL_0071:  ldc.i4.s   31
    IL_0073:  and
    IL_0074:  shl
    IL_0075:  br.s       IL_0078

    IL_0077:  ldc.i4.0
    IL_0078:  stind.i4
    IL_0079:  ret
  } // end of method Table::ComputeSizes

  .method private hidebysig instance void 
          NumUse(int32& narray,
                 int32& nhash) cil managed
  {
    // Code size       374 (0x176)
    .maxstack  5
    .locals init (int32 V_0,
             int32 V_1,
             int32 V_2,
             int32 V_3,
             int32 V_4,
             class Lua.Node V_5,
             bool V_6)
    IL_0000:  nop
    IL_0001:  ldc.i4.0
    IL_0002:  stloc.0
    IL_0003:  br.s       IL_0012

    IL_0005:  ldarg.0
    IL_0006:  ldfld      int32[] Lua.Table::nums
    IL_000b:  ldloc.0
    IL_000c:  ldc.i4.0
    IL_000d:  stelem.i4
    IL_000e:  ldloc.0
    IL_000f:  ldc.i4.1
    IL_0010:  add
    IL_0011:  stloc.0
    IL_0012:  ldloc.0
    IL_0013:  ldarg.0
    IL_0014:  ldfld      int32[] Lua.Table::nums
    IL_0019:  ldlen
    IL_001a:  conv.i4
    IL_001b:  clt
    IL_001d:  stloc.s    V_6
    IL_001f:  ldloc.s    V_6
    IL_0021:  brtrue.s   IL_0005

    IL_0023:  ldc.i4.0
    IL_0024:  stloc.3
    IL_0025:  ldc.i4.0
    IL_0026:  stloc.1
    IL_0027:  ldc.i4.0
    IL_0028:  stloc.2
    IL_0029:  br         IL_00bc

    IL_002e:  nop
    IL_002f:  ldc.i4.1
    IL_0030:  ldloc.2
    IL_0031:  ldc.i4.s   31
    IL_0033:  and
    IL_0034:  shl
    IL_0035:  stloc.s    V_4
    IL_0037:  ldloc.s    V_4
    IL_0039:  ldarg.0
    IL_003a:  ldfld      int32 Lua.Table::sizeArray
    IL_003f:  cgt
    IL_0041:  ldc.i4.0
    IL_0042:  ceq
    IL_0044:  stloc.s    V_6
    IL_0046:  ldloc.s    V_6
    IL_0048:  brtrue.s   IL_0061

    IL_004a:  nop
    IL_004b:  ldarg.0
    IL_004c:  ldfld      int32 Lua.Table::sizeArray
    IL_0051:  stloc.s    V_4
    IL_0053:  ldloc.1
    IL_0054:  ldloc.s    V_4
    IL_0056:  clt
    IL_0058:  stloc.s    V_6
    IL_005a:  ldloc.s    V_6
    IL_005c:  brtrue.s   IL_0060

    IL_005e:  br.s       IL_00d0

    IL_0060:  nop
    IL_0061:  br.s       IL_00ac

    IL_0063:  nop
    IL_0064:  ldarg.0
    IL_0065:  ldfld      class Lua.Node[] Lua.Table::'array'
    IL_006a:  ldloc.1
    IL_006b:  ldelem.ref
    IL_006c:  ldflda     valuetype Lua.Value Lua.Node::val
    IL_0071:  ldfld      class Lua.Reference Lua.Value::O
    IL_0076:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_007b:  ldfld      class Lua.Reference Lua.Value::O
    IL_0080:  ceq
    IL_0082:  stloc.s    V_6
    IL_0084:  ldloc.s    V_6
    IL_0086:  brtrue.s   IL_00a7

    IL_0088:  nop
    IL_0089:  ldarg.0
    IL_008a:  ldfld      int32[] Lua.Table::nums
    IL_008f:  ldloc.2
    IL_0090:  ldelema    [mscorlib]System.Int32
    IL_0095:  dup
    IL_0096:  ldobj      [mscorlib]System.Int32
    IL_009b:  ldc.i4.1
    IL_009c:  add
    IL_009d:  stobj      [mscorlib]System.Int32
    IL_00a2:  ldloc.3
    IL_00a3:  ldc.i4.1
    IL_00a4:  add
    IL_00a5:  stloc.3
    IL_00a6:  nop
    IL_00a7:  nop
    IL_00a8:  ldloc.1
    IL_00a9:  ldc.i4.1
    IL_00aa:  add
    IL_00ab:  stloc.1
    IL_00ac:  ldloc.1
    IL_00ad:  ldloc.s    V_4
    IL_00af:  clt
    IL_00b1:  stloc.s    V_6
    IL_00b3:  ldloc.s    V_6
    IL_00b5:  brtrue.s   IL_0063

    IL_00b7:  nop
    IL_00b8:  ldloc.2
    IL_00b9:  ldc.i4.1
    IL_00ba:  add
    IL_00bb:  stloc.2
    IL_00bc:  ldloc.2
    IL_00bd:  ldsfld     int32 Lua.Table::MAXBITS
    IL_00c2:  cgt
    IL_00c4:  ldc.i4.0
    IL_00c5:  ceq
    IL_00c7:  stloc.s    V_6
    IL_00c9:  ldloc.s    V_6
    IL_00cb:  brtrue     IL_002e

    IL_00d0:  ldarg.1
    IL_00d1:  ldloc.3
    IL_00d2:  stind.i4
    IL_00d3:  ldc.i4.1
    IL_00d4:  ldarg.0
    IL_00d5:  ldfld      uint8 Lua.Table::logSizeNode
    IL_00da:  ldc.i4.s   31
    IL_00dc:  and
    IL_00dd:  shl
    IL_00de:  stloc.1
    IL_00df:  br.s       IL_0154

    IL_00e1:  nop
    IL_00e2:  ldarg.0
    IL_00e3:  ldfld      class Lua.Node[] Lua.Table::node
    IL_00e8:  ldloc.1
    IL_00e9:  ldelem.ref
    IL_00ea:  stloc.s    V_5
    IL_00ec:  ldloc.s    V_5
    IL_00ee:  ldflda     valuetype Lua.Value Lua.Node::val
    IL_00f3:  ldfld      class Lua.Reference Lua.Value::O
    IL_00f8:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_00fd:  ldfld      class Lua.Reference Lua.Value::O
    IL_0102:  ceq
    IL_0104:  stloc.s    V_6
    IL_0106:  ldloc.s    V_6
    IL_0108:  brtrue.s   IL_0153

    IL_010a:  nop
    IL_010b:  ldarg.0
    IL_010c:  ldloc.s    V_5
    IL_010e:  ldfld      valuetype Lua.Value Lua.Node::key
    IL_0113:  call       instance int32 Lua.Table::ArrayIndex(valuetype Lua.Value)
    IL_0118:  stloc.0
    IL_0119:  ldloc.0
    IL_011a:  ldc.i4.0
    IL_011b:  clt
    IL_011d:  stloc.s    V_6
    IL_011f:  ldloc.s    V_6
    IL_0121:  brtrue.s   IL_014e

    IL_0123:  nop
    IL_0124:  ldarg.0
    IL_0125:  ldfld      int32[] Lua.Table::nums
    IL_012a:  ldarg.0
    IL_012b:  ldloc.0
    IL_012c:  ldc.i4.1
    IL_012d:  sub
    IL_012e:  call       instance int32 Lua.Table::FastLog2(uint32)
    IL_0133:  ldc.i4.1
    IL_0134:  add
    IL_0135:  ldelema    [mscorlib]System.Int32
    IL_013a:  dup
    IL_013b:  ldobj      [mscorlib]System.Int32
    IL_0140:  ldc.i4.1
    IL_0141:  add
    IL_0142:  stobj      [mscorlib]System.Int32
    IL_0147:  ldarg.1
    IL_0148:  dup
    IL_0149:  ldind.i4
    IL_014a:  ldc.i4.1
    IL_014b:  add
    IL_014c:  stind.i4
    IL_014d:  nop
    IL_014e:  ldloc.3
    IL_014f:  ldc.i4.1
    IL_0150:  add
    IL_0151:  stloc.3
    IL_0152:  nop
    IL_0153:  nop
    IL_0154:  ldloc.1
    IL_0155:  dup
    IL_0156:  ldc.i4.1
    IL_0157:  sub
    IL_0158:  stloc.1
    IL_0159:  ldc.i4.0
    IL_015a:  cgt
    IL_015c:  stloc.s    V_6
    IL_015e:  ldloc.s    V_6
    IL_0160:  brtrue     IL_00e1

    IL_0165:  ldarg.0
    IL_0166:  ldarg.0
    IL_0167:  ldfld      int32[] Lua.Table::nums
    IL_016c:  ldloc.3
    IL_016d:  ldarg.1
    IL_016e:  ldarg.2
    IL_016f:  call       instance void Lua.Table::ComputeSizes(int32[],
                                                               int32,
                                                               int32&,
                                                               int32&)
    IL_0174:  nop
    IL_0175:  ret
  } // end of method Table::NumUse

  .method private hidebysig instance int32 
          FastLog2(uint32 x) cil managed
  {
    // Code size       145 (0x91)
    .maxstack  3
    .locals init (int32 V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.1
    IL_0002:  ldc.i4     0x10000
    IL_0007:  clt.un
    IL_0009:  stloc.1
    IL_000a:  ldloc.1
    IL_000b:  brtrue.s   IL_004c

    IL_000d:  nop
    IL_000e:  ldarg.1
    IL_000f:  ldc.i4     0x1000000
    IL_0014:  clt.un
    IL_0016:  stloc.1
    IL_0017:  ldloc.1
    IL_0018:  brtrue.s   IL_0033

    IL_001a:  ldsfld     uint8[] Lua.Table::log_8
    IL_001f:  ldarg.1
    IL_0020:  ldc.i4.s   24
    IL_0022:  shr.un
    IL_0023:  ldc.i4     0xff
    IL_0028:  and
    IL_0029:  ldc.i4.1
    IL_002a:  sub
    IL_002b:  conv.u
    IL_002c:  ldelem.u1
    IL_002d:  ldc.i4.s   24
    IL_002f:  add
    IL_0030:  stloc.0
    IL_0031:  br.s       IL_008f

    IL_0033:  ldsfld     uint8[] Lua.Table::log_8
    IL_0038:  ldarg.1
    IL_0039:  ldc.i4.s   16
    IL_003b:  shr.un
    IL_003c:  ldc.i4     0xff
    IL_0041:  and
    IL_0042:  ldc.i4.1
    IL_0043:  sub
    IL_0044:  conv.u
    IL_0045:  ldelem.u1
    IL_0046:  ldc.i4.s   16
    IL_0048:  add
    IL_0049:  stloc.0
    IL_004a:  br.s       IL_008f

    IL_004c:  nop
    IL_004d:  ldarg.1
    IL_004e:  ldc.i4     0x100
    IL_0053:  clt.un
    IL_0055:  stloc.1
    IL_0056:  ldloc.1
    IL_0057:  brtrue.s   IL_0070

    IL_0059:  ldsfld     uint8[] Lua.Table::log_8
    IL_005e:  ldarg.1
    IL_005f:  ldc.i4.8
    IL_0060:  shr.un
    IL_0061:  ldc.i4     0xff
    IL_0066:  and
    IL_0067:  ldc.i4.1
    IL_0068:  sub
    IL_0069:  conv.u
    IL_006a:  ldelem.u1
    IL_006b:  ldc.i4.8
    IL_006c:  add
    IL_006d:  stloc.0
    IL_006e:  br.s       IL_008f

    IL_0070:  ldarg.1
    IL_0071:  ldc.i4.0
    IL_0072:  ceq
    IL_0074:  stloc.1
    IL_0075:  ldloc.1
    IL_0076:  brtrue.s   IL_008b

    IL_0078:  ldsfld     uint8[] Lua.Table::log_8
    IL_007d:  ldarg.1
    IL_007e:  ldc.i4     0xff
    IL_0083:  and
    IL_0084:  ldc.i4.1
    IL_0085:  sub
    IL_0086:  conv.u
    IL_0087:  ldelem.u1
    IL_0088:  stloc.0
    IL_0089:  br.s       IL_008f

    IL_008b:  ldc.i4.m1
    IL_008c:  stloc.0
    IL_008d:  br.s       IL_008f

    IL_008f:  ldloc.0
    IL_0090:  ret
  } // end of method Table::FastLog2

  .method private hidebysig instance void 
          SetArrayVector(int32 size) cil managed
  {
    // Code size       86 (0x56)
    .maxstack  4
    .locals init (class Lua.Node[] V_0,
             int32 V_1,
             bool V_2)
    IL_0000:  nop
    IL_0001:  ldarg.1
    IL_0002:  newarr     Lua.Node
    IL_0007:  stloc.0
    IL_0008:  ldc.i4.0
    IL_0009:  stloc.1
    IL_000a:  br.s       IL_001b

    IL_000c:  ldloc.0
    IL_000d:  ldloc.1
    IL_000e:  ldarg.0
    IL_000f:  ldfld      class Lua.Node[] Lua.Table::'array'
    IL_0014:  ldloc.1
    IL_0015:  ldelem.ref
    IL_0016:  stelem.ref
    IL_0017:  ldloc.1
    IL_0018:  ldc.i4.1
    IL_0019:  add
    IL_001a:  stloc.1
    IL_001b:  ldloc.1
    IL_001c:  ldarg.0
    IL_001d:  ldfld      int32 Lua.Table::sizeArray
    IL_0022:  clt
    IL_0024:  stloc.2
    IL_0025:  ldloc.2
    IL_0026:  brtrue.s   IL_000c

    IL_0028:  ldarg.0
    IL_0029:  ldfld      int32 Lua.Table::sizeArray
    IL_002e:  stloc.1
    IL_002f:  br.s       IL_003d

    IL_0031:  ldloc.0
    IL_0032:  ldloc.1
    IL_0033:  newobj     instance void Lua.Node::.ctor()
    IL_0038:  stelem.ref
    IL_0039:  ldloc.1
    IL_003a:  ldc.i4.1
    IL_003b:  add
    IL_003c:  stloc.1
    IL_003d:  ldloc.1
    IL_003e:  ldloc.0
    IL_003f:  ldlen
    IL_0040:  conv.i4
    IL_0041:  clt
    IL_0043:  stloc.2
    IL_0044:  ldloc.2
    IL_0045:  brtrue.s   IL_0031

    IL_0047:  ldarg.0
    IL_0048:  ldloc.0
    IL_0049:  stfld      class Lua.Node[] Lua.Table::'array'
    IL_004e:  ldarg.0
    IL_004f:  ldarg.1
    IL_0050:  stfld      int32 Lua.Table::sizeArray
    IL_0055:  ret
  } // end of method Table::SetArrayVector

  .method private hidebysig instance void 
          SetNodeVector(int32 lsize) cil managed
  {
    // Code size       137 (0x89)
    .maxstack  3
    .locals init (int32 V_0,
             int32 V_1,
             bool V_2)
    IL_0000:  nop
    IL_0001:  ldc.i4.1
    IL_0002:  ldarg.1
    IL_0003:  ldc.i4.s   31
    IL_0005:  and
    IL_0006:  shl
    IL_0007:  stloc.1
    IL_0008:  ldarg.1
    IL_0009:  ldsfld     int32 Lua.Table::MAXBITS
    IL_000e:  cgt
    IL_0010:  ldc.i4.0
    IL_0011:  ceq
    IL_0013:  stloc.2
    IL_0014:  ldloc.2
    IL_0015:  brtrue.s   IL_0022

    IL_0017:  ldstr      "table overflow"
    IL_001c:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_0021:  throw

    IL_0022:  ldarg.1
    IL_0023:  ldc.i4.0
    IL_0024:  ceq
    IL_0026:  ldc.i4.0
    IL_0027:  ceq
    IL_0029:  stloc.2
    IL_002a:  ldloc.2
    IL_002b:  brtrue.s   IL_004a

    IL_002d:  nop
    IL_002e:  ldarg.0
    IL_002f:  ldc.i4.1
    IL_0030:  newarr     Lua.Node
    IL_0035:  stfld      class Lua.Node[] Lua.Table::node
    IL_003a:  ldarg.0
    IL_003b:  ldfld      class Lua.Node[] Lua.Table::node
    IL_0040:  ldc.i4.0
    IL_0041:  ldsfld     class Lua.Node Lua.Node::DummyNode
    IL_0046:  stelem.ref
    IL_0047:  nop
    IL_0048:  br.s       IL_0077

    IL_004a:  nop
    IL_004b:  ldarg.0
    IL_004c:  ldloc.1
    IL_004d:  newarr     Lua.Node
    IL_0052:  stfld      class Lua.Node[] Lua.Table::node
    IL_0057:  ldc.i4.0
    IL_0058:  stloc.0
    IL_0059:  br.s       IL_006e

    IL_005b:  nop
    IL_005c:  ldarg.0
    IL_005d:  ldfld      class Lua.Node[] Lua.Table::node
    IL_0062:  ldloc.0
    IL_0063:  newobj     instance void Lua.Node::.ctor()
    IL_0068:  stelem.ref
    IL_0069:  nop
    IL_006a:  ldloc.0
    IL_006b:  ldc.i4.1
    IL_006c:  add
    IL_006d:  stloc.0
    IL_006e:  ldloc.0
    IL_006f:  ldloc.1
    IL_0070:  clt
    IL_0072:  stloc.2
    IL_0073:  ldloc.2
    IL_0074:  brtrue.s   IL_005b

    IL_0076:  nop
    IL_0077:  ldarg.0
    IL_0078:  ldarg.1
    IL_0079:  conv.u1
    IL_007a:  stfld      uint8 Lua.Table::logSizeNode
    IL_007f:  ldarg.0
    IL_0080:  ldloc.1
    IL_0081:  ldc.i4.1
    IL_0082:  sub
    IL_0083:  stfld      int32 Lua.Table::firstFree
    IL_0088:  ret
  } // end of method Table::SetNodeVector

  .method private hidebysig instance void 
          Resize(int32 nasize,
                 int32 nhsize) cil managed
  {
    // Code size       436 (0x1b4)
    .maxstack  4
    .locals init (int32 V_0,
             int32 V_1,
             int32 V_2,
             class Lua.Node[] V_3,
             class Lua.Node[] V_4,
             class Lua.Node[] V_5,
             class Lua.Node V_6,
             class Lua.Node[] V_7,
             bool V_8)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      int32 Lua.Table::sizeArray
    IL_0007:  stloc.1
    IL_0008:  ldarg.0
    IL_0009:  ldfld      uint8 Lua.Table::logSizeNode
    IL_000e:  stloc.2
    IL_000f:  ldc.i4.1
    IL_0010:  newarr     Lua.Node
    IL_0015:  stloc.s    V_7
    IL_0017:  ldloc.s    V_7
    IL_0019:  ldc.i4.0
    IL_001a:  newobj     instance void Lua.Node::.ctor()
    IL_001f:  stelem.ref
    IL_0020:  ldloc.s    V_7
    IL_0022:  stloc.s    V_4
    IL_0024:  ldloc.2
    IL_0025:  ldc.i4.0
    IL_0026:  ceq
    IL_0028:  stloc.s    V_8
    IL_002a:  ldloc.s    V_8
    IL_002c:  brtrue.s   IL_0037

    IL_002e:  ldarg.0
    IL_002f:  ldfld      class Lua.Node[] Lua.Table::node
    IL_0034:  stloc.3
    IL_0035:  br.s       IL_00a7

    IL_0037:  nop
    IL_0038:  ldloc.s    V_4
    IL_003a:  ldc.i4.0
    IL_003b:  ldelem.ref
    IL_003c:  ldarg.0
    IL_003d:  ldfld      class Lua.Node[] Lua.Table::node
    IL_0042:  ldc.i4.0
    IL_0043:  ldelem.ref
    IL_0044:  ldfld      valuetype Lua.Value Lua.Node::key
    IL_0049:  stfld      valuetype Lua.Value Lua.Node::key
    IL_004e:  ldloc.s    V_4
    IL_0050:  ldc.i4.0
    IL_0051:  ldelem.ref
    IL_0052:  ldarg.0
    IL_0053:  ldfld      class Lua.Node[] Lua.Table::node
    IL_0058:  ldc.i4.0
    IL_0059:  ldelem.ref
    IL_005a:  ldfld      valuetype Lua.Value Lua.Node::val
    IL_005f:  stfld      valuetype Lua.Value Lua.Node::val
    IL_0064:  ldloc.s    V_4
    IL_0066:  ldc.i4.0
    IL_0067:  ldelem.ref
    IL_0068:  ldarg.0
    IL_0069:  ldfld      class Lua.Node[] Lua.Table::node
    IL_006e:  ldc.i4.0
    IL_006f:  ldelem.ref
    IL_0070:  ldfld      class Lua.Node Lua.Node::next
    IL_0075:  stfld      class Lua.Node Lua.Node::next
    IL_007a:  ldloc.s    V_4
    IL_007c:  stloc.3
    IL_007d:  ldsfld     class Lua.Node Lua.Node::DummyNode
    IL_0082:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_0087:  stfld      valuetype Lua.Value Lua.Node::key
    IL_008c:  ldsfld     class Lua.Node Lua.Node::DummyNode
    IL_0091:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_0096:  stfld      valuetype Lua.Value Lua.Node::val
    IL_009b:  ldsfld     class Lua.Node Lua.Node::DummyNode
    IL_00a0:  ldnull
    IL_00a1:  stfld      class Lua.Node Lua.Node::next
    IL_00a6:  nop
    IL_00a7:  ldarg.1
    IL_00a8:  ldloc.1
    IL_00a9:  cgt
    IL_00ab:  ldc.i4.0
    IL_00ac:  ceq
    IL_00ae:  stloc.s    V_8
    IL_00b0:  ldloc.s    V_8
    IL_00b2:  brtrue.s   IL_00bc

    IL_00b4:  ldarg.0
    IL_00b5:  ldarg.1
    IL_00b6:  call       instance void Lua.Table::SetArrayVector(int32)
    IL_00bb:  nop
    IL_00bc:  ldarg.0
    IL_00bd:  ldarg.2
    IL_00be:  call       instance void Lua.Table::SetNodeVector(int32)
    IL_00c3:  nop
    IL_00c4:  ldarg.1
    IL_00c5:  ldloc.1
    IL_00c6:  clt
    IL_00c8:  ldc.i4.0
    IL_00c9:  ceq
    IL_00cb:  stloc.s    V_8
    IL_00cd:  ldloc.s    V_8
    IL_00cf:  brtrue     IL_015d

    IL_00d4:  nop
    IL_00d5:  ldarg.0
    IL_00d6:  ldarg.1
    IL_00d7:  stfld      int32 Lua.Table::sizeArray
    IL_00dc:  ldarg.1
    IL_00dd:  stloc.0
    IL_00de:  br.s       IL_0121

    IL_00e0:  nop
    IL_00e1:  ldarg.0
    IL_00e2:  ldfld      class Lua.Node[] Lua.Table::'array'
    IL_00e7:  ldloc.0
    IL_00e8:  ldelem.ref
    IL_00e9:  ldflda     valuetype Lua.Value Lua.Node::val
    IL_00ee:  ldfld      class Lua.Reference Lua.Value::O
    IL_00f3:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_00f8:  ldfld      class Lua.Reference Lua.Value::O
    IL_00fd:  ceq
    IL_00ff:  stloc.s    V_8
    IL_0101:  ldloc.s    V_8
    IL_0103:  brtrue.s   IL_011c

    IL_0105:  ldarg.0
    IL_0106:  ldloc.0
    IL_0107:  ldc.i4.1
    IL_0108:  add
    IL_0109:  ldarg.0
    IL_010a:  ldfld      class Lua.Node[] Lua.Table::'array'
    IL_010f:  ldloc.0
    IL_0110:  ldelem.ref
    IL_0111:  ldfld      valuetype Lua.Value Lua.Node::val
    IL_0116:  call       instance void Lua.Table::SetNum(int32,
                                                         valuetype Lua.Value)
    IL_011b:  nop
    IL_011c:  nop
    IL_011d:  ldloc.0
    IL_011e:  ldc.i4.1
    IL_011f:  add
    IL_0120:  stloc.0
    IL_0121:  ldloc.0
    IL_0122:  ldloc.1
    IL_0123:  clt
    IL_0125:  stloc.s    V_8
    IL_0127:  ldloc.s    V_8
    IL_0129:  brtrue.s   IL_00e0

    IL_012b:  ldarg.1
    IL_012c:  newarr     Lua.Node
    IL_0131:  stloc.s    V_5
    IL_0133:  ldc.i4.0
    IL_0134:  stloc.0
    IL_0135:  br.s       IL_0147

    IL_0137:  ldloc.s    V_5
    IL_0139:  ldloc.0
    IL_013a:  ldarg.0
    IL_013b:  ldfld      class Lua.Node[] Lua.Table::'array'
    IL_0140:  ldloc.0
    IL_0141:  ldelem.ref
    IL_0142:  stelem.ref
    IL_0143:  ldloc.0
    IL_0144:  ldc.i4.1
    IL_0145:  add
    IL_0146:  stloc.0
    IL_0147:  ldloc.0
    IL_0148:  ldloc.s    V_5
    IL_014a:  ldlen
    IL_014b:  conv.i4
    IL_014c:  clt
    IL_014e:  stloc.s    V_8
    IL_0150:  ldloc.s    V_8
    IL_0152:  brtrue.s   IL_0137

    IL_0154:  ldarg.0
    IL_0155:  ldloc.s    V_5
    IL_0157:  stfld      class Lua.Node[] Lua.Table::'array'
    IL_015c:  nop
    IL_015d:  ldc.i4.1
    IL_015e:  ldloc.2
    IL_015f:  ldc.i4.s   31
    IL_0161:  and
    IL_0162:  shl
    IL_0163:  ldc.i4.1
    IL_0164:  sub
    IL_0165:  stloc.0
    IL_0166:  br.s       IL_01a6

    IL_0168:  nop
    IL_0169:  ldloc.3
    IL_016a:  ldloc.0
    IL_016b:  ldelem.ref
    IL_016c:  stloc.s    V_6
    IL_016e:  ldloc.s    V_6
    IL_0170:  ldflda     valuetype Lua.Value Lua.Node::val
    IL_0175:  ldfld      class Lua.Reference Lua.Value::O
    IL_017a:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_017f:  ldfld      class Lua.Reference Lua.Value::O
    IL_0184:  ceq
    IL_0186:  stloc.s    V_8
    IL_0188:  ldloc.s    V_8
    IL_018a:  brtrue.s   IL_01a1

    IL_018c:  ldarg.0
    IL_018d:  ldloc.s    V_6
    IL_018f:  ldfld      valuetype Lua.Value Lua.Node::key
    IL_0194:  ldloc.s    V_6
    IL_0196:  ldfld      valuetype Lua.Value Lua.Node::val
    IL_019b:  call       instance void Lua.Table::Set(valuetype Lua.Value,
                                                      valuetype Lua.Value)
    IL_01a0:  nop
    IL_01a1:  nop
    IL_01a2:  ldloc.0
    IL_01a3:  ldc.i4.1
    IL_01a4:  sub
    IL_01a5:  stloc.0
    IL_01a6:  ldloc.0
    IL_01a7:  ldc.i4.0
    IL_01a8:  clt
    IL_01aa:  ldc.i4.0
    IL_01ab:  ceq
    IL_01ad:  stloc.s    V_8
    IL_01af:  ldloc.s    V_8
    IL_01b1:  brtrue.s   IL_0168

    IL_01b3:  ret
  } // end of method Table::Resize

  .method private hidebysig instance void 
          Rehash() cil managed
  {
    // Code size       34 (0x22)
    .maxstack  4
    .locals init (int32 V_0,
             int32 V_1)
    IL_0000:  nop
    IL_0001:  ldc.i4.0
    IL_0002:  stloc.0
    IL_0003:  ldc.i4.0
    IL_0004:  stloc.1
    IL_0005:  ldarg.0
    IL_0006:  ldloca.s   V_0
    IL_0008:  ldloca.s   V_1
    IL_000a:  call       instance void Lua.Table::NumUse(int32&,
                                                         int32&)
    IL_000f:  nop
    IL_0010:  ldarg.0
    IL_0011:  ldloc.0
    IL_0012:  ldarg.0
    IL_0013:  ldloc.1
    IL_0014:  call       instance int32 Lua.Table::FastLog2(uint32)
    IL_0019:  ldc.i4.1
    IL_001a:  add
    IL_001b:  call       instance void Lua.Table::Resize(int32,
                                                         int32)
    IL_0020:  nop
    IL_0021:  ret
  } // end of method Table::Rehash

  .method public hidebysig specialname rtspecialname 
          instance void  .ctor(int32 narray,
                               int32 lnhash) cil managed
  {
    // Code size       44 (0x2c)
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  ldsfld     int32 Lua.Table::MAXBITS
    IL_0006:  ldc.i4.1
    IL_0007:  add
    IL_0008:  newarr     [mscorlib]System.Int32
    IL_000d:  stfld      int32[] Lua.Table::nums
    IL_0012:  ldarg.0
    IL_0013:  call       instance void Lua.Reference::.ctor()
    IL_0018:  nop
    IL_0019:  nop
    IL_001a:  ldarg.0
    IL_001b:  ldarg.1
    IL_001c:  call       instance void Lua.Table::SetArrayVector(int32)
    IL_0021:  nop
    IL_0022:  ldarg.0
    IL_0023:  ldarg.2
    IL_0024:  call       instance void Lua.Table::SetNodeVector(int32)
    IL_0029:  nop
    IL_002a:  nop
    IL_002b:  ret
  } // end of method Table::.ctor

  .method public hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    // Code size       12 (0xc)
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  ldc.i4.0
    IL_0002:  ldc.i4.0
    IL_0003:  call       instance void Lua.Table::.ctor(int32,
                                                        int32)
    IL_0008:  nop
    IL_0009:  nop
    IL_000a:  nop
    IL_000b:  ret
  } // end of method Table::.ctor

  .method private hidebysig instance class Lua.Node 
          NewKey(valuetype Lua.Value key) cil managed
  {
    // Code size       308 (0x134)
    .maxstack  3
    .locals init (class Lua.Node V_0,
             class Lua.Node V_1,
             class Lua.Node V_2,
             class Lua.Node V_3,
             class Lua.Node V_4,
             bool V_5)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldarg.1
    IL_0003:  call       instance class Lua.Node Lua.Table::MainPosition(valuetype Lua.Value)
    IL_0008:  stloc.0
    IL_0009:  ldloc.0
    IL_000a:  ldflda     valuetype Lua.Value Lua.Node::val
    IL_000f:  ldfld      class Lua.Reference Lua.Value::O
    IL_0014:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_0019:  ldfld      class Lua.Reference Lua.Value::O
    IL_001e:  ceq
    IL_0020:  stloc.s    V_5
    IL_0022:  ldloc.s    V_5
    IL_0024:  brtrue.s   IL_00a4

    IL_0026:  nop
    IL_0027:  ldarg.0
    IL_0028:  ldloc.0
    IL_0029:  ldfld      valuetype Lua.Value Lua.Node::key
    IL_002e:  call       instance class Lua.Node Lua.Table::MainPosition(valuetype Lua.Value)
    IL_0033:  stloc.1
    IL_0034:  ldarg.0
    IL_0035:  ldfld      class Lua.Node[] Lua.Table::node
    IL_003a:  ldarg.0
    IL_003b:  ldfld      int32 Lua.Table::firstFree
    IL_0040:  ldelem.ref
    IL_0041:  stloc.2
    IL_0042:  ldloc.1
    IL_0043:  ldloc.0
    IL_0044:  ceq
    IL_0046:  stloc.s    V_5
    IL_0048:  ldloc.s    V_5
    IL_004a:  brtrue.s   IL_008c

    IL_004c:  nop
    IL_004d:  br.s       IL_0056

    IL_004f:  ldloc.1
    IL_0050:  ldfld      class Lua.Node Lua.Node::next
    IL_0055:  stloc.1
    IL_0056:  ldloc.1
    IL_0057:  ldfld      class Lua.Node Lua.Node::next
    IL_005c:  ldloc.0
    IL_005d:  ceq
    IL_005f:  ldc.i4.0
    IL_0060:  ceq
    IL_0062:  stloc.s    V_5
    IL_0064:  ldloc.s    V_5
    IL_0066:  brtrue.s   IL_004f

    IL_0068:  ldloc.1
    IL_0069:  ldloc.2
    IL_006a:  stfld      class Lua.Node Lua.Node::next
    IL_006f:  ldloc.2
    IL_0070:  ldloc.0
    IL_0071:  callvirt   instance void Lua.Node::Copy(class Lua.Node)
    IL_0076:  nop
    IL_0077:  ldloc.0
    IL_0078:  ldnull
    IL_0079:  stfld      class Lua.Node Lua.Node::next
    IL_007e:  ldloc.0
    IL_007f:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_0084:  stfld      valuetype Lua.Value Lua.Node::val
    IL_0089:  nop
    IL_008a:  br.s       IL_00a3

    IL_008c:  nop
    IL_008d:  ldloc.2
    IL_008e:  ldloc.0
    IL_008f:  ldfld      class Lua.Node Lua.Node::next
    IL_0094:  stfld      class Lua.Node Lua.Node::next
    IL_0099:  ldloc.0
    IL_009a:  ldloc.2
    IL_009b:  stfld      class Lua.Node Lua.Node::next
    IL_00a0:  ldloc.2
    IL_00a1:  stloc.0
    IL_00a2:  nop
    IL_00a3:  nop
    IL_00a4:  ldloc.0
    IL_00a5:  ldarg.1
    IL_00a6:  stfld      valuetype Lua.Value Lua.Node::key
    IL_00ab:  br.s       IL_0102

    IL_00ad:  nop
    IL_00ae:  ldarg.0
    IL_00af:  ldfld      class Lua.Node[] Lua.Table::node
    IL_00b4:  ldarg.0
    IL_00b5:  ldfld      int32 Lua.Table::firstFree
    IL_00ba:  ldelem.ref
    IL_00bb:  ldflda     valuetype Lua.Value Lua.Node::key
    IL_00c0:  ldfld      class Lua.Reference Lua.Value::O
    IL_00c5:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_00ca:  ldfld      class Lua.Reference Lua.Value::O
    IL_00cf:  ceq
    IL_00d1:  ldc.i4.0
    IL_00d2:  ceq
    IL_00d4:  stloc.s    V_5
    IL_00d6:  ldloc.s    V_5
    IL_00d8:  brtrue.s   IL_00df

    IL_00da:  ldloc.0
    IL_00db:  stloc.s    V_4
    IL_00dd:  br.s       IL_0131

    IL_00df:  ldarg.0
    IL_00e0:  ldfld      int32 Lua.Table::firstFree
    IL_00e5:  ldc.i4.0
    IL_00e6:  ceq
    IL_00e8:  ldc.i4.0
    IL_00e9:  ceq
    IL_00eb:  stloc.s    V_5
    IL_00ed:  ldloc.s    V_5
    IL_00ef:  brtrue.s   IL_00f3

    IL_00f1:  br.s       IL_0107

    IL_00f3:  ldarg.0
    IL_00f4:  ldarg.0
    IL_00f5:  ldfld      int32 Lua.Table::firstFree
    IL_00fa:  ldc.i4.1
    IL_00fb:  sub
    IL_00fc:  stfld      int32 Lua.Table::firstFree
    IL_0101:  nop
    IL_0102:  ldc.i4.1
    IL_0103:  stloc.s    V_5
    IL_0105:  br.s       IL_00ad

    IL_0107:  ldloc.0
    IL_0108:  ldsfld     valuetype Lua.Value Lua.False::Instance
    IL_010d:  stfld      valuetype Lua.Value Lua.Node::val
    IL_0112:  ldarg.0
    IL_0113:  call       instance void Lua.Table::Rehash()
    IL_0118:  nop
    IL_0119:  ldarg.0
    IL_011a:  ldarg.1
    IL_011b:  call       instance class Lua.Node Lua.Table::Get(valuetype Lua.Value)
    IL_0120:  stloc.3
    IL_0121:  ldloc.3
    IL_0122:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_0127:  stfld      valuetype Lua.Value Lua.Node::val
    IL_012c:  ldloc.3
    IL_012d:  stloc.s    V_4
    IL_012f:  br.s       IL_0131

    IL_0131:  ldloc.s    V_4
    IL_0133:  ret
  } // end of method Table::NewKey

  .method private hidebysig instance class Lua.Node 
          GetAny(valuetype Lua.Value key) cil managed
  {
    // Code size       97 (0x61)
    .maxstack  2
    .locals init (class Lua.Node V_0,
             class Lua.Node V_1,
             bool V_2)
    IL_0000:  nop
    IL_0001:  ldarga.s   key
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_000d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0012:  ceq
    IL_0014:  ldc.i4.0
    IL_0015:  ceq
    IL_0017:  stloc.2
    IL_0018:  ldloc.2
    IL_0019:  brtrue.s   IL_0023

    IL_001b:  ldsfld     class Lua.Node Lua.Node::NilNode
    IL_0020:  stloc.1
    IL_0021:  br.s       IL_005f

    IL_0023:  nop
    IL_0024:  ldarg.0
    IL_0025:  ldarg.1
    IL_0026:  call       instance class Lua.Node Lua.Table::MainPosition(valuetype Lua.Value)
    IL_002b:  stloc.0
    IL_002c:  nop
    IL_002d:  ldarg.1
    IL_002e:  ldloc.0
    IL_002f:  ldfld      valuetype Lua.Value Lua.Node::key
    IL_0034:  call       bool Lua.Value::op_Equality(valuetype Lua.Value,
                                                     valuetype Lua.Value)
    IL_0039:  ldc.i4.0
    IL_003a:  ceq
    IL_003c:  stloc.2
    IL_003d:  ldloc.2
    IL_003e:  brtrue.s   IL_0044

    IL_0040:  ldloc.0
    IL_0041:  stloc.1
    IL_0042:  br.s       IL_005f

    IL_0044:  ldloc.0
    IL_0045:  ldfld      class Lua.Node Lua.Node::next
    IL_004a:  stloc.0
    IL_004b:  nop
    IL_004c:  ldloc.0
    IL_004d:  ldnull
    IL_004e:  ceq
    IL_0050:  ldc.i4.0
    IL_0051:  ceq
    IL_0053:  stloc.2
    IL_0054:  ldloc.2
    IL_0055:  brtrue.s   IL_002c

    IL_0057:  ldsfld     class Lua.Node Lua.Node::NilNode
    IL_005c:  stloc.1
    IL_005d:  br.s       IL_005f

    IL_005f:  ldloc.1
    IL_0060:  ret
  } // end of method Table::GetAny

  .method private hidebysig instance class Lua.Node 
          GetNum(int32 key) cil managed
  {
    // Code size       118 (0x76)
    .maxstack  3
    .locals init (float64 V_0,
             class Lua.Node V_1,
             class Lua.Node V_2,
             bool V_3)
    IL_0000:  nop
    IL_0001:  ldc.i4.1
    IL_0002:  ldarg.1
    IL_0003:  bgt.s      IL_0010

    IL_0005:  ldarg.1
    IL_0006:  ldarg.0
    IL_0007:  ldfld      int32 Lua.Table::sizeArray
    IL_000c:  cgt
    IL_000e:  br.s       IL_0011

    IL_0010:  ldc.i4.1
    IL_0011:  stloc.3
    IL_0012:  ldloc.3
    IL_0013:  brtrue.s   IL_0023

    IL_0015:  nop
    IL_0016:  ldarg.0
    IL_0017:  ldfld      class Lua.Node[] Lua.Table::'array'
    IL_001c:  ldarg.1
    IL_001d:  ldc.i4.1
    IL_001e:  sub
    IL_001f:  ldelem.ref
    IL_0020:  stloc.2
    IL_0021:  br.s       IL_0074

    IL_0023:  nop
    IL_0024:  ldarg.1
    IL_0025:  conv.r8
    IL_0026:  stloc.0
    IL_0027:  ldarg.0
    IL_0028:  ldloc.0
    IL_0029:  call       instance class Lua.Node Lua.Table::HashNum(float64)
    IL_002e:  stloc.1
    IL_002f:  nop
    IL_0030:  ldloc.1
    IL_0031:  ldflda     valuetype Lua.Value Lua.Node::key
    IL_0036:  ldfld      class Lua.Reference Lua.Value::O
    IL_003b:  brtrue.s   IL_0050

    IL_003d:  ldloc.1
    IL_003e:  ldflda     valuetype Lua.Value Lua.Node::key
    IL_0043:  ldfld      float64 Lua.Value::N
    IL_0048:  ldloc.0
    IL_0049:  ceq
    IL_004b:  ldc.i4.0
    IL_004c:  ceq
    IL_004e:  br.s       IL_0051

    IL_0050:  ldc.i4.1
    IL_0051:  stloc.3
    IL_0052:  ldloc.3
    IL_0053:  brtrue.s   IL_0059

    IL_0055:  ldloc.1
    IL_0056:  stloc.2
    IL_0057:  br.s       IL_0074

    IL_0059:  ldloc.1
    IL_005a:  ldfld      class Lua.Node Lua.Node::next
    IL_005f:  stloc.1
    IL_0060:  nop
    IL_0061:  ldloc.1
    IL_0062:  ldnull
    IL_0063:  ceq
    IL_0065:  ldc.i4.0
    IL_0066:  ceq
    IL_0068:  stloc.3
    IL_0069:  ldloc.3
    IL_006a:  brtrue.s   IL_002f

    IL_006c:  ldsfld     class Lua.Node Lua.Node::NilNode
    IL_0071:  stloc.2
    IL_0072:  br.s       IL_0074

    IL_0074:  ldloc.2
    IL_0075:  ret
  } // end of method Table::GetNum

  .method private hidebysig instance class Lua.Node 
          GetStr(class Lua.String key) cil managed
  {
    // Code size       83 (0x53)
    .maxstack  2
    .locals init (class Lua.Node V_0,
             class Lua.Node V_1,
             bool V_2)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldarg.1
    IL_0003:  call       instance class Lua.Node Lua.Table::HashRef(class Lua.Reference)
    IL_0008:  stloc.0
    IL_0009:  nop
    IL_000a:  ldloc.0
    IL_000b:  ldflda     valuetype Lua.Value Lua.Node::key
    IL_0010:  ldfld      class Lua.Reference Lua.Value::O
    IL_0015:  brfalse.s  IL_002d

    IL_0017:  ldarg.1
    IL_0018:  ldloc.0
    IL_0019:  ldflda     valuetype Lua.Value Lua.Node::key
    IL_001e:  ldfld      class Lua.Reference Lua.Value::O
    IL_0023:  callvirt   instance bool Lua.Reference::Equals(class Lua.Reference)
    IL_0028:  ldc.i4.0
    IL_0029:  ceq
    IL_002b:  br.s       IL_002e

    IL_002d:  ldc.i4.1
    IL_002e:  stloc.2
    IL_002f:  ldloc.2
    IL_0030:  brtrue.s   IL_0036

    IL_0032:  ldloc.0
    IL_0033:  stloc.1
    IL_0034:  br.s       IL_0051

    IL_0036:  ldloc.0
    IL_0037:  ldfld      class Lua.Node Lua.Node::next
    IL_003c:  stloc.0
    IL_003d:  nop
    IL_003e:  ldloc.0
    IL_003f:  ldnull
    IL_0040:  ceq
    IL_0042:  ldc.i4.0
    IL_0043:  ceq
    IL_0045:  stloc.2
    IL_0046:  ldloc.2
    IL_0047:  brtrue.s   IL_0009

    IL_0049:  ldsfld     class Lua.Node Lua.Node::NilNode
    IL_004e:  stloc.1
    IL_004f:  br.s       IL_0051

    IL_0051:  ldloc.1
    IL_0052:  ret
  } // end of method Table::GetStr

  .method private hidebysig instance class Lua.Node 
          Get(valuetype Lua.Value key) cil managed
  {
    // Code size       122 (0x7a)
    .maxstack  2
    .locals init (int32 V_0,
             class Lua.Node V_1,
             bool V_2)
    IL_0000:  nop
    IL_0001:  ldarga.s   key
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldnull
    IL_0009:  ceq
    IL_000b:  ldc.i4.0
    IL_000c:  ceq
    IL_000e:  stloc.2
    IL_000f:  ldloc.2
    IL_0010:  brtrue.s   IL_0042

    IL_0012:  nop
    IL_0013:  ldarga.s   key
    IL_0015:  ldfld      float64 Lua.Value::N
    IL_001a:  conv.i4
    IL_001b:  stloc.0
    IL_001c:  ldloc.0
    IL_001d:  conv.r8
    IL_001e:  ldarga.s   key
    IL_0020:  ldfld      float64 Lua.Value::N
    IL_0025:  ceq
    IL_0027:  ldc.i4.0
    IL_0028:  ceq
    IL_002a:  stloc.2
    IL_002b:  ldloc.2
    IL_002c:  brtrue.s   IL_0038

    IL_002e:  ldarg.0
    IL_002f:  ldloc.0
    IL_0030:  call       instance class Lua.Node Lua.Table::GetNum(int32)
    IL_0035:  stloc.1
    IL_0036:  br.s       IL_0078

    IL_0038:  ldarg.0
    IL_0039:  ldarg.1
    IL_003a:  call       instance class Lua.Node Lua.Table::GetAny(valuetype Lua.Value)
    IL_003f:  stloc.1
    IL_0040:  br.s       IL_0078

    IL_0042:  nop
    IL_0043:  ldarga.s   key
    IL_0045:  ldfld      class Lua.Reference Lua.Value::O
    IL_004a:  isinst     Lua.String
    IL_004f:  ldnull
    IL_0050:  cgt.un
    IL_0052:  ldc.i4.0
    IL_0053:  ceq
    IL_0055:  stloc.2
    IL_0056:  ldloc.2
    IL_0057:  brtrue.s   IL_006e

    IL_0059:  ldarg.0
    IL_005a:  ldarga.s   key
    IL_005c:  ldfld      class Lua.Reference Lua.Value::O
    IL_0061:  castclass  Lua.String
    IL_0066:  call       instance class Lua.Node Lua.Table::GetStr(class Lua.String)
    IL_006b:  stloc.1
    IL_006c:  br.s       IL_0078

    IL_006e:  ldarg.0
    IL_006f:  ldarg.1
    IL_0070:  call       instance class Lua.Node Lua.Table::GetAny(valuetype Lua.Value)
    IL_0075:  stloc.1
    IL_0076:  br.s       IL_0078

    IL_0078:  ldloc.1
    IL_0079:  ret
  } // end of method Table::Get

  .method private hidebysig instance void 
          Set(valuetype Lua.Value key,
              valuetype Lua.Value val) cil managed
  {
    // Code size       141 (0x8d)
    .maxstack  2
    .locals init (class Lua.Node V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldarg.1
    IL_0003:  call       instance class Lua.Node Lua.Table::Get(valuetype Lua.Value)
    IL_0008:  stloc.0
    IL_0009:  ldloc.0
    IL_000a:  ldsfld     class Lua.Node Lua.Node::NilNode
    IL_000f:  ceq
    IL_0011:  stloc.1
    IL_0012:  ldloc.1
    IL_0013:  brtrue.s   IL_0020

    IL_0015:  nop
    IL_0016:  ldloc.0
    IL_0017:  ldarg.2
    IL_0018:  stfld      valuetype Lua.Value Lua.Node::val
    IL_001d:  nop
    IL_001e:  br.s       IL_008c

    IL_0020:  nop
    IL_0021:  ldarga.s   key
    IL_0023:  ldfld      class Lua.Reference Lua.Value::O
    IL_0028:  brtrue.s   IL_003b

    IL_002a:  ldarga.s   key
    IL_002c:  ldfld      float64 Lua.Value::N
    IL_0031:  call       bool [mscorlib]System.Double::IsNaN(float64)
    IL_0036:  ldc.i4.0
    IL_0037:  ceq
    IL_0039:  br.s       IL_003c

    IL_003b:  ldc.i4.1
    IL_003c:  stloc.1
    IL_003d:  ldloc.1
    IL_003e:  brtrue.s   IL_004b

    IL_0040:  ldstr      "table index is NaN"
    IL_0045:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_004a:  throw

    IL_004b:  ldarga.s   key
    IL_004d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0052:  brfalse.s  IL_006c

    IL_0054:  ldarga.s   key
    IL_0056:  ldfld      class Lua.Reference Lua.Value::O
    IL_005b:  ldsfld     valuetype Lua.Value Lua.Nil::Instance
    IL_0060:  ldfld      class Lua.Reference Lua.Value::O
    IL_0065:  ceq
    IL_0067:  ldc.i4.0
    IL_0068:  ceq
    IL_006a:  br.s       IL_006d

    IL_006c:  ldc.i4.1
    IL_006d:  stloc.1
    IL_006e:  ldloc.1
    IL_006f:  brtrue.s   IL_007c

    IL_0071:  ldstr      "table index is nil"
    IL_0076:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_007b:  throw

    IL_007c:  ldarg.0
    IL_007d:  ldarg.1
    IL_007e:  call       instance class Lua.Node Lua.Table::NewKey(valuetype Lua.Value)
    IL_0083:  stloc.0
    IL_0084:  ldloc.0
    IL_0085:  ldarg.2
    IL_0086:  stfld      valuetype Lua.Value Lua.Node::val
    IL_008b:  nop
    IL_008c:  ret
  } // end of method Table::Set

  .method private hidebysig instance void 
          SetNum(int32 key,
                 valuetype Lua.Value val) cil managed
  {
    // Code size       67 (0x43)
    .maxstack  2
    .locals init (class Lua.Node V_0,
             valuetype Lua.Value V_1,
             bool V_2)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldarg.1
    IL_0003:  call       instance class Lua.Node Lua.Table::GetNum(int32)
    IL_0008:  stloc.0
    IL_0009:  ldloc.0
    IL_000a:  ldsfld     class Lua.Node Lua.Node::NilNode
    IL_000f:  ceq
    IL_0011:  stloc.2
    IL_0012:  ldloc.2
    IL_0013:  brtrue.s   IL_0020

    IL_0015:  nop
    IL_0016:  ldloc.0
    IL_0017:  ldarg.2
    IL_0018:  stfld      valuetype Lua.Value Lua.Node::val
    IL_001d:  nop
    IL_001e:  br.s       IL_0042

    IL_0020:  nop
    IL_0021:  ldloca.s   V_1
    IL_0023:  ldnull
    IL_0024:  stfld      class Lua.Reference Lua.Value::O
    IL_0029:  ldloca.s   V_1
    IL_002b:  ldarg.1
    IL_002c:  conv.r8
    IL_002d:  stfld      float64 Lua.Value::N
    IL_0032:  ldarg.0
    IL_0033:  ldloc.1
    IL_0034:  call       instance class Lua.Node Lua.Table::NewKey(valuetype Lua.Value)
    IL_0039:  stloc.0
    IL_003a:  ldloc.0
    IL_003b:  ldarg.2
    IL_003c:  stfld      valuetype Lua.Value Lua.Node::val
    IL_0041:  nop
    IL_0042:  ret
  } // end of method Table::SetNum

  .method private hidebysig instance class Lua.Node 
          MainPosition(valuetype Lua.Value key) cil managed
  {
    // Code size       52 (0x34)
    .maxstack  2
    .locals init (class Lua.Node V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarga.s   key
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldnull
    IL_0009:  ceq
    IL_000b:  ldc.i4.0
    IL_000c:  ceq
    IL_000e:  stloc.1
    IL_000f:  ldloc.1
    IL_0010:  brtrue.s   IL_0022

    IL_0012:  ldarg.0
    IL_0013:  ldarga.s   key
    IL_0015:  ldfld      float64 Lua.Value::N
    IL_001a:  call       instance class Lua.Node Lua.Table::HashNum(float64)
    IL_001f:  stloc.0
    IL_0020:  br.s       IL_0032

    IL_0022:  ldarg.0
    IL_0023:  ldarga.s   key
    IL_0025:  ldfld      class Lua.Reference Lua.Value::O
    IL_002a:  call       instance class Lua.Node Lua.Table::HashRef(class Lua.Reference)
    IL_002f:  stloc.0
    IL_0030:  br.s       IL_0032

    IL_0032:  ldloc.0
    IL_0033:  ret
  } // end of method Table::MainPosition

  .method private hidebysig instance class Lua.Node 
          HashNum(float64 n) cil managed
  {
    // Code size       38 (0x26)
    .maxstack  4
    .locals init (uint32 V_0,
             class Lua.Node V_1)
    IL_0000:  nop
    IL_0001:  ldarga.s   n
    IL_0003:  call       instance int32 [mscorlib]System.Double::GetHashCode()
    IL_0008:  stloc.0
    IL_0009:  ldarg.0
    IL_000a:  ldfld      class Lua.Node[] Lua.Table::node
    IL_000f:  ldloc.0
    IL_0010:  conv.u8
    IL_0011:  ldarg.0
    IL_0012:  ldfld      class Lua.Node[] Lua.Table::node
    IL_0017:  ldlen
    IL_0018:  conv.i4
    IL_0019:  ldc.i4.1
    IL_001a:  sub
    IL_001b:  ldc.i4.1
    IL_001c:  or
    IL_001d:  conv.i8
    IL_001e:  rem
    IL_001f:  conv.ovf.i
    IL_0020:  ldelem.ref
    IL_0021:  stloc.1
    IL_0022:  br.s       IL_0024

    IL_0024:  ldloc.1
    IL_0025:  ret
  } // end of method Table::HashNum

  .method private hidebysig instance class Lua.Node 
          HashRef(class Lua.Reference r) cil managed
  {
    // Code size       35 (0x23)
    .maxstack  4
    .locals init (class Lua.Node V_0)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Node[] Lua.Table::node
    IL_0007:  ldarg.1
    IL_0008:  callvirt   instance int32 [mscorlib]System.Object::GetHashCode()
    IL_000d:  conv.u8
    IL_000e:  ldarg.0
    IL_000f:  ldfld      class Lua.Node[] Lua.Table::node
    IL_0014:  ldlen
    IL_0015:  conv.i4
    IL_0016:  ldc.i4.1
    IL_0017:  sub
    IL_0018:  ldc.i4.1
    IL_0019:  or
    IL_001a:  conv.i8
    IL_001b:  rem
    IL_001c:  conv.ovf.i
    IL_001d:  ldelem.ref
    IL_001e:  stloc.0
    IL_001f:  br.s       IL_0021

    IL_0021:  ldloc.0
    IL_0022:  ret
  } // end of method Table::HashRef

  .method public hidebysig specialname virtual 
          instance class Lua.Table  get_Metatable() cil managed
  {
    // Code size       12 (0xc)
    .maxstack  1
    .locals init (class Lua.Table V_0)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Table Lua.Table::_meta
    IL_0007:  stloc.0
    IL_0008:  br.s       IL_000a

    IL_000a:  ldloc.0
    IL_000b:  ret
  } // end of method Table::get_Metatable

  .method public hidebysig specialname virtual 
          instance void  set_Metatable(class Lua.Table 'value') cil managed
  {
    // Code size       9 (0x9)
    .maxstack  8
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldarg.1
    IL_0003:  stfld      class Lua.Table Lua.Table::_meta
    IL_0008:  ret
  } // end of method Table::set_Metatable

  .method public hidebysig specialname virtual 
          instance valuetype Lua.Value  get_Item(valuetype Lua.Value index) cil managed
  {
    // Code size       18 (0x12)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldarg.1
    IL_0003:  call       instance class Lua.Node Lua.Table::Get(valuetype Lua.Value)
    IL_0008:  ldfld      valuetype Lua.Value Lua.Node::val
    IL_000d:  stloc.0
    IL_000e:  br.s       IL_0010

    IL_0010:  ldloc.0
    IL_0011:  ret
  } // end of method Table::get_Item

  .method public hidebysig specialname virtual 
          instance void  set_Item(valuetype Lua.Value index,
                                  valuetype Lua.Value 'value') cil managed
  {
    // Code size       11 (0xb)
    .maxstack  8
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldarg.1
    IL_0003:  ldarg.2
    IL_0004:  call       instance void Lua.Table::Set(valuetype Lua.Value,
                                                      valuetype Lua.Value)
    IL_0009:  nop
    IL_000a:  ret
  } // end of method Table::set_Item

  .method public hidebysig specialname instance valuetype Lua.Value 
          get_Item(class Lua.String index) cil managed
  {
    // Code size       18 (0x12)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldarg.1
    IL_0003:  call       instance class Lua.Node Lua.Table::GetStr(class Lua.String)
    IL_0008:  ldfld      valuetype Lua.Value Lua.Node::val
    IL_000d:  stloc.0
    IL_000e:  br.s       IL_0010

    IL_0010:  ldloc.0
    IL_0011:  ret
  } // end of method Table::get_Item

  .method public hidebysig virtual instance bool 
          Equals(class Lua.Reference r) cil managed
  {
    // Code size       10 (0xa)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarg.1
    IL_0002:  ldarg.0
    IL_0003:  ceq
    IL_0005:  stloc.0
    IL_0006:  br.s       IL_0008

    IL_0008:  ldloc.0
    IL_0009:  ret
  } // end of method Table::Equals

  .method public hidebysig virtual instance bool 
          LessThan(class Lua.Reference r) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation < not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::LessThan

  .method public hidebysig virtual instance bool 
          LessThanOrEqual(class Lua.Reference r) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation <= not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::LessThanOrEqual

  .method public hidebysig virtual instance valuetype Lua.Value 
          Length() cil managed
  {
    // Code size       29 (0x1d)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0,
             valuetype Lua.Value V_1)
    IL_0000:  nop
    IL_0001:  ldloca.s   V_0
    IL_0003:  ldnull
    IL_0004:  stfld      class Lua.Reference Lua.Value::O
    IL_0009:  ldloca.s   V_0
    IL_000b:  ldarg.0
    IL_000c:  ldfld      int32 Lua.Table::sizeArray
    IL_0011:  conv.r8
    IL_0012:  stfld      float64 Lua.Value::N
    IL_0017:  ldloc.0
    IL_0018:  stloc.1
    IL_0019:  br.s       IL_001b

    IL_001b:  ldloc.1
    IL_001c:  ret
  } // end of method Table::Length

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value[] args) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation call not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke() cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation call not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value arg1) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation call not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value arg1,
                 valuetype Lua.Value arg2) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation call not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value arg1,
                 valuetype Lua.Value arg2,
                 valuetype Lua.Value arg3) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation call not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value arg1,
                 valuetype Lua.Value arg2,
                 valuetype Lua.Value arg3,
                 valuetype Lua.Value arg4) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation call not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value arg1,
                 valuetype Lua.Value arg2,
                 valuetype Lua.Value arg3,
                 valuetype Lua.Value arg4,
                 valuetype Lua.Value arg5) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation call not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value arg1,
                 valuetype Lua.Value arg2,
                 valuetype Lua.Value arg3,
                 valuetype Lua.Value arg4,
                 valuetype Lua.Value arg5,
                 valuetype Lua.Value arg6) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation call not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::Invoke

  .method public hidebysig virtual instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value arg1,
                 valuetype Lua.Value arg2,
                 valuetype Lua.Value arg3,
                 valuetype Lua.Value arg4,
                 valuetype Lua.Value arg5,
                 valuetype Lua.Value arg6,
                 valuetype Lua.Value arg7) cil managed
  {
    // Code size       12 (0xc)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0)
    IL_0000:  nop
    IL_0001:  ldstr      "operation call not supported on tables"
    IL_0006:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_000b:  throw
  } // end of method Table::Invoke

  .method private hidebysig specialname rtspecialname static 
          void  .cctor() cil managed
  {
    // Code size       34 (0x22)
    .maxstack  8
    IL_0000:  ldc.i4.s   32
    IL_0002:  stsfld     int32 Lua.Table::MAXBITS
    IL_0007:  ldc.i4     0xff
    IL_000c:  newarr     [mscorlib]System.Byte
    IL_0011:  dup
    IL_0012:  ldtoken    field valuetype '<PrivateImplementationDetails>{72DBCB57-0874-452F-AFE2-4514C519BD5B}'/'__StaticArrayInitTypeSize=255' '<PrivateImplementationDetails>{72DBCB57-0874-452F-AFE2-4514C519BD5B}'::'$$method0x600008b-1'
    IL_0017:  call       void [mscorlib]System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(class [mscorlib]System.Array,
                                                                                                        valuetype [mscorlib]System.RuntimeFieldHandle)
    IL_001c:  stsfld     uint8[] Lua.Table::log_8
    IL_0021:  ret
  } // end of method Table::.cctor

  .property instance class Lua.Table Metatable()
  {
    .get instance class Lua.Table Lua.Table::get_Metatable()
    .set instance void Lua.Table::set_Metatable(class Lua.Table)
  } // end of property Table::Metatable
  .property instance valuetype Lua.Value Item(valuetype Lua.Value)
  {
    .set instance void Lua.Table::set_Item(valuetype Lua.Value,
                                           valuetype Lua.Value)
    .get instance valuetype Lua.Value Lua.Table::get_Item(valuetype Lua.Value)
  } // end of property Table::Item
  .property instance valuetype Lua.Value Item(class Lua.String)
  {
    .get instance valuetype Lua.Value Lua.Table::get_Item(class Lua.String)
  } // end of property Table::Item
} // end of class Lua.Table

.class public sequential ansi sealed beforefieldinit Lua.Value
       extends [mscorlib]System.ValueType
{
  .custom instance void [mscorlib]System.Reflection.DefaultMemberAttribute::.ctor(string) = ( 01 00 04 49 74 65 6D 00 00 )                      // ...Item..
  .field public float64 N
  .field public class Lua.Reference O
  .field private static class Lua.Table Meta
  .method public hidebysig specialname static 
          bool  op_Equality(valuetype Lua.Value v1,
                            valuetype Lua.Value v2) cil managed
  {
    // Code size       70 (0x46)
    .maxstack  2
    .locals init (bool V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarga.s   v1
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  brtrue.s   IL_0019

    IL_000a:  ldarga.s   v2
    IL_000c:  ldfld      class Lua.Reference Lua.Value::O
    IL_0011:  ldnull
    IL_0012:  ceq
    IL_0014:  ldc.i4.0
    IL_0015:  ceq
    IL_0017:  br.s       IL_001a

    IL_0019:  ldc.i4.1
    IL_001a:  stloc.1
    IL_001b:  ldloc.1
    IL_001c:  brtrue.s   IL_0031

    IL_001e:  ldarga.s   v1
    IL_0020:  ldfld      float64 Lua.Value::N
    IL_0025:  ldarga.s   v2
    IL_0027:  ldfld      float64 Lua.Value::N
    IL_002c:  ceq
    IL_002e:  stloc.0
    IL_002f:  br.s       IL_0044

    IL_0031:  ldarga.s   v1
    IL_0033:  ldfld      class Lua.Reference Lua.Value::O
    IL_0038:  ldarga.s   v2
    IL_003a:  ldfld      class Lua.Reference Lua.Value::O
    IL_003f:  ceq
    IL_0041:  stloc.0
    IL_0042:  br.s       IL_0044

    IL_0044:  ldloc.0
    IL_0045:  ret
  } // end of method Value::op_Equality

  .method public hidebysig specialname static 
          bool  op_Inequality(valuetype Lua.Value v1,
                              valuetype Lua.Value v2) cil managed
  {
    // Code size       16 (0x10)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldarg.1
    IL_0003:  call       bool Lua.Value::op_Equality(valuetype Lua.Value,
                                                     valuetype Lua.Value)
    IL_0008:  ldc.i4.0
    IL_0009:  ceq
    IL_000b:  stloc.0
    IL_000c:  br.s       IL_000e

    IL_000e:  ldloc.0
    IL_000f:  ret
  } // end of method Value::op_Inequality

  .method public hidebysig virtual instance bool 
          Equals(object o) cil managed
  {
    // Code size       34 (0x22)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarg.1
    IL_0002:  isinst     Lua.Value
    IL_0007:  brfalse.s  IL_001c

    IL_0009:  ldarg.1
    IL_000a:  unbox.any  Lua.Value
    IL_000f:  ldarg.0
    IL_0010:  ldobj      Lua.Value
    IL_0015:  call       bool Lua.Value::op_Equality(valuetype Lua.Value,
                                                     valuetype Lua.Value)
    IL_001a:  br.s       IL_001d

    IL_001c:  ldc.i4.0
    IL_001d:  stloc.0
    IL_001e:  br.s       IL_0020

    IL_0020:  ldloc.0
    IL_0021:  ret
  } // end of method Value::Equals

  .method public hidebysig virtual instance int32 
          GetHashCode() cil managed
  {
    // Code size       47 (0x2f)
    .maxstack  2
    .locals init (int32 V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001f

    IL_0011:  ldarg.0
    IL_0012:  ldflda     float64 Lua.Value::N
    IL_0017:  call       instance int32 [mscorlib]System.Double::GetHashCode()
    IL_001c:  stloc.0
    IL_001d:  br.s       IL_002d

    IL_001f:  ldarg.0
    IL_0020:  ldfld      class Lua.Reference Lua.Value::O
    IL_0025:  callvirt   instance int32 [mscorlib]System.Object::GetHashCode()
    IL_002a:  stloc.0
    IL_002b:  br.s       IL_002d

    IL_002d:  ldloc.0
    IL_002e:  ret
  } // end of method Value::GetHashCode

  .method public hidebysig specialname instance class Lua.Table 
          get_Metatable() cil managed
  {
    // Code size       41 (0x29)
    .maxstack  2
    .locals init (class Lua.Table V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_0019

    IL_0011:  ldsfld     class Lua.Table Lua.Value::Meta
    IL_0016:  stloc.0
    IL_0017:  br.s       IL_0027

    IL_0019:  ldarg.0
    IL_001a:  ldfld      class Lua.Reference Lua.Value::O
    IL_001f:  callvirt   instance class Lua.Table Lua.Reference::get_Metatable()
    IL_0024:  stloc.0
    IL_0025:  br.s       IL_0027

    IL_0027:  ldloc.0
    IL_0028:  ret
  } // end of method Value::get_Metatable

  .method public hidebysig specialname instance void 
          set_Metatable(class Lua.Table 'value') cil managed
  {
    // Code size       39 (0x27)
    .maxstack  2
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.0
    IL_000e:  ldloc.0
    IL_000f:  brtrue.s   IL_0019

    IL_0011:  ldarg.1
    IL_0012:  stsfld     class Lua.Table Lua.Value::Meta
    IL_0017:  br.s       IL_0026

    IL_0019:  ldarg.0
    IL_001a:  ldfld      class Lua.Reference Lua.Value::O
    IL_001f:  ldarg.1
    IL_0020:  callvirt   instance void Lua.Reference::set_Metatable(class Lua.Table)
    IL_0025:  nop
    IL_0026:  ret
  } // end of method Value::set_Metatable

  .method public hidebysig static valuetype Lua.Value 
          Length(valuetype Lua.Value v) cil managed
  {
    // Code size       46 (0x2e)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarga.s   v
    IL_0003:  ldfld      class Lua.Reference Lua.Value::O
    IL_0008:  ldnull
    IL_0009:  ceq
    IL_000b:  ldc.i4.0
    IL_000c:  ceq
    IL_000e:  stloc.1
    IL_000f:  ldloc.1
    IL_0010:  brtrue.s   IL_001d

    IL_0012:  ldstr      "numbers do not have length"
    IL_0017:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001c:  throw

    IL_001d:  ldarga.s   v
    IL_001f:  ldfld      class Lua.Reference Lua.Value::O
    IL_0024:  callvirt   instance valuetype Lua.Value Lua.Reference::Length()
    IL_0029:  stloc.0
    IL_002a:  br.s       IL_002c

    IL_002c:  ldloc.0
    IL_002d:  ret
  } // end of method Value::Length

  .method public hidebysig specialname instance valuetype Lua.Value 
          get_Item(valuetype Lua.Value key) cil managed
  {
    // Code size       45 (0x2d)
    .maxstack  2
    .locals init (valuetype Lua.Value V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot index a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  ldarg.1
    IL_0023:  callvirt   instance valuetype Lua.Value Lua.Reference::get_Item(valuetype Lua.Value)
    IL_0028:  stloc.0
    IL_0029:  br.s       IL_002b

    IL_002b:  ldloc.0
    IL_002c:  ret
  } // end of method Value::get_Item

  .method public hidebysig specialname instance void 
          set_Item(valuetype Lua.Value key,
                   valuetype Lua.Value 'value') cil managed
  {
    // Code size       43 (0x2b)
    .maxstack  3
    .locals init (bool V_0)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.0
    IL_000e:  ldloc.0
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot index a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  ldarg.1
    IL_0023:  ldarg.2
    IL_0024:  callvirt   instance void Lua.Reference::set_Item(valuetype Lua.Value,
                                                               valuetype Lua.Value)
    IL_0029:  nop
    IL_002a:  ret
  } // end of method Value::set_Item

  .method public hidebysig instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value[] args) cil managed
  {
    // Code size       45 (0x2d)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot call a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  ldarg.1
    IL_0023:  callvirt   instance valuetype Lua.Value[] Lua.Reference::Invoke(valuetype Lua.Value[])
    IL_0028:  stloc.0
    IL_0029:  br.s       IL_002b

    IL_002b:  ldloc.0
    IL_002c:  ret
  } // end of method Value::Invoke

  .method public hidebysig instance valuetype Lua.Value[] 
          Invoke() cil managed
  {
    // Code size       44 (0x2c)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot call a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  callvirt   instance valuetype Lua.Value[] Lua.Reference::Invoke()
    IL_0027:  stloc.0
    IL_0028:  br.s       IL_002a

    IL_002a:  ldloc.0
    IL_002b:  ret
  } // end of method Value::Invoke

  .method public hidebysig instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1) cil managed
  {
    // Code size       45 (0x2d)
    .maxstack  2
    .locals init (valuetype Lua.Value[] V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot call a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  ldarg.1
    IL_0023:  callvirt   instance valuetype Lua.Value[] Lua.Reference::Invoke(valuetype Lua.Value)
    IL_0028:  stloc.0
    IL_0029:  br.s       IL_002b

    IL_002b:  ldloc.0
    IL_002c:  ret
  } // end of method Value::Invoke

  .method public hidebysig instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2) cil managed
  {
    // Code size       46 (0x2e)
    .maxstack  3
    .locals init (valuetype Lua.Value[] V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot call a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  ldarg.1
    IL_0023:  ldarg.2
    IL_0024:  callvirt   instance valuetype Lua.Value[] Lua.Reference::Invoke(valuetype Lua.Value,
                                                                              valuetype Lua.Value)
    IL_0029:  stloc.0
    IL_002a:  br.s       IL_002c

    IL_002c:  ldloc.0
    IL_002d:  ret
  } // end of method Value::Invoke

  .method public hidebysig instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3) cil managed
  {
    // Code size       47 (0x2f)
    .maxstack  4
    .locals init (valuetype Lua.Value[] V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot call a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  ldarg.1
    IL_0023:  ldarg.2
    IL_0024:  ldarg.3
    IL_0025:  callvirt   instance valuetype Lua.Value[] Lua.Reference::Invoke(valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value)
    IL_002a:  stloc.0
    IL_002b:  br.s       IL_002d

    IL_002d:  ldloc.0
    IL_002e:  ret
  } // end of method Value::Invoke

  .method public hidebysig instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4) cil managed
  {
    // Code size       49 (0x31)
    .maxstack  5
    .locals init (valuetype Lua.Value[] V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot call a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  ldarg.1
    IL_0023:  ldarg.2
    IL_0024:  ldarg.3
    IL_0025:  ldarg.s    a4
    IL_0027:  callvirt   instance valuetype Lua.Value[] Lua.Reference::Invoke(valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value)
    IL_002c:  stloc.0
    IL_002d:  br.s       IL_002f

    IL_002f:  ldloc.0
    IL_0030:  ret
  } // end of method Value::Invoke

  .method public hidebysig instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5) cil managed
  {
    // Code size       51 (0x33)
    .maxstack  6
    .locals init (valuetype Lua.Value[] V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot call a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  ldarg.1
    IL_0023:  ldarg.2
    IL_0024:  ldarg.3
    IL_0025:  ldarg.s    a4
    IL_0027:  ldarg.s    a5
    IL_0029:  callvirt   instance valuetype Lua.Value[] Lua.Reference::Invoke(valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value)
    IL_002e:  stloc.0
    IL_002f:  br.s       IL_0031

    IL_0031:  ldloc.0
    IL_0032:  ret
  } // end of method Value::Invoke

  .method public hidebysig instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5,
                 valuetype Lua.Value a6) cil managed
  {
    // Code size       53 (0x35)
    .maxstack  7
    .locals init (valuetype Lua.Value[] V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot call a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  ldarg.1
    IL_0023:  ldarg.2
    IL_0024:  ldarg.3
    IL_0025:  ldarg.s    a4
    IL_0027:  ldarg.s    a5
    IL_0029:  ldarg.s    a6
    IL_002b:  callvirt   instance valuetype Lua.Value[] Lua.Reference::Invoke(valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value)
    IL_0030:  stloc.0
    IL_0031:  br.s       IL_0033

    IL_0033:  ldloc.0
    IL_0034:  ret
  } // end of method Value::Invoke

  .method public hidebysig instance valuetype Lua.Value[] 
          Invoke(valuetype Lua.Value a1,
                 valuetype Lua.Value a2,
                 valuetype Lua.Value a3,
                 valuetype Lua.Value a4,
                 valuetype Lua.Value a5,
                 valuetype Lua.Value a6,
                 valuetype Lua.Value a7) cil managed
  {
    // Code size       55 (0x37)
    .maxstack  8
    .locals init (valuetype Lua.Value[] V_0,
             bool V_1)
    IL_0000:  nop
    IL_0001:  ldarg.0
    IL_0002:  ldfld      class Lua.Reference Lua.Value::O
    IL_0007:  ldnull
    IL_0008:  ceq
    IL_000a:  ldc.i4.0
    IL_000b:  ceq
    IL_000d:  stloc.1
    IL_000e:  ldloc.1
    IL_000f:  brtrue.s   IL_001c

    IL_0011:  ldstr      "you cannot call a number"
    IL_0016:  newobj     instance void [mscorlib]System.Exception::.ctor(string)
    IL_001b:  throw

    IL_001c:  ldarg.0
    IL_001d:  ldfld      class Lua.Reference Lua.Value::O
    IL_0022:  ldarg.1
    IL_0023:  ldarg.2
    IL_0024:  ldarg.3
    IL_0025:  ldarg.s    a4
    IL_0027:  ldarg.s    a5
    IL_0029:  ldarg.s    a6
    IL_002b:  ldarg.s    a7
    IL_002d:  callvirt   instance valuetype Lua.Value[] Lua.Reference::Invoke(valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value,
                                                                              valuetype Lua.Value)
    IL_0032:  stloc.0
    IL_0033:  br.s       IL_0035

    IL_0035:  ldloc.0
    IL_0036:  ret
  } // end of method Value::Invoke

  .property instance class Lua.Table Metatable()
  {
    .get instance class Lua.Table Lua.Value::get_Metatable()
    .set instance void Lua.Value::set_Metatable(class Lua.Table)
  } // end of property Value::Metatable
  .property instance valuetype Lua.Value Item(valuetype Lua.Value)
  {
    .get instance valuetype Lua.Value Lua.Value::get_Item(valuetype Lua.Value)
    .set instance void Lua.Value::set_Item(valuetype Lua.Value,
                                           valuetype Lua.Value)
  } // end of property Value::Item
} // end of class Lua.Value

.class private auto ansi '<PrivateImplementationDetails>{72DBCB57-0874-452F-AFE2-4514C519BD5B}'
       extends [mscorlib]System.Object
{
  .custom instance void [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::.ctor() = ( 01 00 00 00 ) 
  .class explicit ansi sealed nested private '__StaticArrayInitTypeSize=255'
         extends [mscorlib]System.ValueType
  {
    .pack 1
    .size 255
  } // end of class '__StaticArrayInitTypeSize=255'

  .field static assembly valuetype '<PrivateImplementationDetails>{72DBCB57-0874-452F-AFE2-4514C519BD5B}'/'__StaticArrayInitTypeSize=255' '$$method0x600008b-1' at I_00003408
} // end of class '<PrivateImplementationDetails>{72DBCB57-0874-452F-AFE2-4514C519BD5B}'


// =============================================================

.data cil I_00003408 = bytearray (
                 00 01 01 02 02 02 02 03 03 03 03 03 03 03 03 04
                 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 05
                 05 05 05 05 05 05 05 05 05 05 05 05 05 05 05 05
                 05 05 05 05 05 05 05 05 05 05 05 05 05 05 05 06
                 06 06 06 06 06 06 06 06 06 06 06 06 06 06 06 06
                 06 06 06 06 06 06 06 06 06 06 06 06 06 06 06 06
                 06 06 06 06 06 06 06 06 06 06 06 06 06 06 06 06
                 06 06 06 06 06 06 06 06 06 06 06 06 06 06 06 07
                 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07
                 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07
                 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07
                 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07
                 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07
                 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07
                 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07
                 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07) 
// *********** DISASSEMBLY COMPLETE ***********************
// WARNING: Created Win32 resource file lua.res
