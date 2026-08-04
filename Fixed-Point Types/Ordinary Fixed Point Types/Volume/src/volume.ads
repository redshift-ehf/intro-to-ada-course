--  A gain between silence and unity, in steps of 1/256.
--
--  An original exercise; AdaCore's Laboratories has no Fixed-Point Types chapter.
package Volume is

   --  An ordinary fixed-point type: the delta is a power of two, which a decimal fixed-point
   --  type is not allowed to have.
   --
   --  The range runs to 2.0 rather than 1.0, and that is not arbitrary. `range 0.0 .. 1.0` at
   --  this delta fits in eight bits as 0 .. 255 steps, and 1.0 is the 256th -- one too many. The
   --  declared bound is then adjusted *down* by one delta (RM 3.5.9(13)) and unity gain, the one
   --  value this package most needs, stops being a value of the type. Asking for 2.0 takes
   --  sixteen bits, where 1.0 sits comfortably inside.
   type Gain is delta 2.0 ** (-8) range 0.0 .. 2.0;

   --  Two gains applied one after the other.
   function Scale (A, B : Gain) return Gain;

   --  Halfway between them.
   function Mix (A, B : Gain) return Gain;

   --  Halved, Steps times over.
   function Fade (G : Gain; Steps : Natural) return Gain;

   function Is_Silent (G : Gain) return Boolean;

end Volume;
