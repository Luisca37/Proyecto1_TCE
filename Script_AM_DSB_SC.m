%syms t2;

N=1024;
Fs=2*2500;
Ts=1/Fs;
t=(0: N-1)*Ts;

%Señal Moduladora 1 
M1=0.5;
F_mod1=10;
A_mod1=5;
S_mod1=A_mod1*cos(2*pi*F_mod1*t);
figure(1)
subplot(2,1,1); 
plot(t, S_mod1)
title("Señal Moduladora 1");

%Señal Portadora 1
%A_port=A_mod/M;
A_port1=1;
F_port1=500;
S_port1=A_port1*cos(2*pi*F_port1*t);
figure(1)
subplot(2,1,2); 
plot(t, S_port1)
title("Señal Portadora 1");

%Modulación AM 1 
AM1=ammod(S_mod1, F_port1, Fs, 0, A_port1);
figure(2)
plot(t, AM1)
title("Señal Modulada 1")

%Espectro
Y=fft(AM1);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(7)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

%Primera señal modulada AM en el tiempo y espectro. 

%Señal Moduladora 2 
M2=0.5;
F_mod2=100;
A_mod2=10;
S_mod2=A_mod2*cos(2*pi*F_mod2*t);
figure(3)
subplot(2,1,1); 
plot(t, S_mod2)
title("Señal Moduladora 2");

%Señal Portadora 2
%A_port=A_mod/M;
A_port2=1;
F_port2=2000;
S_port2=A_port2*cos(2*pi*F_port2*t);
figure(3)
subplot(2,1,2); 
plot(t, S_port2)
title("Señal Portadora 2");

%Modulación AM 2 
AM2=ammod(S_mod2, F_port2, Fs, 0, A_port2);
figure(4)
plot(t, AM2)
title("Señal Modulada 2")

%MULTIPLEXACIÓN DE SEÑALES
Suma=AM1+AM2+5*cos(2*pi*200*t);
figure(5)
plot(t,Suma)
title("Señal Sumada AM")



%Espectro
Y=fft(AM1);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(6)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")


%Espectro
Y=fft(Suma);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(7)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of Suma(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")



%--------------Modulacion FM----------------------

m = Suma; %mensaje a modular

fDev = 10;
 
fc_fm = 2500;
Fs_fm=2*fc_fm;
Ts_fm=1/Fs_fm;
mi=2;
t2 = (0: N-1)*Ts_fm;
 
s_fm = fmmod(m,fc_fm,Fs_fm,fDev);
figure(8)
plot(t, s_fm)
%xlabel('Time (s)')
%ylabel('Amplitude')
legend('Modulated Signal')


fm_demod = fmdemod(s_fm,fc_fm,Fs_fm,fDev);

%Espectro SeÃ±al demodulada FM
Y=fft(s_fm);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs_fm*(0:(N/2))/N;
figure(10)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of señal FM modulada")
xlabel("f (Hz)")
ylabel("|P1(f)|")
 
 
 
 
%Espectro SeÃ±al demodulada FM
Y=fft(fm_demod);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs_fm*(0:(N/2))/N;
figure(11)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of señal FM demodulada")
xlabel("f (Hz)")
ylabel("|P1(f)|")
 
% figure(11)
% plot(t,m,'c',t,fm_demod,'b--')
% xlabel('Time (s)')
% ylabel('Amplitude')
% legend('Moduladora','Demodulacion FM')


