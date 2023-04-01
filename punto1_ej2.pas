program ejercicio1_p2_fod;
type
	empleado = record
		code: integer;
		nombre:string;
		monto: real;
	end;
	
	arc_emp = file of empleado;

procedure cargar(var n:empleado;nom:string;t:real;code:integer);
begin
	n.code:=code;
	n.nombre:=nom;
	n.monto:=t;
end;

procedure compactar(var a: arc_emp;var n:arc_emp);
var
	emp: integer;
	l,nuevo:empleado;
	sumador: real;
begin
	sumador := 0;
	read(a,l);
	emp := l.code;
	sumador := sumador + l.monto;
	while (not(eof(a))) do begin
		if (l.code = emp) then begin
			sumador:= sumador + l.monto;
		end
		else begin
			cargar(nuevo,l.nombre,sumador,emp);
			write(a,nuevo);
			emp := l.code;
			sumador := 0;
		end;
		read(a,l);
	end;
end;
var
	n_logico: string;
	archivo: arc_emp;
	comp: arc_emp;
	n_comp:string;
begin
	writeln('ingrese nombre logico');
	readln(n_logico);
	writeln('ingrese el nombre del nuevo archivo: ');
	readln(n_comp);
	
	assign(archivo,n_logico);
	reset(archivo);
	assign(comp,n_comp);
	rewrite(comp);
	
	compactar(archivo,comp);
	
	close(comp);
	close(archivo);
end.

