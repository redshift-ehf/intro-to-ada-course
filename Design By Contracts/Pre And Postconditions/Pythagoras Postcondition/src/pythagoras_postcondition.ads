--  The same theorem as a *postcondition*: a promise about what Init returns.
package Pythagoras_Postcondition is

   subtype Length is Natural;

   type Right_Triangle is record
      H      : Length := 0;
      C1, C2 : Length := 0;
   end record;

   --  `Init'Result` is the value being returned. The obligation is on the implementer -- which
   --  is a strange fit here, since Init cannot do anything but pass its arguments through.
   function Init (H, C1, C2 : Length) return Right_Triangle is ((H, C1, C2))
     with Post => Init'Result.H * Init'Result.H
                    = Init'Result.C1 * Init'Result.C1
                    + Init'Result.C2 * Init'Result.C2;

end Pythagoras_Postcondition;
