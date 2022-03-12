function d = gray2de(g)

% Convierte una secuencia de digitos binarios en decimal con codificacion
% de Gray. Versión adaptada de una función descargada de Mathworks

% Lo convertimos a binario
b(:,1) = g(:,1);

for i = 2:size(g,2),
    b(:,i) = xor( b(:,i-1), g(:,i) );
end

% Convierte los bits menos signigficativos en los más significativos
b=fliplr(b);

% check the special cases.
[n,m] = size(b);
if min([n,m]) < 1
    d = [];
    return;
elseif min([n,m]) == 1
    b = b(:)';
    m = max(n,m);
end;

d = (b * 2.^[0 : m-1]')';

%---fin de gray2de---
end