function [Rtriad] = TRIAD(data, acelx, acely, acelz, magx, magy, magz, value)
%Triad Algoritmo

%Estudo do algoritmo
%Acelerometro - Referencial - Sun
%Magnetometro - Dados

%Inercial
An = zeros(length(data),3);
Mn = zeros(length(data), 3);

for i=1:length(data)
    An(i, 3) = 1;
    Mn(i, 2) = 1;
end
AMn = cross(An(value,:), Mn(value, :));

%Body
Ab = [acelx acely acelz];
Mb = [magx magy magz];
AMb = cross(Ab(value, :),Mb(value, :));

%Vetores Tb
T1b = Ab(value, :);
T2b = AMb/norm(AMb);
T3b = cross(T1b,T2b) / norm(cross(T1b,T2b));

%Vetores Tn
T1n = An(value,:);
T2n = AMn/norm(AMn);
T3n = cross(T1n, T2n)/norm(cross(T1n, T2n));

%Matriz Rotação
BT = [T1b; T2b; T3b];
NT = [T1n; T2n; T3n];

Rtriad = BT*(NT');

end

