function [theta] = converter_anomalia_media_verdadeira(M , e)
    % Determinacao do valor inicial - anomalia excentrica
    if M < pi
        u0 = M + (e/2);
    else
        u0 = M - (e/2);
    end

    %declaracao de variaveis
    Erx = 100;
    u = 0;
    j = 1;

    %Segmentacao das conicas
    if e < 1 % equacao para elipse
        
        %Newton-Raphson
        while Erx >= 1e-8
            u = u0 - ((u0 - e*sin(u0) - M)/(1 - e*cos(u0)));
            Erx = abs((u0-u)/(u));
            u0 = u;
        end

        %Anomalia Verdadeira
        theta_0 = 2*atan((sqrt( ((1+e)/(1-e)))*tan(u0/2)));
                    
        % Conversão de valores
        u = rad2deg(u0);
        theta = rad2deg(theta_0);
        
        if(theta_0 < 0)
            theta = 360 + theta;
        end
        
                 
        %Caso as anomalias ultrapassem 360graus
        %Anomalia Excentrica (u)
        if u > 360 || u < -360
            u = u - (360*fix(u/360));
        end
        
        %Anomalia Verdadeira (Theta)
        if theta > 360 || theta < -360
            theta = theta - (360*fix(theta/360));
        end


    else % equacao para a hiperbole 
        while Erx >= 1e-8
            u = u0 - ((-u0 + e*sinh(u0) - M)/(e*cosh(u0) -1));
            Erx = abs((u0-u)/(u));
            u0 = u;
            j = j +1;
                    
        end

        %Anomalia Verdadeira
        teta0 = 2*atan((sqrt(((e+1)/(e-1))) * tanh(u/2)));
            
            
        % Conversao de valores
        u = rad2deg(u0);
        theta = rad2deg(teta0);
                
                
        %Caso as anomalias ultrapassem 360graus
        %Anomalia Excentrica (u)
        if u > 360 || u < -360
            u = u - (360*fix(u/360));
        end
        
        %Anomalia Verdadeira (Theta)
        if theta > 360 || theta < -360
            theta = theta - (360*fix(theta/360));
        end

    end

end