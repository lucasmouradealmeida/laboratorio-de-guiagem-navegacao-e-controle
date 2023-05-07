%Relatorio 3

%Constantes

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
ay = (Fy - P)/M;

%Pouso suave

% Final: y = 0; vx e vy = 0
%Condições Iniciais
y0 = 18;
vy = -7;

%Utilizando a equacao Torricelli
y = 0:40;

%Curvas de velocidade inicial
V0 = - sqrt(((Fy - P)/M)*(2*y));

V01 = - sqrt(((Fy1 - P)/M)*(2*y));

V02 = - sqrt(((Fy2 - P)/M)*(2*y));


%CUrvas de velocidade Final
vf1 = -sqrt((vy)^2 + 2*(((Fy - P)/M))*(y-y0));

vf2 = -sqrt((vy)^2 + 2*(((Fy1 - P)/M))*(y-y0));

%Minimização do y para 0 -> Condição 1
fun = @(y) - ((Fy - P)/M)*(2*y) + (vy)^2 + 2*(((Fy1 - P)/M))*(y-y0);
x = fzero(fun, 2); %Altura de encontro entre as curvas
vo_value = - sqrt(((Fy - P)/M)*(2*x)); %Velocidade no encontro entre as curvas
t_transf =  (vo_value - vy)/(((Fy1 - P)/M)); %Tempo para transferencia
t_red = (0 - vo_value)/((Fy - P)/M); %Tempo da curva para pouso
tempo_total = t_transf + t_red; %Tempo total

%Minimização para y para 0 -> Condição 2
fun2 = @(y) ((-7)^2 + 2*(((Fy - P)/M))*(y-18)) - (((Fy2 - P)/M)*(2*y)) ;
x2 = fzero(fun2, 2);
vo_value2 = - sqrt(((Fy2 - P)/M)*(2*x2));
t_transf2 =  (vo_value2 + 7)/((Fy - P)/M);
t_red2 = (0 - vo_value2)/((Fy2 - P)/M);
tempo_total2 = t_transf2 + t_red2;


%Primeira Condição -> Ocorre o ajuste para zerar a velocidade em X
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



%Segunda Condição -> Ocorre o ajuste para zerar a velocidade em X
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

%Plots
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

%Plots dos vetores finais -> Condiççao 2
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



%% Massa Variável - Código Fornecido -> Atenção: contém erro na massa

clear all
clc

%Colocar  as condições iniciais no formato:
%h0 = altitude inicial
h0 = 18;
%h0 = 50000;
%v0= velocidade inicial
v0 = -7;
%v0 = -150;
%mass = massa da espaçonave
mass = 2010.51;
%fuel = massa do combustível
fuel = 719.63;
%g = gravidade lunar
g = 1.8;
%k = constante (velocidade relativa dos gases de exaustão com relação à espaçonave)
k = 636;
%mu = taxa máxima da variação de massa devido à queima de combustível
mu = 16.5;

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

%Gráficos dos valores das funções em função do tempo

x1 = 0:t1;
x2 = t1:t2;

figure(1)
plot(x1, x1_1(x1))
hold on
plot(x2, x1_2(x2))
xlabel('Tempo')
ylabel('Altitude')
hold off

figure(2)
plot(x1, x2_1(x1))
hold on
plot(x2, x2_2(x2))
xlabel('Tempo')
ylabel('Velocidade')
hold off

figure(3)
plot(x2, x3_2(x2))
xlabel('Tempo')
ylabel('Massa')















