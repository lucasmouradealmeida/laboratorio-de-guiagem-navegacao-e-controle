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
[Times,Out] = ode45(@edos30, [0 t_transf], InitCond, options);
InitCond2 = [0.3892 13.4181 1.1286 -6.2867];
[Times2,Out2] = ode45(@edos0, [t_transf tempo_total], InitCond2, options);

%Segunda Condição
%Sx Sy Vx Vy
InitCond = [0 18 0 -7];
options = odeset('RelTol',1e-12); %minimizacao do erro 
[Times3,Out3] = ode45(@edos0, [0 t_transf2], InitCond, options);
InitCond2 = [0 4.5821 0 -3.0787];
[Times4,Out4] = ode45(@edos30, [t_transf2 tempo_total2], InitCond2, options);


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

%Vetores Finais sem correção em X
x = [Out(:, 1); Out2(:,1)];
y = [Out(:, 2); Out2(:,2)];
Vx = [Out(:, 3); Out2(:,3)];
Vy = [Out(:, 4); Out2(:,4)];

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














