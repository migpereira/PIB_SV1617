function image_details(img)

% Fechar todas as janelas de figuras.
close all;

% Limpar a consola.
clc

for i=1:size(img)
    % Ler a imagem a partir do ficheiro.
    I = imread(img{i});
    % Obter informa��o da imagem.
    info = imfinfo(img{i});
    % Obter as dimens�es (resolu��o da imagem).
    [M, N] = size(I);

    fprintf('Spatial resolution = %d pixels\n', M*N);

    fprintf('Depth resolution = %d bit/pixel\n', info.BitDepth);

    if(info.BitDepth == 24) % Imagem RGB
        % Obter as componentes R, G, e B.
        R = I(:,:,1);
        G = I(:,:,2);
        B = I(:,:,3);

        fprintf(' -Red component details \n');
        image_detail(R,1,'Component Red');
        fprintf(' -Green component details \n');
        image_detail(G,2,'Component Green');
        fprintf(' -Blue component details \n');
        image_detail(B,3,'Component Blue');
    else
        image_detail(I,i,'Image');
    end
end
end

function image_detail(I,f, t)
% Lan�ar nova janela de figura e mostrar a imagem em n�veis de cinzento
% e o respetivo histograma.
figure(f);
subplot(121); imshow(I); title(t);
subplot(122); imhist(I); title(' Histogram ' );
impixelinfo;

% Calcular o valor m�nimo e valor m�ximo da imagem.
mi  = min(min(I));
avg = mean(mean(I));
mx = max(max(I));
fprintf('Intensity: Min = %d, Max = %d, AVG = %d \n', mi, mx, avg);

%Calcular a entropia da imagem.
e = entropy(I);

fprintf('Entropy = %d \n', e);

%Calcular medida de contraste
cme = 20 * log10(double((mx+1)/(mi+1)));

fprintf('Constrast Measure = %d \n', cme);
end