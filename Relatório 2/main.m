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

%Condicao inicial
InitCond = [r v];

%Solucoes ODE45 (Possivel modificar e multiplicar T (quantidade de periodos))
options = odeset('RelTol',1e-12); %minimizacao do erro 

[Times,Out] = ode45(@edos, [0 50*T], InitCond, options);

%Dados baseadas na data juliana do two lines
%https://www.calendarlabs.com/templates/2022/2022-yearly-julian-calendar-04.pdf
ground_track(Out,T,22,6,7);

%Localização de um ponto qualquer na superfície da Terra (Dados fornecidos)

localizacao_ponto(-2.671667, -44.42056, 45, 19,09,05);

