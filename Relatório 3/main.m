%Relatorio 3
M = 1.1; %kg
g_lunar = 1.8; %m/s2
E = 3.6; %N - empuxo jato
theta = 0;
theta1 = 30;
theta2 = -30;
%Condicoes de contorno

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

%Equacaoo Torricelli
%v2 = v02 + 2aS
%leva em consideracaoo as condicoes de contorno do pouso (y = 0; vy = 0)
%a_pouso = (V0^2)/(2*y);

y = 0:40;
V0 = - sqrt(((Fy - P)/M)*(2*y));
V01 = - sqrt(((Fy1 - P)/M)*(2*y));
V02 = - sqrt(((Fy2 - P)/M)*(2*y));
vf1 = -sqrt((-7)^2 + 2*(((Fy - P)/M))*(y-18));
vf2 = -sqrt((-7)^2 + 2*(((Fy1 - P)/M))*(y-18));

% Fit the range fro 10 to 20 with a line.
%limitedRange = 1:50;
%V0t = polyfit(y(limitedRange), V0(limitedRange), 23);
%V01t = polyfit(y(limitedRange), V01(limitedRange), 23);
%V02t = polyfit(y(limitedRange), V02(limitedRange), 23);
%Vf1t = polyfit(y(limitedRange), Vf1(limitedRange), 25);
%Vf2t = polyfit(y(limitedRange), Vf2(limitedRange), 27);


fun = @(y) - ((Fy - P)/M)*(2*y) + (-7)^2 + 2*(((Fy1 - P)/M))*(y-18);
x = fzero(fun, 2);
vo_value = - sqrt(((Fy - P)/M)*(2*x));
t_transf =  (vo_value + 7)/(((Fy1 - P)/M));
t_red = (0 - vo_value)/((Fy - P)/M);
tempo_total = t_transf + t_red;


fun2 = @(y) ((-7)^2 + 2*(((Fy - P)/M))*(y-18)) - (((Fy2 - P)/M)*(2*y)) ;
x2 = fzero(fun2, 2);
vo_value2 = - sqrt(((Fy2 - P)/M)*(2*x2));
t_transf2 =  (vo_value2 + 7)/((Fy - P)/M);
t_red2 = (0 - vo_value2)/((Fy2 - P)/M);
tempo_total2 = t_transf2 + t_red2;

%Primeira Condição
%Sx Sy Vx Vy
InitCond = [0 18 0 -7];
options = odeset('RelTol',1e-12); %minimizacao do erro 
[Times,Out] = ode45(@edos30, [0 t_transf-0.34486], InitCond, options);
len1 = length(Out);
InitCond2 = [Out(len1, 1) Out(len1, 2) Out(len1, 3) Out(len1, 4)];
[TimesX, OutX] = ode45(@edosN30, [t_transf-0.34486 t_transf], InitCond2, options);
lenX = length(OutX);
InitCond3 = [OutX(len1, 1) OutX(len1, 2) OutX(len1, 3) OutX(len1, 4)];
[Times2,Out2] = ode45(@edos0, [t_transf tempo_total], InitCond3, options);



%Segunda Condição
%Sx Sy Vx Vy
InitCond = [0 18 0 -7];
options = odeset('RelTol',1e-12); %minimizacao do erro 
[Times3,Out3] = ode45(@edos0, [0 t_transf2], InitCond, options);
len2 = length(Out3);
InitCond2 = [Out3(len2, 1) Out3(len2, 2) Out3(len2, 3) Out3(len2, 4)];
[Times4,Out4] = ode45(@edos30, [t_transf2 tempo_total2-1.48835], InitCond2, options);
len3 = length(Out4);
InitCond3 = [Out4(len3, 1) Out4(len3, 2) Out4(len3, 3) Out4(len3, 4)];
[Times5,Out5] = ode45(@edosN30, [tempo_total2-1.48835 tempo_total2], InitCond3, options);


figure(1)
p1 = plot(V0, y, 'red'); %0
hold on
p2 = plot(V01, y, 'blue'); %30
p3 = plot(V02, y, 'black'); %-30
p4 = scatter(-7, 18, 'filled');
p5 = plot(vf1, y, 'green'); %0
p6 = plot(vf2, y, 'magenta'); %30 ou -30
xlabel('Velocidade em y')
ylabel('Altitude')
h = [p1;p2;p3;p4;p5;p6];
legend(h,'Pouso suave 0','Pouso suave 30', 'Pouso suave -30','Ponto inicial','Final 0', 'Final 30 ou -30');
hold off

%Para plotar as condições 1 e 2 somente comentar e descomentar utilizando %
%Vetores Finais sem correção em X - Condição 1
%x = [Out(:, 1); Out2(:,1)];
%y = [Out(:, 2); Out2(:,2)];
%Vx = [Out(:, 3); Out2(:,3)];
%Vy = [Out(:, 4); Out2(:,4)];

%Vetores Finais sem correção em X - Condição 2
x = [Out3(:, 1); Out5(:,1)];
y = [Out3(:, 2); Out5(:,2)];
Vx = [Out3(:, 3); Out5(:,3)];
Vy = [Out3(:, 4); Out5(:,4)];

figure(2)
plot(x,y);
xlabel('Coordenadas em X')
ylabel('Coordenadas em y')

figure(3)
plot(Vx, y);
xlabel('Velocidade em X')
ylabel('Coordenadas em y')

figure(4)
plot(Vx, Vy);
xlabel('Velocidade em X')
ylabel('Velocidade em y')

figure(5)
plot(Vy, x);
xlabel('Velocidade em y')
ylabel('Coordenadas em x')

figure(6)
plot(Vy, y);
xlabel('Velocidade em y')
ylabel('Coordenadas em y')



%% Massa Variável

clear all
clc

%Colocar  as condições iniciais no formato:
%h0 = altitude inicial
%v0= velocidade inicial
%mass = massa da espaçonave
%fuel = massa do combustível
%g = gravidade lunar
%k = constante (velocidade relativa dos gases de exaustão com relação à espaçonave)
%mu = taxa máxima da variação de massa devido à queima de combustível

% Calcula a trajetória de pouso:
[t1, t2, x1_1, x2_1, x1_2, x2_2, x3_2] = landing (h0, v0, mass, fuel, g, k, mu);
% Saídas:
% t1: tempo do acionamento do motor
% t2: tempo do pouso
% x1_1: altitude em função do tempo, antes do acionamento   [ altitude = x1_1(t),   0 <= t <= t1 ]
% x2_1: velocidade em função do tempo, antes do acionamento [ velocidade = x2_1(t), 0 <= t <= t1 ]
% x1_2: altitude em função do tempo, após o acionamento     [ altitude = x1_2(t),   t1 <= t <= t2 ]
% x2_2: velocidade em função do tempo, após o acionamento   [ velocidade = x2_2(t), t1 <= t <= t2 ]
% x3_2: massa em função do tempo, após o acionamento        [ massa = x3_2(t),      t1 <= t <= t2 ]












