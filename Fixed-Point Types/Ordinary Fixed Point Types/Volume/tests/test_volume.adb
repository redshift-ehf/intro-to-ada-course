with Ada.Command_Line;
with Ada_Check;
with Volume;

procedure Test_Volume is
   use Volume;
begin
   Ada_Check.Suite ("Volume");

   Ada_Check.Equal ("full gain leaves a signal alone", Float (Scale (1.0, 1.0)), 1.0);
   Ada_Check.Equal ("half of full",                    Float (Scale (1.0, 0.5)), 0.5);
   Ada_Check.Equal ("half of a half",                  Float (Scale (0.5, 0.5)), 0.25);
   Ada_Check.Equal ("anything times silence",          Float (Scale (1.0, 0.0)), 0.0);

   Ada_Check.Equal ("halfway between nothing and all", Float (Mix (0.0, 1.0)), 0.5);
   Ada_Check.Equal ("halfway between two equals",      Float (Mix (0.25, 0.25)), 0.25);
   Ada_Check.Equal ("mixing at full does not clip",    Float (Mix (1.0, 1.0)), 1.0);

   Ada_Check.Equal ("faded once",  Float (Fade (1.0, 1)), 0.5);
   Ada_Check.Equal ("faded twice", Float (Fade (1.0, 2)), 0.25);
   Ada_Check.Equal ("faded not at all", Float (Fade (0.75, 0)), 0.75);

   --  The delta is 1/256, so eight halvings reach the smallest value there is...
   Ada_Check.Equal ("eight halvings reach the delta",
                    Float (Fade (1.0, 8)), 0.00390625);
   Ada_Check.Check ("which is not yet silence", not Is_Silent (Fade (1.0, 8)));

   --  ...and the ninth has nowhere left to go. A fixed-point type has no exponent, so the value
   --  does not get smaller, it disappears.
   Ada_Check.Check ("the ninth halving is silence", Is_Silent (Fade (1.0, 9)));
   Ada_Check.Equal ("and it is exactly zero", Float (Fade (1.0, 9)), 0.0);

   Ada_Check.Check ("zero is silent",     Is_Silent (0.0));
   Ada_Check.Check ("and full is not",    not Is_Silent (1.0));

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Volume;
