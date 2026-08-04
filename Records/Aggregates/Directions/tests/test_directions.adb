with Ada.Command_Line;
with Ada_Check;
with Directions;

procedure Test_Directions is
   use Directions;

   --  Display takes an Ext_Angle, which is not one of the shapes Ada_Check has a ready-made
   --  Output_Of for. This is the general form the harness documents: a nested procedure that
   --  supplies the argument, passed by 'Access.
   function Displayed (N : Angle_Mod) return String is
      E : constant Ext_Angle := To_Ext_Angle (N);

      procedure Call is
      begin
         Display (E);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Displayed;
begin
   Ada_Check.Suite ("Directions");

   Ada_Check.Equal ("0 is north",         Direction'Image (To_Direction (0)),   "NORTH");
   Ada_Check.Equal ("30 is northeast",    Direction'Image (To_Direction (30)),  "NORTHEAST");
   Ada_Check.Equal ("45 is northeast",    Direction'Image (To_Direction (45)),  "NORTHEAST");
   Ada_Check.Equal ("90 is east",         Direction'Image (To_Direction (90)),  "EAST");
   Ada_Check.Equal ("91 is southeast",    Direction'Image (To_Direction (91)),  "SOUTHEAST");
   Ada_Check.Equal ("120 is southeast",   Direction'Image (To_Direction (120)), "SOUTHEAST");
   Ada_Check.Equal ("180 is south",       Direction'Image (To_Direction (180)), "SOUTH");
   Ada_Check.Equal ("250 is southwest",   Direction'Image (To_Direction (250)), "SOUTHWEST");
   Ada_Check.Equal ("270 is west",        Direction'Image (To_Direction (270)), "WEST");
   Ada_Check.Equal ("300 is northwest",   Direction'Image (To_Direction (300)), "NORTHWEST");

   --  The boundaries, which are where an off-by-one in the case statement would show up.
   Ada_Check.Equal ("89 is still northeast",  Direction'Image (To_Direction (89)),  "NORTHEAST");
   Ada_Check.Equal ("179 is still southeast", Direction'Image (To_Direction (179)), "SOUTHEAST");
   Ada_Check.Equal ("269 is still southwest", Direction'Image (To_Direction (269)), "SOUTHWEST");
   Ada_Check.Equal ("359 is still northwest", Direction'Image (To_Direction (359)), "NORTHWEST");

   --  The record carries both parts, and the angle comes through unchanged.
   Ada_Check.Equal ("the angle is kept",
                    Integer (To_Ext_Angle (45).Angle_Elem), 45);
   Ada_Check.Equal ("the direction is worked out",
                    Direction'Image (To_Ext_Angle (45).Direction_Elem), "NORTHEAST");

   Ada_Check.Equal ("Display at 0",   Displayed (0),   "Angle:  0 => NORTH.");
   Ada_Check.Equal ("Display at 45",  Displayed (45),  "Angle:  45 => NORTHEAST.");
   Ada_Check.Equal ("Display at 270", Displayed (270), "Angle:  270 => WEST.");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Directions;
