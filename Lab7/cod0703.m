clear all
close all

Eb = 4;
M  = 2;
L  = 8;
Tb = 1/100;
p  = [ones(1,L/2) -ones(1,L/2)];

[Rx,tau,maxlag] = autocorrelacion(Eb,M,p,L,Tb,1e5);
Tm = (Tb*log2(M))/L;
Fm=1/Tm;

% La transformada discreta de Fourier de Rx nos deber?a dar el espectro densidad de potencia. El intervalo de representaci?n es [-Fm/2,Fm/2], medido en hertzios.
S=Tm*abs(fftshift(fft(Rx, 16*maxlag)));

% Eje de frecuencias
ff = linspace(-Fm/2,Fm/2,length(S));

% El espectro densidad de potencia ideal
Sx_ideal= Eb*(sin(pi*ff*Tb/2).^2).*(sinc(ff*Tb/2).^2); 
    Sx_idealdbm=10*log10(10^3*Sx_ideal);
    subplot(211); h=plot(ff,Sx_idealdbm);
    set(h,'linewidth', 1.0);
    xlabel('f [Hz]','FontSize',12,'FontName','Times');
    ylabel('S_X(f)[dBm]','FontSize',12,'FontName','Times');
    axis([-Fm/2 Fm/2 -max(Sx_idealdbm) max(Sx_idealdbm)+10]);
    grid on
    title('Espectro densidad de potencia ideal','FontWeight','bold',...
        'FontName','Times');
        
% El espectro densidad de potencia real    
Sdbm=10*log10(10^3*S);
    subplot(212); h=plot(ff,Sdbm,'r');
    set(h,'linewidth', 'default');
    xlabel('f [Hz]','FontSize',12,'FontName','Times');
    ylabel('S_X(f)[dBm]','FontSize',12,'FontName','Times');
    axis([-Fm/2 Fm/2 -max(Sdbm) max(Sdbm)+10]);
    grid on;
    title('Espectro densidad de potencia simulado','FontWeight','bold',...
    'FontName','Times');
