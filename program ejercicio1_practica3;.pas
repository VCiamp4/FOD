program ejercicio1_practica3;
const
    valor_alto = 9999;
type 
		empleados = record
		num:integer;
		apellido:string;
		nombre:string;
		edad:integer;
		dni:integer;
	end;
	
	archivo = file of empleados;

procedure leer(var a:archivo;var e:empleados);
begin
    if (not eof(a)) then
        read(a,e);
    else
        e.num := valor_alto;
end;

procedure anadir_empleado(var a:archivo;e:empleados;var cant:integer);
begin
	seek(a,cant);
	write(a,e);
	cant := cant + 1;
	close(a);
end;

procedure eliminar_empleado(var a:archivo; n:integer);
var 
    e:empleados;
begin
    leer(a,e);
    while (e.num <> n) do 
        leer(a,e);
    leer(a,e);
    while(e.num <> valor_alto) do begin
        seek(a,filepos(a)-2);
        write(a,e);
        seek(a,filepos(a)+1);
        leer(a,e);
    end;

    //se tiene que agregar el truncate(a) al final del ejercicio, no aca.
end;


procedure aumentar_edad (var a:archivo;cant:integer);
var
	e:empleados;
	pos: integer;
begin
	random(pos); //buscar como se usaba el random;
	pos := Random(cant); //??
	seek(a,pos);
	read(a,e);
	e.edad := e.edad + 1;
end;