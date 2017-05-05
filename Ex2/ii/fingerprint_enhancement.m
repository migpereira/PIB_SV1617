function fingerprint_enhancement()

% Fechar todas as janelas de figuras.
close all;

% Limpar a consola.
clc 

% Ler a imagem a partir do ficheiro.
%I = imread('finger1.tif');
%I = imread('finger2.tif');
%I = imread('finger3.tif');
I = imread('finger4.tif');
%I = imread('finger5.bmp');

filter=[0 -1 -1 -1 -1 -1 0;
        -1 0 -1 -1 -1 0 -1;
        -1 -1 0 -1 0 -1 -1;
        -1 -1 -1 36 -1 -1 -1;
        -1 -1 0 -1 0 -1 -1;
        -1 0 -1 -1 -1 0 -1;
        0 -1 -1 -1 -1 -1 0;];
If = filter2(filter,I);
If = I + uint8(If);
If = medfilt2(If);
% Versão binária.
level = graythresh(If);
IBW = im2bw(If, level);

figure(1); set(gcf,'Name', 'Binária');
subplot(121); imshow(I); colorbar; title(' Imagem original' );
subplot(122); imshow(IBW); colorbar; title(' Imagem binária' );
impixelinfo;

end