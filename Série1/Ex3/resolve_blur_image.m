function resolve_blur_image()
close all;
clc

orig_img = imread('finger1.bmp');
prob_img = imread('finger1_1.bmp');
%prob_img = imread('finger1_2.bmp');
%prob_img = imread('finger1_3.bmp');
%prob_img = imread('finger1_4.bmp');
%prob_img = imread('finger1_5.bmp');

laplacian = [ -1 -1 -1;
              -1 9 -1;
              -1 -1 -1];

res_img = filter2(laplacian, prob_img);

compare_images(orig_img, uint8(res_img));

figure(1);
subplot(131); imshow(orig_img); colorbar; title(' Imagem original ' );
subplot(132); imshow(prob_img); colorbar; title(' Imagem com problema ' );
subplot(133); imshow(uint8(res_img)); colorbar; title(' Imagem restaurada ' );
impixelinfo;

end