%Dados do Grupo (Parado)
parado_grupo = importdata('dados.txt');
dados_parado_grupo = format_data(parado_grupo);

%Dados da professora (Parado)
parado_prof = importdata('parada.txt');
dados_parado_prof = format_data(parado_prof);

%Dado da professora (Movimento)
mov_prof = importdata('90yzx.txt');
dados_mov_prof = format_data(mov_prof);


%TRIAD

phi = zeros(length(mov_prof),4);

for i=1:length(mov_prof)

triad_mov_prof = TRIAD(mov_prof, dados_mov_prof(:,1), ...
    dados_mov_prof(:,2), dados_mov_prof(:,3), ...
    dados_mov_prof(:,4), dados_mov_prof(:,5), ...
    dados_mov_prof(:,6), i);

%Determina��o angular (TRIAD)
[phi(i,1), phi(i,2), phi(i,3)] = triad_angle(triad_mov_prof);

end

%plot - Varia��o do �ngulo no tempo
figure(5)
plot(dados_parado_grupo(:,10), phi(:,1))
hold on
plot(dados_parado_grupo(:,10), phi(:,2))
plot(dados_parado_grupo(:,10), phi(:,3))
hold off


%Integra��o por trap�zio
xi = dados_parado_grupo(:,10);

%giroz
yi = [dados_parado_grupo(:, 7) dados_parado_grupo(:, 8) dados_parado_grupo(:, 9)];

trapezio_angle = trapz(xi, yi);





















