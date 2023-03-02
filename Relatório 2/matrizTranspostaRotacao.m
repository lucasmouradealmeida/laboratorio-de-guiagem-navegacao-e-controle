%Função matriz de rotação transposta
function [Mt] = matrizTranspostaRotacao(i, w, O)
    
    R_x = [1 0 0; 0 cos(i) sin(i); 0 -sin(i) cos(i)];
    R_z0 = [cos(w) sin(w) 0; -sin(w) cos(w) 0; 0 0 1];
    R_zi = [cos(O) sin(O) 0; -sin(O) cos(O) 0; 0 0 1];
    
    M = R_z0 * R_x * R_zi;
    %Matriz transposta (Orbital para Inercial)
    Mt=M';
end

