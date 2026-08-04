--  A String on the heap, whose length is decided while the program runs.
--
--  An original exercise. AdaCore's Laboratories has no Access Types chapter -- see the note in
--  this task's description.
package Text_Buffer is

   type Text is access String;

   --  A buffer of Size characters, all spaces.
   function Make (Size : Positive) return Text;

   --  A buffer holding exactly this content.
   function Make (Content : String) return Text;

   --  Zero for a null buffer, rather than raising.
   function Length (T : Text) return Natural;

   --  Overwrites every character. Does nothing to a null buffer.
   procedure Fill (T : Text; C : Character);

   --  The empty string for a null buffer.
   function Value (T : Text) return String;

end Text_Buffer;
