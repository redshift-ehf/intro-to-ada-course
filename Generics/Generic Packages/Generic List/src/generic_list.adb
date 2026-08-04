with Ada.Text_IO;

package body Generic_List is

   procedure Init is
   begin
      Last := 0;
   end Init;

   procedure Add (I : Item; Status : out Boolean) is
   begin
      Status := Last < List_Array'Length;
      if Status then
         Last := Last + 1;
         List_Array (List_Array'First + Last - 1) := I;
      end if;
   end Add;

   procedure Display is
   begin
      --  Ada.Text_IO is named rather than used, because this generic has a formal called Put
      --  and an unqualified one would be ambiguous the moment anyone said `use Ada.Text_IO`.
      Ada.Text_IO.Put_Line (Name);
      for K in List_Array'First .. List_Array'First + Last - 1 loop
         Put (List_Array (K));
         Ada.Text_IO.New_Line;
      end loop;
   end Display;

end Generic_List;
