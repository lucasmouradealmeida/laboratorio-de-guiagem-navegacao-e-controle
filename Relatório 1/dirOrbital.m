%Função coordenadas orbitais
function [xo, yo, zo] = dirOrbital(theta, ex, semieixo)
    p = semieixo*(1 - ex^2);
    r = p/(1+ex*cos(theta));
    xo = r*cos(theta);
    yo = r*sin(theta);
    zo = 0;
end