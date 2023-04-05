program ejercicio6;
const
    valoralto = 9999
    df = 10
type
    dfv = 1..df;

    data = record
        code: integer;
        nom:string;
        cepa:integer;
        n_cepa:string;
        activos:integer;
        nuevos:integer;
        recuperados:integer;
        fallecidos:integer;
    end;

    muni = record
        code:integer;
        cepa:integer;
        activos:integer;
        nuevos:integer;
        recuperados:integer;
        fallecidos:integer;
    end;

    maestro = file of data;
    detalle = file of muni;

    vec = array [dfv] of detalle
    reg = array [dfv] of muni;

procedure leer(var d:detalle;var de:muni);
begin
    if (not eof(d)) then 
        read(d,de);
    else
        de.code := valoralto;
end;

procedure minimo(var v:reg; var min:muni; var d:detalle);
var
    i,actual:integer;
    ma:maestro;
begin
    min.code := valoralto;
    min.cepa := valoralto;
    for i:=0 to df do begin
        if ((v[i].code < min.code) and (v[i].cepa < min.cepa))then begin
            actual := i;
            min := v[i];
        end;
        if ((min.code <> valoralto) and (min.cepa <> valoralto)) then leer(v[actual],v[actual]);
    end;
end;


var
    v: vec;
    vr: reg;
    mae: maestro;
    i,cod,act,nue,rec,fall: integer;
    min,mun: muni;
    d:detalle;
begin
    for i:= 0 to df do begin
        assign(v[i],'det' + i);
        reset(v[i]);
    end;
    assign(mae,'maestro');
    rewrite(mae);

    for i:= 0 to df do begin
        leer(v[i],vr[i]);
    end;

    minimo(vr,muni,d);
    while (min.codigo <> valoralto) do begin
        cod := min.codigo;
        act:= 0;
        nue := 0;
        rec := 0;
        fall := 0;
        while (cod = min.codigo) do begin
            act := act + min.activos;
            nue := nue + min.nuevos;
            rec := min.recuperados;
            fall := min.fallecidos;
            mun.code := min.codigo;
            mun.cepa := min.cepa;
            minimo(vr,min,d);
        end;
        mun.activos :=act;
        mun.nuevos := nue;
        mun.recuperados := rec;
        mun.fallecidos := fall;
        writeln(mae,mun);
    end;

    for i:=0 to df do begin
        close(v[i]);
    end;
    close(mae);
end. 