with Ada.Command_Line;
with Ada_Check;
with Type_Extension;

procedure Test_Type_Extension is
   use Type_Extension;

   F1 : constant T_Float := Init (2.0);
   F2 : constant T_Float := Init (3);
   M1 : constant T_Mixed := Init (4.0);
   M2 : constant T_Mixed := Init (5);

   --  Which Init runs is settled by what the result is declared to be -- return-type
   --  overloading, from More About Types, now choosing between a type and its extension.
   Wide : constant T_Float'Class := M1;
begin
   Ada_Check.Suite ("Simple Type Extension");

   Ada_Check.Check ("a T_Mixed is in T_Float'Class", M1 in T_Float'Class);
   Ada_Check.Check ("and so is a T_Float",           F1 in T_Float'Class);

   Ada_Check.Equal ("F1 built from a Float",   Image (F1), "{ F =>  2.00000E+00 }");
   Ada_Check.Equal ("F2 built from an Integer", Image (F2), "{ F =>  3.00000E+00 }");
   Ada_Check.Equal ("M1 built from a Float",
                    Image (M1), "{ F =>  4.00000E+00, I =>  4 }");
   Ada_Check.Equal ("M2 built from an Integer",
                    Image (M2), "{ F =>  5.00000E+00, I =>  5 }");

   --  Through a classwide view the tag decides, so this reaches T_Mixed's Image even though
   --  the variable is declared as the parent's class.
   Ada_Check.Equal ("dispatching reaches the extension's Image",
                    Image (Wide), "{ F =>  4.00000E+00, I =>  4 }");

   --  A view conversion looks at the same object as its parent type, and dispatch follows the
   --  view rather than what is really there.
   Ada_Check.Equal ("viewed as the parent, the parent's Image runs",
                    Image (T_Float (M1)), "{ F =>  4.00000E+00 }");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Type_Extension;
