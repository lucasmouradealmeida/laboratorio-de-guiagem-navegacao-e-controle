function [theta, phi, psi] = triad_angle(triad)
    %Matriz 123
    phi = asind(triad(3,1));
    psi = -asind(triad(3,2)/cosd(phi));
    theta = -asind(triad(2,1)/cosd(phi));

end

