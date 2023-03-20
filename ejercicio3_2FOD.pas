program ejercicio3;
type
	empleados = record
		num:integer;
		apellido:string;
		nombre:string;
		edad:integer;
		dni:integer;
	end;
	
	archivo = file of empleados;
	
procedure leer_registro(var p:empleados);
begin
	writeln('ingrese numero de empleado: ');
	readln(p.num);
	writeln('ingrese apellido y nombre: ');
	readln(p.apellido);
	readln(p.nombre);
	writeln('ingrese edad: ');
	readln(p.edad);
	writeln('ingrese dni: ');
	readln(p.dni);
end;

var
	ar_log: archivo;
	p: empleados;
	nombre: string;
begin
	writeln('ingrese nombre de archivo: ');
	readln(nombre);
	assign(ar_log, nombre);
	rewrite(ar_log);
	leer_registro(p);
	while (p.apellido <> 'fin') do begin
		write(ar_log,p);
		leer_registro(p);
	end;
	close(ar_log);
end.


