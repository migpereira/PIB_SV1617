function color()

close all;
clc

%filename ='bird.gif';
%filename ='squares.gif';
%filename ='circles.bmp';
filename ='weather.tif';
%filename ='xray.tif';
%filename ='weld.tif';
%filename = 'eight_bw2.gif';
%filename = 'text.tif';

% Ler a imagem a partir do ficheiro.
I = imread(filename);
info = imfinfo(filename);

if(info.BitDepth == 1)
    I = 255 * uint8(I);
end
%To add more color, just add rows to the colorMap
%           R    G     B
colormap = [4   199  204;
            8   200  17;
            231 248  12;
            243 105  154;
            255 17   17];
        
[number_of_colors,~] = size(colormap);


[rows, columns] = size(I);

resImage_slice = uint8(zeros(rows,columns,3));
resImage_rgbfunc = uint8(zeros(rows,columns,3));


for i = 1 : rows
    for j = 1 : columns
       [resImage_slice(i,j,1)] = get_color(I(i,j),number_of_colors,colormap,'r');
       [resImage_slice(i,j,2)] = get_color(I(i,j),number_of_colors,colormap,'g');
       [resImage_slice(i,j,3)] = get_color(I(i,j),number_of_colors,colormap,'b');
       
       [resImage_rgbfunc(i,j,1)] = get_r_color(I(i,j));
       [resImage_rgbfunc(i,j,2)] = get_g_color(I(i,j));
       [resImage_rgbfunc(i,j,3)] = get_b_color(I(i,j));
    end
end
            
figure(1);
subplot(221); imshow(I); colorbar; title(' Original ' );
subplot(222); imshow(resImage_slice); title(' Fake Colour Slice' );
subplot(223); imshow(resImage_rgbfunc); title(' Fake Colour RGB func' );


impixelinfo;

end

function [pixel_out] = get_color(pixel_in,number_of_colors,colormap,color_comp)
    gap = 256/number_of_colors;
    for i = 1 : number_of_colors
        if(pixel_in <= gap*i)
           if(color_comp == 'r')
               pixel_out = colormap(i,1);
           elseif (color_comp == 'g')
               pixel_out = colormap(i,2);
           else
               pixel_out = colormap(i,3);
           end
           return;
        end
    end
end

function [pixel_out] = get_r_color(pixel_in)
   pixel_out = pixel_in * 2;
end

function [pixel_out] = get_g_color(pixel_in)
    pixel_out = pixel_in / 2;
end

function [pixel_out] = get_b_color(pixel_in)
    pixel_out = 255 - pixel_in ;
end