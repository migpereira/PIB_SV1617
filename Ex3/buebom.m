clc

I = imread('squares_1.bmp');
%I = imread('face1_2.bmp');
%I = imread('face1_3.bmp');
%I = imread('face1_4.bmp');
%I = imread('face1_5.bmp');

L1 = [ -1 -1 -1;
       -1 9 -1;
       -1 -1 -1];

L2 = [ 0 -1 0;
       -1 5 -1;
       0 -1 0];
   
edges = filter2(L1, I);
%I = medfilt2(I);
I = I + uint8(edges);
I = filter2(L2, I);


figure(1);
imshow(I);