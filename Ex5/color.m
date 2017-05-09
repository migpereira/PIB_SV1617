function color()

close all;
clc

%filename ='bird.gif';
%filename ='squares.gif';
%filename ='circles.bmp';
%filename ='weather.tif';
filename ='xray.tif';
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
colormap = [255   0  0;
            223 240  2;
            11 203  1;
            15 0   204];
        
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
subplot(222); imhist(I); title(' Histogram of Original' );
subplot(223); imshow(resImage_slice); title(' Fake Colour Slice' );
subplot(224); imshow(resImage_rgbfunc); title(' Fake Colour RGB func' );



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
             %   min max  value
   lookupTable = [0  25 0
                  26 75  62
                  76 140 18
                  141 160 236
                  161 255 255];
   pixel_out = get_from_lookup(pixel_in,lookupTable);
end

function [pixel_out] = get_g_color(pixel_in)
                % min max  value
    lookupTable = [0  25 0
                   26 75 59
                   76 140 90
                   141 160 251
                   161 255 255];
    pixel_out = get_from_lookup(pixel_in,lookupTable);
end

function [pixel_out] = get_b_color(pixel_in)
                 %   min max  value
   lookupTable = [0  25 255
                  26 75 14
                  76 140 35
                  141 160 37 
                  161 255 255];
    pixel_out = get_from_lookup(pixel_in,lookupTable);
end

function [pixel_out] = get_from_lookup(pixelIn,lookupTable)
   [lines,dummy] = size(lookupTable);
   for i = 1 : lines
        if(pixelIn >= lookupTable(i,1) && pixelIn <= lookupTable(i,2))
            pixel_out = lookupTable(i,3);
            break;
        end
   end
end