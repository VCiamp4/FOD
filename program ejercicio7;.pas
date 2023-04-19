program ejercicio7;
{Se cuenta con un archivo que almacena información sobre especies de aves en
vía de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice
un programa que elimine especies de aves, para ello se recibe por teclado las especies a
eliminar. Deberá realizar todas las declaraciones necesarias, implementar todos los
procedimientos que requiera y una alternativa para borrar los registros. Para ello deberá
implementar dos procedimientos, uno que marque los registros a borrar y posteriormente
otro procedimiento que compacte el archivo, quitando los registros marcados. Para
quitar los registros se deberá copiar el último registro del archivo en la posición del registro
a borrar y luego eliminar del archivo el último registro de forma tal de evitar registros
duplicados.
Nota: Las bajas deben finalizar al recibir el código 500000}
const valoralto = 9999;
type
    ave = record
        code: integer;
        especie: string;
        familia:string;
        desc:string;
        zona:string;
    end;

    archivo = file of ave;

    lista = ^nodo;

    nodo = record
        dato: integer;
        sig: lista;
    end;

procedure cargar_archivo(var a:archivo);
var
    v:ave;
begin
    v.code := 0;
    while (v.code > -1) do begin
        writeln('--Ingrese codigo: ');read(v.code);
        writeln('--Especie: ');read(v.especie);
        writeln('--Familia: ');read(v.familia);
        writeln('--Descripcion: ');read(v.desc);
        writeln('--zona: ');read(v.zona);
        write(a,v);
    end;
    writeln('Archivo creado!');
end;


procedure leer(var a:archivo;var v:ave);
begin
    if (not eof(a)) then
        read(a,v)
    else
        v.code:= valoralto;
end;

procedure lista_codigos(var l:lista;c:integer);
var
    aux: lista;
begin
    new(aux);
    aux^.dato := c;
    aux^.sig := l;
    l:=aux;
end;

procedure marcar (var a:archivo;l:lista);
var
    aux:lista;
    v:ave;
begin
	aux := l;
    while (aux^.sig <> nil) do begin
        //vuelvo al principio del archivo
        leer(a,v);
        while (v.code <> valoralto) do begin
            if (v.code = aux^.dato) then begin
                v.code := -v.code;
                seek(a,filepos(a)-1);
                write(a,v);
            end;
            leer(a,v);
        seek(a,0);
        l := l^.sig;
		end;
		writeln('Elementos marcados con exito!');
	end;
end;

procedure borrar(var a:archivo);
var
    v:ave;
    pos:integer;
    aux:ave;
begin
    while (not eof(a)) do begin
        leer(a,v);
        if (v.code < 0) then begin
            if (eof(a)) then begin
                seek(a,filepos(a)-1);
                truncate(a);
            end
            else begin
                pos := filepos(a)-1;
                seek(a,filesize(a)-1);
                read(a,aux);
                seek(a,filepos(a)-1);
                truncate(a);
                seek(a,pos);
                write(a,aux);
                seek(a,filepos(a)-1);
            end;
        end;
    end;
    writeln('elementos borrados con exito!');
end;

procedure listar (var a:archivo);
var
    aux:ave;
    texto:text;
begin
    assign(texto,'aves.txt');
    rewrite(texto);
    leer(a,aux);
    while (aux.code <> valoralto) do begin
        write(texto,aux.code,'',aux.especie);
        write(texto,aux.familia);
        write(texto,aux.desc);
        leer(a,aux);
    end;
    close(texto);
end;

var
    a:archivo;
    l:lista;
    st:integer;
begin
    assign(a,'archivo_de_aves');
    rewrite(a);

    cargar_archivo(a);
    
    writeln('----Ingrese especies de aves a borrar----');
    read(st);
    while (st <> 5000) do begin
        lista_codigos(l,st);
        write('Ingrese codigo de especie a borrar: ');
        read(st);
    end;


    marcar(a,l);
    borrar(a);
    listar(a);

    close(a);
end.
