function [degBeta, degGama, degAlfa] = triad_angle(triad)
    %barBB=Rtriad*Rtriad2';
    %ErrorPhiDeg = acos(0.5*(trace(barBB)-1))*180/pi;

    %Matriz XYZ
    beta = asin(triad(1,3));
    gama = asin(triad(1,2)/(-cos(beta)));
    alfa = acos(triad(3,3)/(cos(beta)));

    degBeta = beta;
    degGama = gama;
    degAlfa = alfa;

end

