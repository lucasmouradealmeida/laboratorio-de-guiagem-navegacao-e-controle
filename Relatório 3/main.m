%Relatório 3
M = 1.1; %kg
g_lunar = 1.8; %m/s2
E = 3.6; %N - empuxo jato
theta = 0;
theta1 = 30;
theta2 = -30;
%Condições de contorno

%Movimento vertical
Fx = E*sin(theta);
Fy = E*cos(theta);
Fy1 = E*cos(deg2rad(theta1));
Fy2 = E*cos(deg2rad(theta2));
P = M*g_lunar;

%Eixo x 
ax = Fx/M;
%Eixo y
ay = (Fy + P)/M;

%Pouso suave: y = 0; vx e vy = 0 no pouso
%2 - PFD

%Equação Torricelli
%v2 = v02 + 2aS
%leva em consideração as condicoes de contorno do pouso (y = 0; vy = 0)
%a_pouso = (V0^2)/(2*y);


y = 0:40;
V0 = - sqrt(((Fy - P)/M)*(2*y));
V01 = - sqrt(((Fy1 - P)/M)*(2*y));
V02 = - sqrt(((Fy2 - P)/M)*(2*y));
vf1 = -sqrt((-7)^2 + 2*(((Fy - P)/M))*(y-18));
vf2 = -sqrt((-7)^2 + 2*(((Fy1 - P)/M))*(y-18));

figure(1)
plot(V0, y, 'red'); %0
hold on
plot(V01, y, 'blue'); %30
plot(V02, y, 'black'); %-30
scatter(-7, 18, 'filled');
plot(vf1, y, 'green'); %0
plot(vf2, y, 'magenta'); %30 ou -30
hold off


%calculo do tempo
t1 = (-6.2883 + 7 ) / (((Fy1 - P)/M));
t2 =0 ;















