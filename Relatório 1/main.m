%Problema de dois corpos

%Constantes
mi_Terra = 3.986*(10^5); %km3/s2

%-----------------------------------------------------------

%Two lines

%First line = [satelliteNumber(1) intDesignator(2) epochNumb(3).julianDate(4) 
% 1st(5) 2nd(6) drag(7) epochy(8) elementNumb(9)]

%Second Line = [satelliteNumber(1) inclination(2) rightAscendingNode(3) eccentricity(4) 
% argumentPerigeu(5) anomaliaMedia(6) meanMotion(7) revNumb(8)]

%-----------------------------------------------------------

%Resolução

first_line = [07276 74026 22158.20205273 0.00000124 00000 00000 0 9995];
second_line = [07276 64.2707 228.5762 0.6489050 281.4937 16.8767 2.45097347248963];

anomaliaMedia = second_line(1, 6);
excentricidade = second_line(1, 4);
meanMotion = second_line(1,7);
inclination = second_line(1,2);
argumentoPerigeu = second_line(1,5);
nodoAscedente = second_line(1,3);


%Conversao da anomalia media para verdadeira
theta = converter_anomalia_media_verdadeira(deg2rad(anomaliaMedia), excentricidade);

%Semieixo maior
[semieixo, n] = semieixoMaior(mi_Terra, meanMotion);

%Coordenada Orbital
[xo, yo, zo] = dirOrbital(deg2rad(theta), excentricidade, semieixo);

%Coordenada Inercial
coordInercial = matrizTranspostaRotacao(deg2rad(inclination), deg2rad(argumentoPerigeu), ...
    deg2rad(nodoAscedente)) * [xo; yo; zo];

%Velocidade Orbital
[vx, vy, vz] = velOrbital(n, excentricidade, deg2rad(theta),semieixo);

%Velocidade Inercial
velocidadeInercial = matrizTranspostaRotacao(deg2rad(inclination), deg2rad(argumentoPerigeu), ...
    deg2rad(nodoAscedente)) * [vx; vy; vz];


%Aplicacao do processo de integracao
%ODE 45

%Dados do Item a
T = 2*pi/n;
r = coordInercial';
v = velocidadeInercial';

%Plot do Elipsoide De referencia
r_pol = 6356.752; %Raio polar
r_eq = 6378.137; %Raio equatorial

[x, y, z]= ellipsoid(0,0,0, r_eq, r_eq, r_pol);

figure
body = surf(x,y,z);
colormap(cool)
axis equal
hold on 

%Condicao inicial
InitCond = [r v];

%Solucoes ODE45 (Possivel modificar e multiplicar T (quantidade de periodos))
options = odeset('RelTol',1e-12); %minimizacao do erro 

%Item a:
[Times,Out] = ode45(@edos, [0 50*T], InitCond, options);

%Plot do grafico - Numérica
p = plot3(Out(:,1),Out(:,2),Out(:,3));

axis equal
grid on

%Textura da terra no elipsoide (Necessaria uma conexao com a internet)
texture_url = 'http://www.shadedrelief.com/natural3/images/earth_clouds.jpg';
cdata = flip(imread(texture_url));
set(body, 'FaceColor', 'texturemap', 'CData', cdata, 'EdgeColor', 'none');

%Plot - Solucao Analitica 
for theta=0:0.07:deg2rad(360)
    p = semieixo*(1 - excentricidade^2);
    r = p/(1+excentricidade*cos(theta));
    xo = r*cos(theta);
    yo = r*sin(theta);
    zo = 0;
    coordInercial = matrizTranspostaRotacao(deg2rad(64.2707), deg2rad(281.4937), deg2rad(228.5762)) * [xo; yo; zo];
    scatter3(coordInercial(1,1), coordInercial(2,1), coordInercial(3,1), '.','red')
end

hold off
