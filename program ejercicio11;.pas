program ejercicio11;
const 
    valoralto = 'zzzz';
type
    datos = record
        provincia:string;
        cant:integer;
        total:integer;
    end;

    actualizacion = record
        provincia:string;
        localidad:integer;
        cant:integer;
        total:integer;
    end;

    maestro = file of datos;
    detalle = file of actualizacion;

procedure leer(var d:detalle;var a:actualizacion);
begin
    if(not eof(d)) then begin
        read(d,a);
    else
        a.provincia := valoralto;
end;

procedure actualizar(var m:maestro;var d:detalle);
var 
    prov_act,aux:string;
    total,alfa: integer;
    a:actualizacion;
    d:datos;
begin
    leer(d,a);
    alfa:= 0;
    total:= 0;
    while (a.provincia <> valoralto) do begin
        prov_act := a.provincia;
        total := 0;
        alfa := 0;
        while (prov_act = a.provincia) do begin
            total := total + a.total;
            alfa := alfa + a.cant;
            leer(d,a);
        end;
        if (not eof(m)) then  //supongo q por estar todo ordenado no tengo que estar recorriendo de manera mejorada a el archivo,me despreocupo de eso
            read(m,a);
        a.total := a.total + total;
        a.cant := a.cant + alfa;
    end;
end;           

var
    a:maestro;
    d:detalle;
    d2:detalle;
begin
    assign(a,'maestro');
    assign(d,'detalle1');
    assign(d2,'detalle2');

    reset(a);
    reset(d);
    reset(d2);

    //llama al procedimiento que hace el corte de control;
    actualizar(a,d);
    actualizar(a,d2);

    close(a);
    close(d);
    close(d2);
end.