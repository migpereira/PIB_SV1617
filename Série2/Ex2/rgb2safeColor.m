function rgb2safeColor(img, safe)
    rgb = imread(img);
    info = imfinfo(img);
    [M, N, ~] = size(rgb);
    if(info.BitDepth ~= 24)
        fprintf(' Not RGB!!!!! \n');
        return;
    end
    
    safe_rgb = uint8(zeros(M,N,3));
    safe_array = [0,51,102,153,204,255];
    
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
    
    for i = 1:M
        for j = 1:N
            if(safe)
                safe_rgb(i,j,1) = safePixel(safe_array,rgb(i,j,1));
                safe_rgb(i,j,2) = safePixel(safe_array,rgb(i,j,2));
                safe_rgb(i,j,3) = safePixel(safe_array,rgb(i,j,3));
            else
                safe_rgb(i,j,:) = safestPixel(safest_colors,cat(2,rgb(i,j,1),rgb(i,j,2),rgb(i,j,3)));
            end
        end
    end
    figure(1);
    subplot(121); imshow(rgb); title(' RGB Image ' );
    subplot(122); imshow(safe_rgb); title(' Safe Color Image ' );
end

function [vectorout] = safestPixel(array, pixel)
    [m,~] = size(array);
    aux_array = zeros(m,1);
    for i = 1 : m
        aux_array(i) = norm(double(pixel)-array(i,:)); 
    end
    [~,I] = min(aux_array);
    vectorout = cat(3,array(I,1),array(I,2),array(I,3));
end

function [pixelout] = safePixel(array,pixel)
    [m,n] = size(array);
    aux_array = zeros(m,n);
    for i = 1 : n
       aux_array(i) = abs(pixel - array(i)); 
    end
    [~,I] = min(aux_array);
    pixelout = array(I);
end