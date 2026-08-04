package body List_Of_Unique_Integers is

   function Get_Unique (A : Int_Array) return Int_Set is
      S : Int_Set;
   begin
      --  Include rather than Insert: the input is expected to repeat itself, and that is not an
      --  error here.
      for E of A loop
         S.Include (E);
      end loop;
      return S;
   end Get_Unique;

   function Get_Unique (A : Int_Array) return Int_Array is
      --  The other Get_Unique, chosen by the declared type of S.
      S      : constant Int_Set := Get_Unique (A);
      Result : Int_Array (1 .. Natural (S.Length));
      I      : Positive := 1;
   begin
      for E of S loop
         Result (I) := E;
         I := I + 1;
      end loop;
      return Result;
   end Get_Unique;

end List_Of_Unique_Integers;
