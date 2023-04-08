program ejercicio12;
const
    valoralto = 9999;
type
    acceso = record
        anio:integer;
        mes:integer;
        dia:integer;
        idUsuario:integer;
        tiempo:real;
    end

    archivo = file of acceso;

procedure leer(var a:archivo;var d:acceso);
begin
    if (not eof(a)) then
        read(a,d);
    else
        d.anio := valoralto;
end;

procedure imprimir(var a:archivo;an:integer);
var
    mes_act,dia_act,id,tid:integer;
    total_mes,total_anio,total_dia:real;
    d:acceso;
begin
    leer(a,d);
    total_anio:= 0;
    while(d.anio <> an) do begin //buscar el anio ingresado y comenzar a imprimir
        leer(a,d);
    end;
    while (d.anio = an) and (d.anio <> valoralto) do begin
        writeln('Anio: ',an);
        total_mes:= 0;
        mes_act := d.mes;
        writeln('Mes: ',d.mes);
        while (d.mes = mes_act) do begin //el archivo tiene ingresado el tiempo total del usuario en un solo dia?
            dia_act := d.dia;
            total_dia := 0;
            while(d.dia = dia_act) do begin
                id := d.idUsuario;
                tid := 0
                while(d.idUsuario = id) do begin
                    tid := tid + d.tiempo;
                    leer(a,d);
                end;
                total_dia := total_dia + tid;
                writeln(id,' tiempo de acceso: ',tid,' dia ',dia_act,' mes ',mes_act);
            end;
            writeln('tiempo total de accesos en el dia ',dia_act,' ',total_dia);
            total_mes := total_mes + total_dia;
        end;
        writeln('total del mes ',total_mes);
        total_anio := total_anio + total_mes;
    end;
    writeln('total en el anio: ', total_anio);
end;

var
    a:archivo;
    an:integer;
begin
    assign(a,'archivo_principal');
    reset(a);
    writeln('<--Ingrese anio a buscar-->');
    readln(an);
    imprimir(a,an);
    close(a);
end;