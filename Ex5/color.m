function color()

% Fechar todas as janelas de figuras.
close all;

% Limpar a consola.
clc

% Fechar todas as janelas de figuras.
close all;

% Limpar a consola.
clc

% Ler a imagem a partir do ficheiro.
I = imread('bird.gif');
%I = imread('MR1.jpg');
%I = imread('PET1.tif');
%I = imread('US1.tif');
%I = imread('XRay1.tif');
%I = imread('XRay2.tif');

map = colormap(hot);

rgb = ind2rgb(I,map);

R = rgb(:,:,1);
G = rgb(:,:,2);
B = rgb(:,:,3);

figure(1);
subplot(221); imshow(rgb); colorbar; title(' Original ' );
subplot(222); imshow(R); colorbar; title(' Imagem R' );
subplot(223); imshow(G); colorbar; title(' Imagem G' );
subplot(224); imshow(B); colorbar; title(' Imagem B' );

impixelinfo;

end