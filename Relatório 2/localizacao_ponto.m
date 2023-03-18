function [coord_inercial] = localizacao_ponto(latitude_geod, longitude_geod, H, y, m, d)

    %Sistema de tempo
    UT = (0.7486)*24; %two lines
    J0 = 367*y - fix(((7*(y + (fix((m+9)/12))))/(4))) + fix(275*m/9) + d + 1721013.5  ;
    Dj = J0;
    Sj = (Dj - 2415020)/36525;
    thetag_0 = (((99.6909833 + 36000.7689*Sj + 0.00038708*Sj^2)/360) - fix((99.6909833 + 36000.7689*Sj + 0.00038708*Sj^2)/360)) * 360;
    theta_g = ((thetag_0 + 360.98564724*UT/24)/360 - fix((thetag_0 + 360.98564724*UT/24)/360) ) * 360;
    
    r_pol = 6356.752; %Raio polar
    r_eq = 6378.137; %Raio equatorial
    
    [x, y, z]= ellipsoid(0,0,0, r_eq, r_eq, r_pol);
    
    figure
    body = surf(x,y,z);
    colormap(cool)
    axis equal
    hold on
    
    %Textura da terra no elipsoide (Necessaria uma conexao com a internet)
    texture_url = 'http://www.shadedrelief.com/natural3/images/earth_clouds.jpg';
    cdata = flip(imread(texture_url));
    set(body, 'FaceColor', 'texturemap', 'CData', cdata, 'EdgeColor', 'none');
    
    %Achatamento
    achat = (r_eq - r_pol)/r_eq;
    %Excentricidade
    e = sqrt(r_eq^2 - r_pol^2)/r_eq;
    
    %Sistema Terrestre (em funçao da latitude geodésica)
    
    xe = (((r_eq)/(sqrt(1-(e^2 * (sin(deg2rad(latitude_geod))^2)))) + H)) * cos(deg2rad(latitude_geod)) * cos(deg2rad(longitude_geod));
    ye = (((r_eq)/(sqrt(1-(e^2 * (sin(deg2rad(latitude_geod))^2)))) + H)) * cos(deg2rad(latitude_geod)) * sin(deg2rad(longitude_geod));
    ze = (((r_eq)/(sqrt(1-(e^2 * (sin(deg2rad(latitude_geod))^2))))*(1-e^2) + H)) * sin(deg2rad(latitude_geod));
    
    R_z = [cos(deg2rad(theta_g)) sin(deg2rad(theta_g)) 0; -sin(deg2rad(theta_g)) cos(deg2rad(theta_g)) 0; 0 0 1]';
    
    coord_inercial = R_z*[xe; ye; ze];
    
    %scatter3(coord_inercial(1,1),coord_inercial(2,1),coord_inercial(3,1),'filled','MarkerFaceColor',[1 0 0])
    scatter3(xe,ye,ze,'filled','MarkerFaceColor',[1 0 0])
    hold off
end

