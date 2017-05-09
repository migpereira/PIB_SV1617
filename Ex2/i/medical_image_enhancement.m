function medical_image_enhancement()

close all;
clc

% Ler a imagem a partir do ficheiro.
I = imread('CT1.jpg');
%I = imread('MR1.jpg');
%I = imread('PET1.tif');
%I = imread('US1.tif');
%I = imread('XRay1.tif');
%I = imread('XRay2.tif');

[~,~,i] = size(I);

if(i == 3) 
    I = rgb2gray(I);
end

% LoG.
LoG = fspecial('log', [3, 3], 0.25 );
Iop = filter2(LoG,I);

% Comparação dos resultados com a imagem original.
figure(1); set(gcf,'Name', 'Laplaciano of Gaussian');
subplot(221); imshow(I); colorbar; title(' Original ' );
subplot(222); imshow(uint8(Iop)); colorbar; title(' Laplaciano of Gaussian ' );
subplot(223); imhist(I); title(' Histograma Original ' );
subplot(224); imhist(uint8(Iop)); title(' Histograma Laplaciano of Gaussian ' );
impixelinfo;

% Soma de constante (Boost de brilho).
Iop= I+80;
figure(2); set(gcf,'Name', 'Soma de constante: I + 80');
subplot(221); imshow(I); colorbar; title(' Original ' );
subplot(222); imshow(Iop); colorbar; title(' Soma de constante: I + 80 ' );
subplot(223); imhist(I); title(' Histograma Original ' );
subplot(224); imhist(Iop); title(' Histograma Soma de constante: I + 80 ' );
impixelinfo;
 
% Equalização de histograma.
Iop= histeq(I);
figure(3); set(gcf,'Name', 'Equalização de histograma'); 
subplot(221); imshow(I); colorbar; title(' Imagem ' );
subplot(222); imshow(Iop); colorbar; title(' Equalização de histograma ' );
subplot(223); imhist(I); title(' Histograma Original ' );
subplot(224); imhist(Iop); title(' Histograma Equalização de histograma ' );
impixelinfo;

% Ajustar o contraste.
Iadj = imadjust(I);
figure(4); set(gcf,'Name', 'Ajuste de contraste');
subplot(221); imshow(I); colorbar; title(' Imagem ' );
subplot(222); imshow(Iadj); colorbar; title(' Ajuste de contraste ' );
subplot(223); imhist(I); title(' Histograma Original ' );
subplot(224); imhist(Iadj); title(' Histograma Ajuste de contraste ' );
impixelinfo;

end