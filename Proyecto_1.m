N=1000;

% Parámetros de la señal de mensaje
fs = 1000;               % Frecuencia de muestreo
t = 0:1/fs:1;            % Vector de tiempo
fm1 = 5;                   % Frecuencia de la señal de mensaje (Hz)
Am1 = 1;                   % Amplitud de la señal de mensaje

% Crear la señal de mensaje
message_signal1 = Am1 * sin(2 * pi * fm1 * t);

% Parámetros de la portadora
fc1 = 200;                 % Frecuencia de la portadora (Hz)
Ac1 = 1;                   % Amplitud de la portadora

% Crear la portadora sin modular
carrier_signal1 = Ac1 * sin(2 * pi * fc1 * t);

% Modulación AM
modulated_signal1 = (1 + Am1 * message_signal1) .* carrier_signal1;

% Gráficos
figure(1)
subplot(3,1,1);
plot(t, message_signal1);
title('Señal de Mensaje');
xlabel('Tiempo (s)');
ylabel('Amplitud');

subplot(3,1,2);
plot(t, carrier_signal1);
title('Portadora Sin Modular');
xlabel('Tiempo (s)');
ylabel('Amplitud');

subplot(3,1,3);
plot(t, modulated_signal1);
title('Señal Modulada AM');
xlabel('Tiempo (s)');
ylabel('Amplitud');

%Espectro
Y=fft(modulated_signal1);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(N/2))/N;
figure(2)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")


% Parámetros de la señal de mensaje
fs = 1000;               % Frecuencia de muestreo
t = 0:1/fs:1;            % Vector de tiempo
fm2 = 5;                   % Frecuencia de la señal de mensaje (Hz)
Am2 = 1;                   % Amplitud de la señal de mensaje

% Crear la señal de mensaje
message_signal2 = Am2 * sin(2 * pi * fm2 * t);

% Parámetros de la portadora
fc2 = 300;                 % Frecuencia de la portadora (Hz)
Ac2 = 1;                   % Amplitud de la portadora

% Crear la portadora sin modular
carrier_signal2 = Ac2 * sin(2 * pi * fc2 * t);

% Modulación AM
modulated_signal2 = (1 + Am2 * message_signal2) .* carrier_signal2;

%message_signal3=2*sin(2*pi*10*t);


AM=modulated_signal1+modulated_signal2+sin(2*pi*50*t);

%Espectro
Y=fft(AM);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(N/2))/N;
figure(2)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")




%Modulación FM

fDev=20;
Fc_FM=500;
Fs_FM=2*Fc_FM;
Ts_FM=1/Fs_FM;
t2=(0: N-1)*Ts_FM;

FM_signal=fmmod(AM,Fc_FM, Fs_FM,fDev);
figure(3)
plot(t, FM_signal)

FM_designal=fmdemod(FM_signal, Fc_FM, Fs_FM, fDev);

%Espectro
Y=fft(FM_designal);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs_FM*(0:(N/2))/N;
figure(4)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")
