function f = LCDnormal(X,m,V)

f=  1/sqrt(2*pi*V)* exp(-(X-m).^2/(2*V));

