%Problema de dois corpos
%Constantes
mi_Terra = 3.986*(10^5); %km3/s2

%-----------------------------------------------------------

%Resoluções
%(item a) 2 07276 64.2707 228.5762 6489050 281.4937 16.8767 2.45097347248963
%(item b) 2 02717 0.7404 32.0789 0014515 234.9766 357.1212 1.00360058109167

%Semieixo maior
%item a
disp('Item A')

[semieixo_a, n_a] = semieixoMaior(mi_Terra, 2.4509);

%Coordenada Orbital
[xo_a, yo_a, zo_a] = dirOrbital(deg2rad(16.8767), 0.6489050, semieixo_a);

%Coordenada Inercial
coordInercial_a = matrizTranspostaRotacao(deg2rad(64.2707), deg2rad(281.4937), deg2rad(228.5762)) * [xo_a; yo_a; zo_a];

%Velocidade Orbital
[vx_a, vy_a, vz_a] = velOrbital(n_a, 0.6489, deg2rad(16.8767),semieixo_a);

%Velocidade Inercial
velocidadeInercial_a = matrizTranspostaRotacao(deg2rad(64.2707), deg2rad(281.4937), deg2rad(228.5762)) * [vx_a; vy_a; vz_a];

%--------------------------------------------------------

%item b
disp('Item B')
[semieixo_b, n_b] = semieixoMaior(mi_Terra, 1.0036);
[xo_b, yo_b, zo_b] = dirOrbital(deg2rad(357.1212), 0.0014515, semieixo_b);

coordInercial_b = matrizTranspostaRotacao(deg2rad(0.7404), deg2rad(234.9766), deg2rad(32.0789)) * [xo_a; yo_a; zo_a];

[vx_b, vy_b, vz_b] = velOrbital(n_b, 0.0014515, deg2rad(357.1212), semieixo_b);
velocidadeInercial_b = matrizTranspostaRotacao(deg2rad(0.7404), deg2rad(234.9766), deg2rad(32.0789)) * [vx_b; vy_b; vz_b];

%-----------------------------------------------------------------

%ODE 45

%Item a
T_a = 2*pi/n_a;
r_a = coordInercial_a';
v_a = velocidadeInercial_a';

%Plot do Elipsoide De referencia
r_pol = 6356.752; %Raio polar
r_eq = 6378.137; %Raio equatorial

[x, y, z]= ellipsoid(0,0,0, r_eq, r_eq, r_pol);

figure
body = surf(x,y,z);
colormap(cool)
axis equal
hold on 

InitCond = [r_a v_a];

[Times,Out] = ode45(@edos, [0 T_a], InitCond);

%Plot do grafico
p = plot3(Out(:,1),Out(:,2),Out(:,3));

axis equal
grid on

%textura da terra no elipsoide (necessaria uma conexao com a internet)
texture_url = 'http://www.shadedrelief.com/natural3/images/earth_clouds.jpg';
cdata = flip(imread(texture_url));
set(body, 'FaceColor', 'texturemap', 'CData', cdata, 'EdgeColor', 'none');

%solucao analitica pontos
semieixo = semieixo_a;
ex = 0.6489050;
for theta=0:1:360
    p = semieixo*(1 - ex^2);
    r = p/(1+ex*cos(theta));
    xo = r*cos(theta);
    yo = r*sin(theta);
    zo = 0;
    coordInercial = matrizTranspostaRotacao(deg2rad(64.2707), deg2rad(281.4937), deg2rad(228.5762)) * [xo; yo; zo];
    plot3(coordInercial(1,1), coordInercial(2,1), coordInercial(3,1), 'MarkerSize', 20)
    
end


hold off
