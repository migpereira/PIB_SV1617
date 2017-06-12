function generic_intensity_transform(img)

close all;
clc 

% Ler a imagem a partir do ficheiro.
I = imread(img);

% Versão negativa da imagem - tabela de lookup.
LUT1 = uint8(255 : -1 : 0);

% Aplicar a tabela de lookup.
It = intlut(I, LUT1);
imwrite(It, 'img_transform.jpg');

a = {img; 'img_transform.jpg'};
image_details(a);

end