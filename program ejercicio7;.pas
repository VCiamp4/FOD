program ejercicio7;
const
    valoralto = 9999;
type
    producto = record
        code:integer;
        nom:string;
        precio:real;
        act:integer;
        minimo:integer;
    end;

    venta = record
        code:integer;
        cant:integer;
    end;begin
        
    end;

    detalle = file of venta;
    archivo = file of producto;

procedure leer(var d:detalle;var v:venta);
begin
    if (not eof(d)) then
        read(d,v);
    else
        v.code := valoralto;
end;
    
procedure cargar(var a:archivo;var d:detalle;var v:venta);
var
    cont:integer;
    actual:integer;
    am: producto;
begin
    leer(d,v)
    while (v.code <> valoralto) do begin
            cant := 0
            act := v.code;
            while (act = v.code) do begin
                cant := cant + v.cant;
                leer(d,v);  //creo que con tener el leer aca ya es suficiente. Chequear;
            end;  //hasta aca se hace un merge del detalle
            while ((not eof(a))and(am.code <> act)) do begin
                read(a,am);
            end;
            if (am.code = act) then begin
                am.act := am.act - cant;
                seek(a,filepos(a)-); //?? creo que no es necesario porque nunca termino de saltar a otra posicion;
                write(a,am);
            end;
    end;
end;

procedure tex();
var ma:archivo;texto:text;p:productos;
begin
  assign(ma,'maestro');
  reset(ma);
  assign(texto,'stock_minimo.txt');
  rewrite(texto);
  while (not(eof(ma))) do begin
    read(ma,p);
    if(p.stockA<p.stockM) then begin
      with p do begin
        writeln(texto,code,' ',precio:0:2,' ',nom);
        writeln(texto,act,' ',minimo);
      end;
    end;  
  end;
  close(texto);
end;

var
    m:archivo;
    d:detalle;
    v:venta;
begin
    assign(m,'maestro');
    assign(d,'detalle');

    reset(m);
    reset(d);

    cargar(a,d,v);
    tex();

    close(m);
    close(d);
end.