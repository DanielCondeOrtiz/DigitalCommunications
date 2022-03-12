clear all
close all

Eb = 4;
M  = [2,4,8,16,32];
L  = 16;
Tb = 1/100;
p  = [ones(1,L)];

for i=1:5
figure
[Rx,tau,maxlag] = autocorrelacion(Eb,M(i),p,L,Tb,1e5);
subplot(3,1,1);
plot(tau,Rx)
    title('Autocorrelacion','FontWeight','bold',...
        'FontName','Times');
Tm = (Tb*log2(M(i)))/L;
Fm=1/Tm;

% La transformada discreta de Fourier de Rx nos deber?a dar el espectro densidad de potencia. El intervalo de representaci?n es [-Fm/2,Fm/2], medido en hertzios.
S=Tm*abs(fftshift(fft(Rx, 16*maxlag)));

% Eje de frecuencias
ff = linspace(-Fm/2,Fm/2,length(S));

  Es = Eb * log2(M(i));
  Ts = Tb * log2(M(i));

% El espectro densidad de potencia ideal
Sx_ideal= Es*(sinc(ff*Ts).^2); 
    Sx_idealdbm=10*log10(10^3*Sx_ideal);
    subplot(312); h=plot(ff,Sx_idealdbm);
    set(h,'linewidth', 1.0);
    xlabel('f [Hz]','FontSize',12,'FontName','Times');
    ylabel('S_X(f)[dBm]','FontSize',12,'FontName','Times');
    axis([-Fm/2 Fm/2 -max(Sx_idealdbm) max(Sx_idealdbm)+10]);
    grid on
    title('Espectro densidad de potencia ideal','FontWeight','bold',...
        'FontName','Times');
        MM=M(i)
        Anchobandateor=ff(length(Sx_idealdbm)/2 + find(diff(Sx_idealdbm([length(Sx_idealdbm)/2:end])>=0),1))
        
        EfEsp=(1/Tb)/Anchobandateor
% El espectro densidad de potencia real    
Sdbm=10*log10(10^3*S);
    subplot(313); h=plot(ff,Sdbm,'r');
    set(h,'linewidth', 'default');
    xlabel('f [Hz]','FontSize',12,'FontName','Times');
    ylabel('S_X(f)[dBm]','FontSize',12,'FontName','Times');
    axis([-Fm/2 Fm/2 -max(Sdbm) max(Sdbm)+10]);
    grid on;
    title('Espectro densidad de potencia simulado','FontWeight','bold',...
    'FontName','Times');

    Anchobandaexp=ff(length(Sdbm)/2 + find(diff(Sdbm([length(Sdbm)/2:end])>=0),1))
    
    Pot=Eb/Tb
        
    end