with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;

package body List_Of_Names is

   --  Given: a name padded out to the fixed width, or cut down to it.
   function Padded (S : String) return Name_Type is
      Result : Name_Type := (others => ' ');
      Count  : constant Natural := Natural'Min (S'Length, Result'Length);
   begin
      Result (1 .. Count) := S (S'First .. S'First + Count - 1);
      return Result;
   end Padded;

   --  Given: the name with its padding taken back off.
   function Trimmed (N : Name_Type) return String is
     (Ada.Strings.Fixed.Trim (N, Ada.Strings.Right));

   --  Given, as the shape the rest follow.
   procedure Reset (P : in out People) is
   begin
      P.Last_Valid := 0;
   end Reset;

   procedure Add (P : in out People; Name : String) is
   begin
      if P.Last_Valid < P.People_A'Last then
         P.Last_Valid := P.Last_Valid + 1;
         P.People_A (P.Last_Valid) := (Name => Padded (Name), Age => 0);
      end if;
   end Add;

   function Get (P : People; Name : String) return Age_Type is
      Wanted : constant Name_Type := Padded (Name);
   begin
      for I in 1 .. P.Last_Valid loop
         if P.People_A (I).Name = Wanted then
            return P.People_A (I).Age;
         end if;
      end loop;
      return 0;
   end Get;

   procedure Update (P : in out People; Name : String; Age : Age_Type) is
      Wanted : constant Name_Type := Padded (Name);
   begin
      for I in 1 .. P.Last_Valid loop
         if P.People_A (I).Name = Wanted then
            P.People_A (I).Age := Age;
            return;
         end if;
      end loop;
   end Update;

   procedure Display (P : People) is
      --  The filled-in part of the array under its own name. Renaming a slice, so this is that
      --  part of the array rather than a copy of it -- and it keeps the indices it had.
      Valid : People_Array renames P.People_A (1 .. P.Last_Valid);
   begin
      Put_Line ("LIST OF NAMES:");
      for I in Valid'Range loop
         Put_Line ("NAME: " & Trimmed (Valid (I).Name));
         Put_Line ("AGE: " & Age_Type'Image (Valid (I).Age));
      end loop;
   end Display;

end List_Of_Names;
