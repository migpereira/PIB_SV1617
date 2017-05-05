function medical_image_enhancement()

% Fechar todas as janelas de figuras.
close all;

% Limpar a consola.
clc

% Fechar todas as janelas de figuras.
close all;

% Limpar a consola.
clc

% Ler a imagem a partir do ficheiro.
I = imread('CT1.jpg');
%I = imread('MR1.jpg');
%I = imread('PET1.tif');
%I = imread('US1.tif');
%I = imread('XRay1.tif');
%I = imread('XRay2.tif');

% LoG.
LoG = fspecial('log', [3, 3], 0.25 );
Iop = filter2(LoG,I);

% Comparação dos resultados com a imagem original.
figure(1); set(gcf,'Name', 'Laplaciano of Gaussian');
subplot(221); imshow(I); colorbar; title(' Original ' );
subplot(222); imshow(uint8(Iop)); colorbar; title(' Imagem 1' );
subplot(223); imhist(I); title(' Histograma da Imagem ' );
subplot(224); imhist(uint8(Iop)); title(' Histograma da Imagem 1' );
impixelinfo;

% Soma de constante (Boost de brilho).
Iop= I+80;
figure(2); set(gcf,'Name', 'Soma de constante: I + 80');
subplot(221); imshow(I); colorbar; title(' Original ' );
subplot(222); imshow(Iop); colorbar; title(' Imagem 2' );
subplot(223); imhist(I); title(' Histograma da Imagem ' );
subplot(224); imhist(Iop); title(' Histograma da Imagem 2' );
impixelinfo;
 
% Equalização de histograma.
Iop= histeq(I);
figure(3); set(gcf,'Name', 'Equalização de histograma'); 
subplot(221); imshow(I); colorbar; title(' Imagem ' );
subplot(222); imshow(Iop); colorbar; title(' Imagem 3' );
subplot(223); imhist(I); title(' Histograma da Imagem ' );
subplot(224); imhist(Iop); title(' Histograma da Imagem 3' );
impixelinfo;

% Ajustar o contraste.
Iadj = imadjust(I);
figure(4); set(gcf,'Name', 'Ajuste de contraste');
subplot(221); imshow(I); colorbar; title(' Imagem ' );
subplot(222); imshow(Iadj); colorbar; title(' Imagem 4' );
subplot(223); imhist(I); title(' Histograma da Imagem ' );
subplot(224); imhist(Iadj); title(' Histograma da Imagem 4' );
impixelinfo;

end