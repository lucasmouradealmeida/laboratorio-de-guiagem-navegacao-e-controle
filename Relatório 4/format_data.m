function [allVec] = format_data(data)
%Acelerometro
acx = data(:,1)/256;
acy = data(:,2)/256;
acz = data(:,3)/256;

%Magnetometro
magmod = sqrt(data(:, 4).^2 + data(:,5).^2 + data(:,6).^2);
mgx = data(:,4)./magmod;
mgy = data(:,5)./magmod;
mgz = data(:,6)./magmod;

%Giroscopio
grx = data(:,7)/(14.375);
gry = data(:,8)/(14.375);
grz = data(:,9)/(14.375);

%Médias do acelerometro
axmed = median(acx);
aymed = median(acy);
azmed = median(acz);
%Medias do magnetometro
mgxmed = median(mgx);
mgymed = median(mgy);
mgzmed = median(mgz);
%Medias do giroscopio
grxmed = median(grx);
grymed = median(gry);
grzmed = median(grz);

%Desvios
%Acelerometro
dax = 0 - axmed;
day = 0 - aymed;
daz = 1 - azmed;
%Magnetometro
dmx = 1 - mgxmed;
dmy = 0 - mgymed;
dmz = 0 - mgzmed;
%Giroscopio
dgx = 0 - grxmed;
dgy = 0 - grymed;
dgz = 0 - grzmed;

%Valores calibrados
%Acelerometro
ACx = acx + dax;
ACy = acy + day;
ACz = acz + daz;
%Magnetometro
MGx = mgx + dmx;
MGy = mgy + dmy;
MGz = mgz + dmz;
%Giroscopio
GRx = grx + dgx;
GRy = gry + dgy;
GRz = grz + dgz;

time = ones(length(data),1);
for i = 1:1:length(data)
    if i == 1
        time(i, 1) = data(i,10);
    else
        time(i, 1) = data(i,10) + time(i-1,1);
    end
end

%Plots
%Acelerometro
figure(1)
plot(time, ACx, 'black');
hold on
plot(time, ACy, 'red');
plot(time, ACz, 'blue');
xlabel('Tempo')
ylabel('Aceleração (g)')
legend('X', 'Y', 'Z')
hold off

%Magnetometro
figure(2)
plot(time, MGx, 'black');
hold on
plot(time, MGy, 'red');
plot(time, MGz, 'blue');
xlabel('Tempo')
ylabel('Campo magnético (T)')
legend('X', 'Y', 'Z')
hold off

%Giroscopio
figure(3)
plot(time, GRx, 'black');
hold on
plot(time, GRy, 'red');
plot(time, GRz, 'blue');
ylim([-0.8 0.8]);
xlabel('Tempo')
ylabel('Velocidade de rotação')
legend('X', 'Y', 'Z')
hold off

%Ajuste dos vetores (Baseados no Giroscopio)
%Acelerometro
acelx = ACx;
acely = -ACy;
acelz = ACz;
%Magnetometro
magx = MGy;
magy = -MGx;
magz = MGz;
%Giroscopio
girox = GRx;
giroy = GRy;
giroz = GRz;

allVec = [acelx acely acelz magx magy magz girox giroy giroz time];

end

