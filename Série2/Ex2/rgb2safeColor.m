function number_of_colors = rgb2safeColor(img, safe)
close all;

info = imfinfo(img);
if(info.BitDepth ~= 24)
    fprintf(' Not RGB!!!!! \n');
    return;
end

rgb = imread(img);
[M, N, ~] = size(rgb);

safe_rgb = uint8(zeros(M,N,3));

safe_colors = [0,51,102,153,204,255];
[~,s] = size(safe_colors);
safe_colors_aux = uint8(ones(s.^3,3));

safest_colors = [0 0 0; 
                 0 0 51; 
                 0 0 255; 
                 0 255 0; 
                 0 255 102; 
                 0 255 204; 
                 0 255 255;
                 51 255 51; 
                 51 255 102;
                 51 255 204; 
                 51 255 255; 
                 102 255 0; 
                 102 255 51; 
                 102 255 255;
                 204 255 102;
                 255 0 0; 
                 255 0 51; 
                 255 0 255; 
                 255 255 0; 
                 255 255 51; 
                 255 255 102; 
                 255 255 255];
safest_colors_aux = uint8(ones(size(safest_colors)));

number_of_colors = 0;

if(safe)
    img_title = ' Safe Color Image ';
    for i = 1:M
        for j = 1:N
            safe_rgb(i,j,1) = safePixel(safe_colors,rgb(i,j,1));
            safe_rgb(i,j,2) = safePixel(safe_colors,rgb(i,j,2));
            safe_rgb(i,j,3) = safePixel(safe_colors,rgb(i,j,3));

            [number_of_colors, safe_colors_aux] = update_number_of_colors(number_of_colors, safe_colors_aux, safe_rgb, i, j);
        end
    end
    fprintf('The safe image contain %d distinct colors.\n', number_of_colors);
else
    img_title = ' Safest Color Image ';
    for i = 1:M
        for j = 1:N
            safe_rgb(i,j,:) = safestPixel(safest_colors,cat(2,rgb(i,j,1),rgb(i,j,2),rgb(i,j,3)));

            [number_of_colors, safest_colors_aux] = update_number_of_colors(number_of_colors, safest_colors_aux, safe_rgb, i, j);
        end
    end
    fprintf('The safest image contain %d distinct colors.\n', number_of_colors);
end

figure(1);
subplot(121); imshow(rgb); title(' RGB Image ' );
subplot(122); imshow(safe_rgb); title(img_title);
end

function vectorout = safestPixel(array, pixel)
    [m,~] = size(array);
    aux_array = zeros(m,1);
    for i = 1 : m
        aux_array(i) = norm(double(pixel)-array(i,:)); 
    end
    [~,I] = min(aux_array);
    vectorout = cat(3,array(I,1),array(I,2),array(I,3));
end

function pixelout = safePixel(array,pixel)
    [m,n] = size(array);
    aux_array = zeros(m,n);
    for i = 1 : n
       aux_array(i) = abs(pixel - array(i)); 
    end
    [~,I] = min(aux_array);
    pixelout = array(I);
end

function [number_of_colors, array] = update_number_of_colors(number_of_colors, array, safe_rgb, r, c)
    idx = 1;
    [s,~] = size(array);
    while idx<s
        if(array(idx,1) == safe_rgb(r,c,1) && ...
            array(idx,2) == safe_rgb(r,c,2) && ...
            array(idx,3) == safe_rgb(r,c,3)) break;
        end
        idx = idx + 1;
    end
    if(idx == s) 
        array(number_of_colors+1,:) = safe_rgb(r,c,:);
        number_of_colors = number_of_colors + 1;
    end
end