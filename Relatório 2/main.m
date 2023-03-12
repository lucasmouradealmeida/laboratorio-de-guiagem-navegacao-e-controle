%Problema de dois corpos

%Constantes
mi_Terra = 3.986*(10^5); %km3/s2

%-----------------------------------------------------------

%Item a
%two lines: 1 07276U 74026A 22158.20205273 .00000124 00000+0 00000+0 0 9995
%2 07276 64.2707 228.5762 6489050 281.4937 16.8767 2.45097347248963

%Conversao da anomalia media para verdadeira
%theta_a = 16.8767
theta_a = converter_anomalia_media_verdadeira(deg2rad(16.8767), 0.6489050);

%Semieixo maior
[semieixo_a, n_a] = semieixoMaior(mi_Terra, 2.4509);

%Coordenada Orbital
[xo_a, yo_a, zo_a] = dirOrbital(deg2rad(theta_a), 0.6489050, semieixo_a);

%Coordenada Inercial
coordInercial_a = matrizTranspostaRotacao(deg2rad(64.2707), deg2rad(281.4937), deg2rad(228.5762)) * [xo_a; yo_a; zo_a];

%Velocidade Orbital
[vx_a, vy_a, vz_a] = velOrbital(n_a, 0.6489, deg2rad(theta_a),semieixo_a);

%Velocidade Inercial
velocidadeInercial_a = matrizTranspostaRotacao(deg2rad(64.2707), deg2rad(281.4937), deg2rad(228.5762)) * [vx_a; vy_a; vz_a];

%--------------------------------------------------------

%item b
%two lines: 1 02717U 67026A 22159.70244616 -.00000351 00000+0 00000+0 0 9995
%2 02717 0.7404 32.0789 0014515 234.9766 357.1212 1.00360058109167

%Convers?o da anomalia media para verdadeira
%theta_b = 357.1212
theta_b = converter_anomalia_media_verdadeira(deg2rad(357.1212),0.0014515);

%Semieixo maior
[semieixo_b, n_b] = semieixoMaior(mi_Terra, 1.0036);


%Coordenada Orbital
[xo_b, yo_b, zo_b] = dirOrbital(deg2rad(theta_b), 0.0014515, semieixo_b);

%Coordenada Inercial
coordInercial_b = matrizTranspostaRotacao(deg2rad(0.7404), deg2rad(234.9766), deg2rad(32.0789)) * [xo_b; yo_b; zo_b];

%Velocidade Orbital
[vx_b, vy_b, vz_b] = velOrbital(n_b, 0.0014515, deg2rad(theta_b), semieixo_b);

%Velocidade Inercial
velocidadeInercial_b = matrizTranspostaRotacao(deg2rad(0.7404), deg2rad(234.9766), deg2rad(32.0789)) * [vx_b; vy_b; vz_b];

%Aplicacaoo do processo de integracao
%ODE 45

%Dados do Item a
T_a = 2*pi/n_a;
r_a = coordInercial_a';
v_a = velocidadeInercial_a';

%Dados do Item b
T_b = 2*pi/n_b;
r_b = coordInercial_b';
v_b = velocidadeInercial_b';

%Condicao inicial do item A
InitCond = [r_a v_a];

%Condicao inicial do item B
InitCond2 = [r_b v_b];

%Solucoes ODE45 (Possivel modificar e multiplicar T_a e T_b (quantidade de periodos))
options = odeset('RelTol',1e-12); %minimizacao do erro 

%Item a:
[Times,Out] = ode45(@edos, [0 1*T_a], InitCond, options);

ground_track(Out,T_a,22,6,7);

%Item b
[Times2,Out2] = ode45(@edos, [0 1*T_b], InitCond2, options);

ground_track(Out2,T_b,22,6,8);


%Localização de um ponto

localizacao_ponto(-2.671667, -44.42056, 45, 19,09,05);

