with Interfaces.C;

--  A round trip: Ada exports to C, C calls back into Ada, and Ada imports the C that does it.
--
--  An original exercise; AdaCore's Laboratories has no Interfacing With C chapter.
package C_Statistics is

   subtype C_Int is Interfaces.C.int;

   --  Exported. summary.c declares this extern and calls it, knowing nothing about Ada.
   function Mean (A, B : C_Int) return C_Int
     with Export, Convention => C, External_Name => "ada_mean";

   --  Exported too, and a variable rather than a subprogram. C increments it directly.
   Call_Count : C_Int := 0
     with Export, Convention => C, External_Name => "ada_call_count";

   --  Imported from summary.c, which is what calls Mean.
   function Summarise (A, B : C_Int) return C_Int
     with Import, Convention => C, External_Name => "summarise";

   function Summarise_Three (A, B, C : C_Int) return C_Int
     with Import, Convention => C, External_Name => "summarise_three";

   procedure Reset;

end C_Statistics;
