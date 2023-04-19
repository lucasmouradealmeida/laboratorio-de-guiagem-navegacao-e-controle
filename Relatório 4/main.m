%Dados(Em Movimento)
data = format_data(importdata('data_cel.txt'));

%TRIAD
angle = zeros(length(data),3);
alfa = zeros(length(data),1);
q4 = zeros(length(data),1);
v = zeros(1,3,length(data));
q = zeros(4,1,length(data));

for i=1:length(data)

triad_mov = TRIAD(data, data(:,1), ...
    data(:,2), data(:,3), ...
    data(:,4), data(:,5), ...
    data(:,6), i);

%Quaternion
alfa(i) = acosd(0.5*(trace(triad_mov)-1));
v(:,:,i) = [(triad_mov(2,3)-triad_mov(3,2)) (triad_mov(3,1)-triad_mov(1,3)) (triad_mov(1,2)-triad_mov(2,1))]*sind(alfa(i)/2);
q4(i) = cosd(alfa(i)/2);
q(:,:,i) = [v(1,1,i); v(1,2,i); v(1,3,i); q4(i)];

%Determina??o angular (TRIAD)
[angle(i,1), angle(i,2), angle(i,3)] = triad_angle(triad_mov);

end

%Plot - Triad
figure(1)
plot(data(:,10), angle(:,1), 'red')
hold on
plot(data(:,10), angle(:,2), 'blue')
plot(data(:,10), angle(:,3), 'green')
legend('theta', 'phi', 'psi')
ylim([-90,90])
hold off



%Integra??o por Trap?zio
gx = data(:, 7);
gy = data(:,8);
gz = data(:,9);
time = data(:,10)/1000;

theta_trapz = zeros(length(time), 1);
phi_trapz = zeros(length(time), 1);
psi_trapz = zeros(length(time), 1);

for i=2:length(time)
    theta_trapz(i) = theta_trapz(i - 1) - trapz([time(i) time(i-1)],[gy(i) gy(i-1)]);
    phi_trapz(i) = phi_trapz(i - 1) - trapz([time(i) time(i-1)],[gx(i) gx(i-1)]);
    psi_trapz(i) = psi_trapz(i - 1) - trapz([time(i) time(i-1)],[gz(i) gz(i-1)]);
end

%Plot - Trap?zio
figure(2)
plot(time, theta_trapz, 'red')
hold on
plot(time, phi_trapz, 'blue')
plot(time, psi_trapz, 'green')
legend('theta', 'phi', 'psi')
ylim([-90,90])
hold off



%Plot - Quaternion
qx = zeros(length(data), 1);
qy = zeros(length(data), 1);
qz = zeros(length(data), 1);

for i=1:length(data)
    qx(i) = rad2deg(q(1,1,i));
    qy(i) = rad2deg(q(2,1,i));
    qz(i) = rad2deg(q(3,1,i));
end

figure(3)
plot(time, qx, 'red')
hold on
plot(time, qy, 'blue')
plot(time, qz, 'green')
legend('q1', 'q2', 'q3')
ylim([-90,90])
hold off


%teste interferencia 
%acelerometro
figure(4)
plot(time, data(:,1), 'red')
hold on
plot(time, data(:,2), 'blue')
plot(time, data(:,3), 'green')
legend('X', 'Y', 'Z')
ylim([-0.2,1.2])
xlabel('Tempo [s]')
ylabel('Gravidade da Terra [g]')
hold off

%magnetometro
figure(5)
plot(time, data(:,4), 'red')
hold on
plot(time, data(:,5), 'blue')
plot(time, data(:,6), 'green')
legend('X', 'Y', 'Z')
ylim([-1.2,0.2])
xlabel('Tempo [s]')
ylabel('Tesla [T]')
hold off

%giroscopio
figure(6)
plot(time, data(:,7), 'red')
hold on
plot(time, data(:,8), 'blue')
plot(time, data(:,9), 'green')
legend('X', 'Y', 'Z')
ylim([-0.8,0.8])
xlabel('Tempo [s]')
ylabel('Velocidade Angular [rad/s]')
hold off
