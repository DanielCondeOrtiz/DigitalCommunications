function g = de2gray(d, n )

% Convierte un número decimal en un vector binario de longitud n
% Versión adaptada de una función descargada de Mathworks

% comprobaciones
mensaje='Sólo sirve para números enteros positivos';
d = d(:);
len_d = length(d);
if min(d) < 0
    error(mensaje);
elseif ~isempty(find(d==inf,1))
  error('This functions can not take Inf as the input.');
elseif find(d ~= floor(d))
  warning(mensaje);  
end;

% assign the length
if nargin < 2;
    tmp = max(d);
    b1 = [];
    while tmp > 0
        b1 = [b1 rem(tmp, 2)];
        tmp = floor(tmp/2);
    end;
    n = length(b1);
end;

% initial value
b = zeros(len_d, n);

% parameter assignment
for i = 1 : len_d
    j = 1; 
    tmp = d(i);
    while (j <= n) && (tmp > 0)
        b(i, j) = rem(tmp, 2);
        tmp = floor(tmp/2);
        j = j + 1;
    end;
end;

% los bits en el orden que utilizamos (FJPS)
b=fliplr(b);

g(:,1) = b(:,1);    
for i = 2:size(b,2),
    g(:,i) = xor( b(:,i-1), b(:,i) ); 
end

%---end of de2gray---

