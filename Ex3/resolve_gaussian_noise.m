function resolve_gaussian_noise()
close all;
clc

orig_img = imread('lena.gif');
prob_img = imread('lena_1.bmp');
%prob_img = imread('lena_2.bmp');
%prob_img = imread('lena_3.bmp');
%prob_img = imread('lena_4.bmp');
%prob_img = imread('lena_5.bmp');

res_img = imgaussfilt(prob_img, 1.5);

compare_images(orig_img, res_img);

figure(1);
subplot(131); imshow(orig_img); colorbar; title(' Imagem original ' );
subplot(132); imshow(prob_img); colorbar; title(' Imagem com problema ' );
subplot(133); imshow(res_img); colorbar; title(' Imagem restaurada ' );
impixelinfo;

end