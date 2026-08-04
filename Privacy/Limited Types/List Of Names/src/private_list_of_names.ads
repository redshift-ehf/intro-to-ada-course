--  The Arrays chapter's list of names, with the types made limited private.
--
--  The unit is Private_List_Of_Names because `List_Of_Names` belongs to Arrays.
package Private_List_Of_Names is

   Max_People : constant := 10;

   subtype Age_Type is Natural range 0 .. 150;

   --  Limited private: a list cannot be copied and cannot be compared. Both would be plausible
   --  and neither is wanted -- copying one would silently duplicate ten people.
   type People is limited private;

   procedure Reset (P : in out People);

   procedure Add (P : in out People; Name : String);

   function Get (P : People; Name : String) return Age_Type;

   procedure Update (P : in out People; Name : String; Age : Age_Type);

   procedure Display (P : People);

   --  Last_Valid used to be reachable from outside. It is not now, so the count it stood for
   --  gets a function of its own.
   function Count (P : People) return Natural;

private

   subtype Name_Type is String (1 .. 20);

   type Person is limited record
      Name : Name_Type := (others => ' ');
      Age  : Age_Type  := 0;
   end record;

   type People_Array is array (Positive range <>) of Person;

   type People is limited record
      People_A   : People_Array (1 .. Max_People);
      Last_Valid : Natural := 0;
   end record;

end Private_List_Of_Names;
