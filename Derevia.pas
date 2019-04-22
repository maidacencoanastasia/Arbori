program Derevia;

type
  Tree = ^Nod;
  Nod = Record
    Left: Tree;
    Right: Tree;
    Inf: Record
      znac: 1..999;
    end;
  end;

procedure Creare(var Ab: Tree);
var
  N: string;
begin
  Writeln('Doriti sa adaugati inca un element???');
  Readln(N);
  if N = '0' then
    Ab := nil
    else
  begin
    new(Ab);
    writeln('Introduceti valoarea');
    readln(Ab^.Inf.znac);
    writeln(' <--- left');
    Creare(Ab^.Left);
    writeln('right --->');
    Creare(Ab^.Right);
  end;
end;

procedure Pokaz(Ab: Tree);
begin
  if Ab <> nil then
  begin
    Writeln(Ab^.Inf.znac);
    Pokaz(Ab^.Left);
    Pokaz(Ab^.Right);
  end;
end;

procedure Sum_el_div3(Ab: Tree; var sumd3: integer; var kpar: integer);
begin
  if Ab <> nil then
  begin
    if((Ab^.Inf.znac mod 3) = 0) then 
      sumd3 := sumd3 + Ab^.Inf.znac;  
    if ((Ab^.Inf.znac mod 2) = 0) then kpar := kpar + 1;
    Sum_el_div3(Ab^.Left, sumd3, kpar);
    Sum_el_div3(Ab^.Right, sumd3, kpar);
    
  end;
  
end;

procedure NodTerminal(Ab: Tree; var knt: integer; var sum_np: integer);
begin
  if Ab <> nil then
  begin
    if ((Ab^.Left = nil) and (Ab^.Right = nil)) then begin
      knt := knt + 1;
      if ((Ab^.inf.znac mod 2) = 0) then
      begin
        sum_np := sum_np + Ab^.inf.znac;
      end;
      
    end;
    NodTerminal(Ab^.Left, knt, sum_np);
    NodTerminal(Ab^.Right, knt, sum_np);  
    
  end;
end;

function TreeDepth(Ab: Tree): integer;
var
  LMax: integer;
  procedure NodeLevel(P: Tree; L: integer);
  begin
    if P = nil then exit;
    if L > LMax then
      LMax := L;
    NodeLevel(P^.Left, L + 1);
    NodeLevel(P^.Right, L + 1);
  end;

begin
  LMax := 0;
  NodeLevel(Ab, 0);
  Result := LMax;
end;

var
  Head: Tree;
  sumd3, kpar, knt, sum_np: integer;

begin
  sumd3 := 0;
  kpar := 0;
  knt := 0;
  sum_np := 0;
  Creare(Head);
  Pokaz(Head);
  writeln('Glubina dereva ', TreeDepth(Head));
  Sum_el_div3(Head, sumd3, kpar);
  writeln('suma elementelor care div 3= 0 este ', sumd3);
  if kpar > 0 then writeln('In arbore sunt elemente/valori/noduri pare');
  NodTerminal(Head, knt, sum_np);
  writeln('Kol-vo nodurilor terminale este: ', knt);
  writeln('Suma nodurilor terminale cu valorile pare este: ', sum_np);
  
end.