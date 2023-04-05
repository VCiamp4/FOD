{ Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}

program ejercicio4;
const valoralto = 9999;
type
    log = record
        cod_usuario: integer;
        fecha:integer;
        tiempo_sesion: integer;
    end;

    mae  = record
        cod_usuario: integer;
        fecha:integer;
        timepo_total: integer;
    end;

    detalle = file of log;
    maestro = file of ma;

procedure leer(var a:detalle; var d:log);
begin
    if (not eof(a)) then begin
        read(a,d);
    else 
        d.cod_usuario := valoralto;
end;



end;

var
    d1,d2,d3,d4,d5 : detalle;
    min,r1,r2,r3,r4 : log;
    ma: maestro;
    mr: mae;
    i:integer //nomas para el el for de assign
begin
    assign(d1,'detalle1');
    assign(d2,'detalle2');
    assign(d3,'detalle3');
    assign(d4,'detalle4');
    assign(d5,'detalle5');//hasta aca detalles
    assign(ma,'maestro');

    rewrite(ma);//creo el nuevo archivo maestro
    reset(d1);
    reset(d2);
    reset(d3);
    reset(d4);
    reset(d5);

    leer(d1,r1);
    leer(d1,r2);
    leer(d1,r3);
    leer(d1,r4);
    leer(d1,r5);

    //se llama al procedimiento minimo (recordar usar corte de control);

    //hacer los close
end.