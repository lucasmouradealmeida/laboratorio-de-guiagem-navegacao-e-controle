%Dados do Grupo (Parado)
%parado_grupo = importdata('dados.txt');
%dados_parado_grupo = format_data(parado_grupo);

%Dados da professora (Parado)
%parado_prof = importdata('parada.txt');
%dados_parado_prof = format_data(parado_prof);

%Dado da professora (Movimento)
mov_prof = importdata('90yzx.txt');
data = format_data(mov_prof);


%TRIAD
angle = zeros(length(mov_prof),3);

for i=1:length(mov_prof)

triad_mov_prof = TRIAD(mov_prof, data(:,1), ...
    data(:,2), data(:,3), ...
    data(:,4), data(:,5), ...
    data(:,6), i);

%Determinação angular (TRIAD)
[angle(i,1), angle(i,2), angle(i,3)] = triad_angle(triad_mov_prof);

end

%plot - Variação do ângulo no tempo
figure(1)
plot(data(:,10), angle(:,1), 'red')
hold on
plot(data(:,10), angle(:,2), 'blue')
plot(data(:,10), angle(:,3), 'green')
legend('theta', 'phi', 'psi')
hold off

%Integração por Trapézio
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

figure(2)
plot(time, theta_trapz, 'red')
hold on
plot(time, phi_trapz, 'blue')
plot(time, psi_trapz, 'green')
hold off
legend('theta', 'phi', 'psi')


%Quaternion










