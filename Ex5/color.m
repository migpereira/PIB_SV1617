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
colormap = [15   0  150;
            150 0 0;
            11 203 1;
            223 240 2];

%Lookup table to red component
lookupTable_red = zeros(256);
for i = 1:256
    if(i<26) lookupTable_red(i) = i;
    elseif(i<76) lookupTable_red(i) = i*2;
    elseif(i<141) lookupTable_red(i) = i;
    elseif(i<161) lookupTable_red(i) = i+8;
    else lookupTable_red(i) = i;
    end
end

%Lookup table to green component
lookupTable_green = zeros(256);
for i = 1:256
    if(i<26) lookupTable_green(i) = i;
    elseif(i<76) lookupTable_green(i) = i*2;
    elseif(i<141) lookupTable_green(i) = i*2;
    elseif(i<161) lookupTable_green(i) = i;
    else lookupTable_green(i) = 255;
    end
end

%Lookup table to blue component
lookupTable_blue = zeros(256);
for i = 1:256
    if(i<26) lookupTable_blue(i) = 255;
    elseif(i<76) lookupTable_blue(i) = i*2;
    elseif(i<141) lookupTable_blue(i) = i;
    elseif(i<161) lookupTable_blue(i) = i-10;
    else lookupTable_blue(i) = i;
    end
end

[number_of_colors,~] = size(colormap);

[rows, columns] = size(I);

resImage_slice = uint8(zeros(rows,columns,3));
resImage_rgbfunc = uint8(zeros(rows,columns,3));

for i = 1 : rows
    for j = 1 : columns
        idx = fix(double(I(i,j))/(256/number_of_colors))+1;
        [resImage_slice(i,j,1)] = colormap(idx,1);
        [resImage_slice(i,j,2)] = colormap(idx,2);
        [resImage_slice(i,j,3)] = colormap(idx,3);
       
        [resImage_rgbfunc(i,j,1)] = lookupTable_red(I(i,j)+1);
        [resImage_rgbfunc(i,j,2)] = lookupTable_green(I(i,j)+1);
        [resImage_rgbfunc(i,j,3)] = lookupTable_blue(I(i,j)+1);
    end
end
            
figure(1);
subplot(221); imshow(I); colorbar; title(' Original ' );
subplot(222); imhist(I); title(' Histogram of Original' );
subplot(223); imshow(resImage_slice); title(' Fake Colour Slice' );
subplot(224); imshow(resImage_rgbfunc); title(' Fake Colour RGB func' );
impixelinfo;

end