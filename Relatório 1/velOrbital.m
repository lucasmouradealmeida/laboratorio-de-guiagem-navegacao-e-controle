%Função velocidade orbital

function [vx, vy, vz] = velOrbital(n, ex, theta, semieixo)
    vx = -(n*semieixo/sqrt(1-ex^2))*sin(theta);
    vy = (n*semieixo/sqrt(1-ex^2))*(ex+cos(theta));
    vz = 0;
end