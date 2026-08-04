with Ada.Command_Line;
with Ada_Check;
with Inventory;

procedure Test_Inventory is
   use Inventory;

   Assets : Float := 0.0;

   Pens    : constant Item := Init (Ballpoint_Pen,        185, 0.15);
   Markers : constant Item := Init (Oil_Based_Pen_Marker, 100, 9.0);
   Quills  : constant Item := Init (Feather_Quill_Pen,      2, 40.0);
begin
   Ada_Check.Suite ("Inventory");

   Ada_Check.Equal ("ballpoint pen",  To_String (Ballpoint_Pen),        "Ballpoint Pen");
   Ada_Check.Equal ("oil-based pen",  To_String (Oil_Based_Pen_Marker), "Oil-based Pen Marker");
   Ada_Check.Equal ("feather quill",  To_String (Feather_Quill_Pen),    "Feather Quill Pen");

   --  Init puts each argument in the right component, which is worth checking one at a time:
   --  three components of a record are easy to build in the wrong order.
   Ada_Check.Equal ("Init keeps the name",     Item_Name'Image (Pens.Name), "BALLPOINT_PEN");
   Ada_Check.Equal ("Init keeps the quantity", Pens.Quantity, 185);
   Ada_Check.Equal ("Init keeps the price",    Pens.Price,    0.15);

   Add (Assets, Pens);
   Ada_Check.Equal ("185 pens at 0.15", Assets, 27.75);

   Add (Assets, Markers);
   Ada_Check.Equal ("and 100 markers at 9.00", Assets, 927.75);

   Add (Assets, Quills);
   Ada_Check.Equal ("and 2 quills at 40.00", Assets, 1007.75, Tolerance => 0.01);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Inventory;
