%Dados do Grupo (Parado)
parado_grupo = importdata('dados.txt');
dados_parado_grupo = format_data(parado_grupo);

triad_parado_grupo = TRIAD(parado_grupo, dados_parado_grupo(:,1), ...
    dados_parado_grupo(:,2), dados_parado_grupo(:,3), ...
    dados_parado_grupo(:,4), dados_parado_grupo(:,5), ...
    dados_parado_grupo(:,6), 1);

%Dados da professora (Parado)
parado_prof = importdata('parada.txt');
dados_parado_prof = format_data(parado_prof);

%Dado da professora (Movimento)
mov_prof = importdata('90yzx.txt');
dados_mov_prof = format_data(mov_prof);

triad_mov_prof = TRIAD(mov_prof, dados_mov_prof(:,1), ...
    dados_mov_prof(:,2), dados_mov_prof(:,3), ...
    dados_mov_prof(:,4), dados_mov_prof(:,5), ...
    dados_mov_prof(:,6), 1);

%Determinação angular (TRIAD)
phi = triad_angle(triad_parado_grupo, triad_mov_prof);



















