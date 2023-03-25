function [dx] = edos30(t,x)
    dx = zeros(4,1);
    
    M = 1.1; %kg
    g_lunar = 1.8; %m/s2
    E = 3.6; %N - empuxo jato
    theta = 30;
    %Condicoes de contorno
    
    dx(1) = x(3);
    dx(2) = x(4);
    dx(3) = (E*sin(deg2rad(theta)))/M;
    dx(4) = (E*cos(deg2rad(theta))/M) - g_lunar;

end