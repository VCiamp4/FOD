program ejercicio2;
type
	archivo = file of integer;
var
	ar:archivo;
	promedio: integer;
	cant:integer;
	num:integer;
	menor:integer;
begin
	assign(ar, 'C:\Users\ruloc\Desktop\FOD\archivo_1');
	reset(ar);
	promedio := 0;
	cant := 0;
	menor := 0;
	read(ar,num);
	while (num <> 3000) do begin
		cant := cant + 1;
		if (num > 1500) then
			menor := menor + 1;
		promedio := promedio + num;
		read(ar,num);
	end;
	promedio := promedio div cant;
	writeln('cant de numeros mayores a 1500: ', menor);
	writeln('promedio: ', promedio);
end.
