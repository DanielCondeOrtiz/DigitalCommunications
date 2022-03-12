clear all
close all

Eb = 4;
M = 2;
L  = 16;
Tb = 1/100;
p = [ones(1,L/2) -ones(1,L/2)];

[Rx,tau,maxlag] = autocorrelacion(Eb,M,p,L,Tb,1e5);

figure(1)
plot(tau,Rx,'-')
xlabel('t [s]');
ylabel('R_X(t)');
Tm = (Tb*log2(M))/L;
Tm = (Tb*log2(M))/L;
tmax=4*maxlag*Tm*log2(M)/200;

axis([-tmax tmax min(Rx)*1.1 max(Rx)*1.1]);
grid on;
title('Autocorrelación de la señal transmitida');

disp(['El máximo valor de Rx es        :',num2str(max(Rx))])
disp(['La potencia media transmitida es:',num2str(Eb/Tb), ' W'])
