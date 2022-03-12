function d = gray2de(g)
%
% Convierte cada fila de la matriz formada por d�gitos binarios g en un vector columna de los valores decimales correspondientes. 
% Versi�n adaptada de una funci�n de Mathworks

b(:,1) = g(:,1);
    
for i = 2:size(g,2),
    b(:,i) = xor( b(:,i-1), g(:,i) ); 
end
    
% Convierte los bits menos significativos en los m�s significativos
b=fliplr(b);

%Comprueba un caso especial.
[n,m] = size(b);
if min([m,n]) < 1
    d = [];
    return;
elseif min([n,m]) == 1
    b = b(:)';
    m = max([n,m]);
    n = 1;
end;

d = (b * 2.^[0 : m-1]')';
