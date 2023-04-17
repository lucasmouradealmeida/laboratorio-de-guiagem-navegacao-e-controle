clear
close all

file = 'data.txt';

table = readtable(file);

%% Etapa 1
% Acele normalizado
norm_acel = 256;

norm_acelx = -table2array(table(:, 1))/norm_acel; %mudanca para o eixo do giroscopio
norm_acely = table2array(table(:, 2))/norm_acel;
norm_acelz = table2array(table(:, 3))/norm_acel;


% Mag normalizado

magx = -table2array(table(:,5)); %mudanca para o eixo do giroscopio
magy = table2array(table(:,4)); %mudanca para o eixo do giroscopio
magz = table2array(table(:,6));

for i = 1:length(magx)
    modul(i) = norm([magx(i) magy(i) magz(i)]);

    norm_magx(i) = magx(i)/modul(i);
    norm_magy(i) = magy(i)/modul(i);
    norm_magz(i) = magz(i)/modul(i);
end

norm_magx = norm_magx';
norm_magy = norm_magy';
norm_magz = norm_magz';



% Giro normalizado
norm_giro = 14.375;

norm_girox = table2array(table(:, 7))/norm_giro;
norm_giroy = table2array(table(:, 8))/norm_giro;
norm_giroz = table2array(table(:, 9))/norm_giro;

% Tempo
time_dt = table2array(table(:, 10));
time(1) = time_dt(1);
for i = 2:length(time_dt)
    time(i) = time(i - 1) + time_dt(i);
end
time = time';

% Desvio parado 

%Acel
ideal_acelx = 0;
ideal_acely = 0;
ideal_acelz = 1;
media_acelx = mean(norm_acelx);
media_acely = mean(norm_acely);
media_acelz = mean(norm_acelz);
desv_acelx = ideal_acelx - media_acelx;
desv_acely = ideal_acely - media_acely;
desv_acelz = ideal_acelz - media_acelz;

%Mag
ideal_magx = 0;
ideal_magy = 1; %mudanca para o eixo do giroscopio
ideal_magz = 0;
media_magx = mean(norm_magx);
media_magy = mean(norm_magy);
media_magz = mean(norm_magz);
desv_magx = ideal_magx - media_magx;
desv_magy = ideal_magy - media_magy;
desv_magz = ideal_magz - media_magz;

%Giro
ideal_girox = 0;
ideal_giroy = 0;
ideal_giroz = 0;
media_girox = mean(norm_girox);
media_giroy = mean(norm_giroy);
media_giroz = mean(norm_giroz);
desv_girox = ideal_girox - media_girox;
desv_giroy = ideal_giroy - media_giroy;
desv_giroz = ideal_giroz - media_giroz;


% Parado 

cal_norm_acelx_parado = norm_acelx + desv_acelx;
cal_norm_acely_parado = norm_acely + desv_acely;
cal_norm_acelz_parado = norm_acelz + desv_acelz;
cal_norm_magx_parado = norm_magx + desv_magx;
cal_norm_magy_parado = norm_magy + desv_magy;
cal_norm_magz_parado = norm_magz + desv_magz;
cal_norm_girox_parado = norm_girox + desv_girox;
cal_norm_giroy_parado = norm_giroy + desv_giroy;
cal_norm_giroz_parado = norm_giroz + desv_giroz;




%% Em movimento

file2 = 'data.txt';

table2 = readtable(file2, 'ReadRowNames', false);



norm_acel = 256;
norm_acelx = -table2array(table2(:, 1))/norm_acel;
norm_acely = table2array(table2(:, 2))/norm_acel;
norm_acelz = table2array(table2(:, 3))/norm_acel;


% Mag normalizado
magx = -table2array(table2(:,5));
magy = table2array(table2(:,4));
magz = table2array(table2(:,6));

for i = 1:length(magx)
    modul(i) = norm([magx(i) magy(i) magz(i)]);

    norm_magx(i) = magx(i)/modul(i);
    norm_magy(i) = magy(i)/modul(i);
    norm_magz(i) = magz(i)/modul(i);
end

norm_magx = norm_magx';
norm_magy = norm_magy';
norm_magz = norm_magz';



% Giro normalizado
norm_giro = 14.375;

norm_girox = table2array(table2(:, 7))/norm_giro;
norm_giroy = table2array(table2(:, 8))/norm_giro;
norm_giroz = table2array(table2(:, 9))/norm_giro;

% Tempo
time_dt = table2array(table2(:, 10));
time(1) = time_dt(1);
for i = 2:length(time_dt)
    time(i) = time(i - 1) + time_dt(i);
end
time = time';


% Movimento
cal_norm_acelx = norm_acelx + desv_acelx;
cal_norm_acely = norm_acely + desv_acely;
cal_norm_acelz = norm_acelz + desv_acelz;
cal_norm_magx = norm_magx + desv_magx;
cal_norm_magx = cal_norm_magx';
cal_norm_magy = norm_magy + desv_magy;
cal_norm_magy = cal_norm_magy';
cal_norm_magz = norm_magz + desv_magz;
cal_norm_magz = cal_norm_magz';
cal_norm_girox = norm_girox + desv_girox;
cal_norm_giroy = norm_giroy + desv_giroy;
cal_norm_giroz = norm_giroz + desv_giroz;

%{
figure(1)
plot(time,cal_norm_acelx)
%hold on 
%plot(time, norm_acelx, 'r')

figure(2)
plot(time,cal_norm_acely)
%hold on 
%plot(time, norm_acely, 'r')

figure(3)
plot(time,cal_norm_acelz)
%hold on 
%plot(time, norm_acelz, 'r')

figure(4)
plot(time,cal_norm_magx)
%hold on 
%plot(time, norm_magx, 'r')

figure(5)
plot(time,cal_norm_magy)
%hold on 
%plot(time, norm_magy, 'r')

figure(6)
plot(time,cal_norm_magz)
%hold on 
%plot(time, norm_magz, 'r')
%}
figure(7)
plot(time,cal_norm_girox)
%hold on 
%plot(time, norm_girox, 'r')

figure(8)
plot(time,cal_norm_giroy)
%hold on 
%plot(time, norm_giroy, 'r')

figure(9)
plot(time,cal_norm_giroz)
%hold on 
%plot(time, norm_giroz, 'r')

%% Usar acelerometro e magnetrometro (triade)
 
t1_b = [cal_norm_acelx          cal_norm_acely          cal_norm_acelz];
t1_i = [cal_norm_acelx_parado   cal_norm_acely_parado   cal_norm_acelz_parado];

m_b = [cal_norm_magx            cal_norm_magy           cal_norm_magz];
m_i = [cal_norm_magx_parado     cal_norm_magy_parado    cal_norm_magz_parado];

for i = 1:length(t1_b)
    t2_b(i, :) = cross(t1_b(i, :), m_b(i, :))/norm(cross(t1_b(i, :), m_b(i, :)));
    t2_i(i, :) = cross(t1_i(i, :), m_i(i, :))/norm(cross(t1_i(i, :), m_i(i, :)));
    t3_b(i, :) = cross(t1_b(i, :), t2_b(i, :))/norm(cross(t1_b(i, :), t2_b(i, :)));
    t3_i(i, :) = cross(t1_i(i, :), t2_i(i, :))/norm(cross(t1_i(i, :), t2_i(i, :)));
end
%t2_b = cross(t1_b, m_b)/norm(cross(t1_b, m_b));
%t2_i = cross(t1_i, m_i)/norm(cross(t1_b, m_i));

%t3_b = cross(t1_b, t2_b)/norm(cross(t1_b, t2_b));
%t3_i = cross(t1_i, t2_i)/norm(cross(t1_b, t2_i));

for i = 1:length(t1_b)
    R_bt(:, :, i) = [t1_b(i, :); t2_b(i, :); t3_b(i, :)];
    R_it(:, :, i) = [t1_i(i, :); t2_i(i, :); t3_i(i, :)];

    R_bi(:, :, i) = R_bt(:, :, i)*(R_it(:, :, i)');
    
    theta(i) = asind(R_bi(3,1,i));
    phi(i) = asind(-R_bi(3,2,i)/cosd(theta(i)));
    psi(i) = asind(-R_bi(2,1,i)/cosd(theta(i)));
    
    phi(i) = asind(R_bi(3,1,i));
    psi(i) = -asind(-R_bi(3,2,i)/cosd(phi(i)));
    theta(i) = asind(-R_bi(2,1,i)/cosd(phi(i)));
    
   %psi(i) = acosd(R_bi(1,1,i)/cosd(theta(i)));
    %phi(i) = acosd(R_bi(3,3,i)/cosd(theta(i)));
   
    
end

figure()
plot(time,theta, 'r')
hold on
plot(time,psi, 'g')
hold on
plot(time,phi, 'b')
legend('theta', 'psi', 'phi')
%}
%% Trapezio

psi_trap(1) = 0;
phi_trap(1) = 0;
theta_trap(1) = 0;
for i = 2:length(time)
    
    psi_trap(i) = psi_trap(i - 1) + (((time(i) - time(i - 1))/1000)*(cal_norm_giroz(i) + cal_norm_giroz(i - 1))/2);
    phi_trap(i) = phi_trap(i - 1) + (((time(i) - time(i - 1))/1000)*(cal_norm_girox(i) + cal_norm_girox(i - 1))/2);
    theta_trap(i) = theta_trap(i - 1) + (((time(i) - time(i - 1))/1000)*(cal_norm_giroy(i) + cal_norm_giroy(i - 1))/2);
    
    %psi_trap2(i) = trapz(time(1:i)/1000, cal_norm_giroz(1:i));
    %phi_trap2(i) = trapz(time(1:i)/1000, cal_norm_girox(1:i));
    %theta_trap2(i) = trapz(time(1:i)/1000, cal_norm_giroy(1:i));
end

figure
plot(time/1000, theta_trap, 'r')
hold on
plot(time/1000, psi_trap, 'g')
hold on
plot(time/1000, phi_trap, 'b')
legend('theta', 'psi', 'phi')
%}

%% Quaternion

c_bar = @(x) cosd(x)/2;
s_bar = @(x) sind(x)/2;

q_triad = [(s_bar(phi).*c_bar(theta).*c_bar(psi)) + (c_bar(phi).*s_bar(theta).*s_bar(psi));
     (c_bar(phi).*s_bar(theta).*c_bar(psi)) + (s_bar(phi).*c_bar(theta).*s_bar(psi));
     (c_bar(phi).*c_bar(theta).*s_bar(psi)) + (s_bar(phi).*s_bar(theta).*c_bar(psi));
     (c_bar(phi).*c_bar(theta).*c_bar(psi)) + (s_bar(phi).*s_bar(theta).*s_bar(psi));
];

q_trap = [(s_bar(phi_trap).*c_bar(theta_trap).*c_bar(psi_trap)) + (c_bar(phi_trap).*s_bar(theta_trap).*s_bar(psi_trap));
     (c_bar(phi_trap).*s_bar(theta_trap).*c_bar(psi_trap)) + (s_bar(phi_trap).*c_bar(theta_trap).*s_bar(psi_trap));
     (c_bar(phi_trap).*c_bar(theta_trap).*s_bar(psi_trap)) + (s_bar(phi_trap).*s_bar(theta_trap).*c_bar(psi_trap));
     (c_bar(phi_trap).*c_bar(theta_trap).*c_bar(psi_trap)) + (s_bar(phi_trap).*s_bar(theta_trap).*s_bar(psi_trap));
];