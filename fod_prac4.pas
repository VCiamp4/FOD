program ejercicio4FOD;
type 
		empleados = record
		num:integer;
		apellido:string;
		nombre:string;
		edad:integer;
		dni:integer;
	end;
	
	archivo = file of empleados;

procedure anadir_empleado(var a:archivo;e:empleados;var cant:integer);
begin
	seek(a,cant);
	write(a,e);
	cant := cant + 1;
	close(a);
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

	
