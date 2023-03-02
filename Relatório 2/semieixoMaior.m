%Função semieixo maior
function [semieixo, n_segundo] = semieixoMaior (mi, n)
    n_segundo = (2*pi*n/86400);
    semieixo = (mi/(n_segundo^2))^(1/3);
end
