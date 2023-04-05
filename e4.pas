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

    vec = array [1..5] of detalle;
    vlog = array[1..5] of log;

procedure leer(var a:detalle; var d:log);
begin
    if (not eof(a)) then begin
        read(a,d);
    end
    else 
        d.cod_usuario := valoralto;
end;

procedure armar(var v:vec);
var
    i:integer;
begin
    for i:=0 to 5 do begin
        assign(v[i], 'det' + i);
        reset(v[i]);
    end;
end;

procedure minimo(var v:vec;var min: log;var vl:vlog);
var
    min_cod,actual,i: integer;
begin
    min_cod := valoralto;
    for i:= 1 to 5 do begin
        if (vl[i].cod_usuario < min_cod) then begin
            actual := i;
            min := vl[i];
        end;
        if (min.cod_usuario <> valoralto) then leer(v[actual],vl[actual]);
    end;

end;

    

var
    v:vec;
    vl:vlog;
    mae:maestro;
    min:log;
    i,code,total:integer;
begin
    armar(v); //asigno y abro lo archivo detalle 
    rewrite(mae);
    for i:=0 to 5 do begin
      leer(v[i],vl[i]);
    end;
    minimo(v,min,vl); //el merge
    while (min.cod_usuario <> valoralto) do begin
        code := min.code_usuario;
        total := 0
        while (code = min.code_usuario) do begin //recordar agregar fecha como variable para despues agregarlo al maestro
            total := total + min.tiempo_sesion;
            minimo(v,min,vl);
        end;
        write(mae,min);
    end;

    for i:=0 to 5 do begin
        close(v[i]);
    end;
    close(mae);
end.
