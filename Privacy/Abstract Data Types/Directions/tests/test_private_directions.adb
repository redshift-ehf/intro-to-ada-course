with Ada.Command_Line;
with Ada_Check;
with Private_Directions;

procedure Test_Private_Directions is
   use Private_Directions;

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
   Ada_Check.Suite ("Directions, private");

   Ada_Check.Equal ("0 is north",       Direction'Image (To_Direction (0)),   "NORTH");
   Ada_Check.Equal ("45 is northeast",  Direction'Image (To_Direction (45)),  "NORTHEAST");
   Ada_Check.Equal ("90 is east",       Direction'Image (To_Direction (90)),  "EAST");
   Ada_Check.Equal ("180 is south",     Direction'Image (To_Direction (180)), "SOUTH");
   Ada_Check.Equal ("270 is west",      Direction'Image (To_Direction (270)), "WEST");
   Ada_Check.Equal ("300 is northwest", Direction'Image (To_Direction (300)), "NORTHWEST");

   --  The record is private, so this is how its halves are read now. In the Records chapter the
   --  test wrote To_Ext_Angle (45).Angle_Elem; here that does not compile.
   Ada_Check.Equal ("the angle is kept",
                    Integer (Angle_Of (To_Ext_Angle (45))), 45);
   Ada_Check.Equal ("the direction is worked out",
                    Direction'Image (Direction_Of (To_Ext_Angle (45))), "NORTHEAST");

   --  And the two halves can never disagree, because nobody outside can set them separately.
   for Angle in Angle_Mod range 0 .. 359 loop
      if Direction_Of (To_Ext_Angle (Angle)) /= To_Direction (Angle) then
         Ada_Check.Check ("every angle agrees with its own direction", False,
                          "disagreed at" & Angle_Mod'Image (Angle));
         exit;
      end if;
   end loop;
   Ada_Check.Check ("every angle agrees with its own direction", True);

   Ada_Check.Equal ("Display at 0",   Displayed (0),   "Angle:  0 => NORTH.");
   Ada_Check.Equal ("Display at 45",  Displayed (45),  "Angle:  45 => NORTHEAST.");
   Ada_Check.Equal ("Display at 270", Displayed (270), "Angle:  270 => WEST.");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Private_Directions;
