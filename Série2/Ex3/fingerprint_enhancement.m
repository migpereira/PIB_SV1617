function [binaryImage] = fingerprint_enhancement(filename)

close all;
clc 

% Ler a imagem a partir do ficheiro.
I = imread(filename);

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
% Vers�o bin�ria.
level = graythresh(If);
binaryImage = im2bw(If, level);

figure(1); set(gcf,'Name', 'Bin�ria');
subplot(121); imshow(I); colorbar; title(' Imagem original' );
subplot(122); imshow(binaryImage); colorbar; title(' Imagem bin�ria' );
impixelinfo;

end