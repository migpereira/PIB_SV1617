function resolve_salt_and_pepper_noise()
close all;
clc

orig_img = imread('face1.bmp');
prob_img = imread('face1_1.bmp');
%prob_img = imread('face1_2.bmp');
%prob_img = imread('face1_3.bmp');
%prob_img = imread('face1_4.bmp');
%prob_img = imread('face1_5.bmp');

res_img = medfilt2(prob_img);

compare_images(orig_img, res_img);

figure(1);
subplot(131); imshow(orig_img); colorbar; title(' Imagem original ' );
subplot(132); imshow(prob_img); colorbar; title(' Imagem com problema ' );
subplot(133); imshow(res_img); colorbar; title(' Imagem restaurada ' );
impixelinfo;

end