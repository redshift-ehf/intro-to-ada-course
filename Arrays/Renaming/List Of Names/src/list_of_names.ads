--  A short list of people and their ages, held in an array inside a record.
package List_Of_Names is

   Max_People : constant := 10;

   subtype Age_Type is Natural range 0 .. 150;

   --  Names are a fixed width so that a Person is a fixed size, which is what lets an array of
   --  them exist at all. The padding is dealt with by Padded and Trimmed in the body.
   subtype Name_Type is String (1 .. 20);

   type Person is record
      Name : Name_Type := (others => ' ');
      Age  : Age_Type  := 0;
   end record;

   type People_Array is array (Positive range <>) of Person;

   --  The array is always Max_People long. Last_Valid says how much of it means anything --
   --  which is the usual way to get a growable list out of a fixed one.
   type People is record
      People_A   : People_Array (1 .. Max_People);
      Last_Valid : Natural := 0;
   end record;

   procedure Reset (P : in out People);

   procedure Add (P : in out People; Name : String);

   function Get (P : People; Name : String) return Age_Type;

   procedure Update (P : in out People; Name : String; Age : Age_Type);

   procedure Display (P : People);

end List_Of_Names;
