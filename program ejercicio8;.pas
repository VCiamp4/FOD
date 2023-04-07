program ejercicio8;
const 
    valoralto = 9999;
type
    cliente = record
        code:integer;
        nombre:string;
        apellido:string;
    end;

    registro = record
        cli:cliente;
        ano:integer;
        mes:integer;
        dia:integer;
        monto:real;
    end;

    archivo = file of maestro;

procedure leer(var a:archivo;var r:registro);
begin
    if (not eof(a)) then
        read(a,r);
    else
        r.cli.code := valoralto;
end;

procedure leer_y_imprimir(var a:archivo;var r:registro);
var 
    total,total_mes,total_dia,cli_actual: integer;
    anio_actual,mes_actual:real;
begin
    leer(a,r);
    total := 0;
    while(r.cli.code <> valoralto) do begin //lee indiscriminadamente los clientes, ojo
        cli_actual := r.cli.code;
        while(r.cli.code = cli_actual) do begin
            anio_actual := r.ano;
            total_ano := 0
            while (r.cli.code <> valoralto)and(anio_actual = r.ano)and(r.cli.code = cli_actual) do begin
                mes_actual := r.mes;
                total_mes := 0;
                while(r.cli.code <> valoralto) and (mes_actual = r.mes) and (r.cli.code = cli_actual) do begin
                    total_mes := total_mes + r.monto;
                    leer(a,r);
                end;
                total_anio := total_anio + total_mes;
                writeln('El cliente: ',r.cli.code,'gasto en el mes ',mes_actual,'un total de ',total_mes);
            end;
            writeln('el cliente en todo el anio ',anio_actual,' gasto un total de ',total_anio);
            total := total + total_anio;
        end;
    end;
    writeln('la ganancia total fue de: ',total);
end;

var
    a:archivo;
    r:maestro;
begin
    assign(a,'maestro');
    reset(a);
    leer_y_imprimir(a,r);
    close(a);
end.