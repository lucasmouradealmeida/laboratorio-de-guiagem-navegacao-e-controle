function [lat, long] = ground_track(Out,T,y,m,d)

    %Sistema de tempo
    UT = 0.7*24; %two lines
    J0 = 367*y - fix(((7*(y + (fix((m+9)/12))))/(4))) + fix(275*m/9) + d + 1721013.5  ;
    Dj = J0;
    Sj = (Dj - 2415020)/36525;
    thetag_0 = (((99.6909833 + 36000.7689*Sj + 0.00038708*Sj^2)/360) - fix((99.6909833 + 36000.7689*Sj + 0.00038708*Sj^2)/360)) * 360;
    theta_g = ((thetag_0 + 360.98564724*UT/24)/360 - fix((thetag_0 + 360.98564724*UT/24)/360) ) * 360;
    
    N = length(Out);
    w = 0.00007272; %rad/s
    delta_t = T/(N-1);
    thetag0 = deg2rad(theta_g);
    theta_long = ones(N,1);
    
    %Obtencao do theta para cada elemento
    for j=0:(N-1)
        theta_long(j+1,1) = thetag0 + j*w*delta_t;
    end
    
    r1 = Out(:,1);
    r2 = Out(:,2);
    r3 = Out(:,3);
    lat = rad2deg(asin(r3./(sqrt(r1.^2 + r2.^2 + r3.^2))));
    long = rad2deg(atan(r2./r1)) - rad2deg(theta_long);
    
    %Correção para a tangente
    for i=1:N
        if r1(i,1) < 0
            if long (i,1) < 0
                long(i,1) = (((long(i,1) - 180)/360) - fix(((long(i,1) - 180)/360))) *360;
            else
                long(i,1) = ((long(i,1) + 180)/360 - fix((long(i,1) + 180)/360)) *360 ;
            end
        end
    end
    
    figure
    worldmap('World')
    load coastlines.mat
    plotm(coastlat,coastlon)
    hold on
    
    %Plotar gráfico ground track
    plotm(lat,long,'LineWidth',2,'Color','r')
    hold off

end

