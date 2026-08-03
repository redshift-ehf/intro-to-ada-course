with Ada.Text_IO;

procedure Show_Renaming is

   --  A rename is another name for something that already exists. Nothing is copied and nothing
   --  is wrapped: Show *is* Put_Line, under a shorter name.
   procedure Show (Item : String) renames Ada.Text_IO.Put_Line;

   --  Renaming reaches attributes too, which is how a long standard-library name becomes short
   --  enough to read inline.
   function Image (Value : Integer) return String renames Integer'Image;

begin
   Show ("Hello World!");
   Show ("Two plus two is" & Image (2 + 2));

   --  The original name stays visible. Renaming adds a name, it does not replace one.
   Ada.Text_IO.Put_Line ("...and Put_Line still works.");
end Show_Renaming;
