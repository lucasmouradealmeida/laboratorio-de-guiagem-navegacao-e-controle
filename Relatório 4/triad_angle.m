function [ErrorPhiDeg] = triad_angle(Rtriad, Rtriad2)
    barBB=Rtriad*Rtriad2';
    ErrorPhiDeg = acos(0.5*(trace(barBB)-1))*180/pi;
end

