function color()

close all;
clc

%img_original = 'CT1.jpg';
%img_transform = 'CT1_transform.jpg';
%img_original = 'MR1.jpg';
%img_transform = 'MR1_transform.jpg';
%img_original = 'PET1.tif';
%img_transform = 'PET1_transform.jpg';
%img_original = 'US1.tif';
%img_transform = 'US1_transform.jpg';
img_original = 'XRay1.tif';
img_transform = 'XRay1_transform.jpg';
%img_original = 'XRay2.tif';
%img_transform = 'XRay2_transform.jpg';

% Ler a imagem a partir do ficheiro.
    original = imread(img_original);
    transform = imread(img_transform);
    original = original(:,:,1);
    transform = transform(:,:,1);
    info = imfinfo(img_original);

    if(info.BitDepth == 1)
        original = 255 * uint8(original);
        transform = 255 * uint8(transform);
    end

    %To add more color, just add rows to the colorMap
    %           R    G     B
    colormap = [15   0  150;
                68 192 198;
                11 203 1;
                223 240 2;
                200 0 0];

    [number_of_colors,~] = size(colormap);

    [rows, columns] = size(original);

    original_slice = uint8(zeros(rows,columns,3));
    transform_slice = uint8(zeros(rows,columns,3));

    for i = 1 : rows
        for j = 1 : columns
            idx = fix(double(original(i,j))/(256/number_of_colors))+1;
            [original_slice(i,j,1)] = colormap(idx,1);
            [original_slice(i,j,2)] = colormap(idx,2);
            [original_slice(i,j,3)] = colormap(idx,3);
            
            idx = fix(double(transform(i,j))/(256/number_of_colors))+1;
            [transform_slice(i,j,1)] = colormap(idx,1);
            [transform_slice(i,j,2)] = colormap(idx,2);
            [transform_slice(i,j,3)] = colormap(idx,3);
        end
    end
            
figure(1);
subplot(221); imshow(original); title(' Original Monochromatic ' );
subplot(222); imshow(transform); title(' Transform Monochromatic ' );
subplot(223); imshow(original_slice); title(' Fake Colour Original ' );
subplot(224); imshow(transform_slice); title(' Fake Colour Transform ' );
impixelinfo;

end