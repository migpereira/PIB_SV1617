function minutiae_detection(filename)

binary_image = fingerprint_enhancement_morph(filename);
close all;

[r,c] = size(binary_image);

%Create larger image to fit square that identifies the minutiae
line = r+2;
col = c+2;
aux = zeros(line,col);
aux(2:(end-1),2:(end-1)) = binary_image(:,:);

minutiaeImg = zeros(line,col,3);
minutiaeImg(:,:,1) = aux .* 255;
minutiaeImg(:,:,2) = aux .* 255;
minutiaeImg(:,:,3) = aux .* 255;

minutiae = minutiae_extraction(r, c, aux);

% RIDGE END FINDING
[ridge_y, ridge_x] = find(minutiae==2);

[ridge_x, ridge_y] = remove_false_minutiae(ridge_x, ridge_y);

for i=1:length(ridge_x)
    minutiaeImg = insertShape(minutiaeImg,'circle',[ridge_x(i), ridge_y(i), 2],'LineWidth',2,'Color','black');
end

%BIFURCATION FINDING
[bifurcation_y, bifurcation_x] = find(minutiae==4);

[bifurcation_x, bifurcation_y] = remove_false_minutiae(bifurcation_x, bifurcation_y);

for i=1:length(bifurcation_x)
    minutiaeImg = insertShape(minutiaeImg,'circle',[bifurcation_x(i), bifurcation_y(i), 2],'LineWidth',2,'Color','red');
end

figure(1);
imshow(minutiaeImg); title(' Minutiae detection '); impixelinfo;
end

function minutiae = minutiae_extraction(line, col, auxImg)
    minutiae = zeros(line,col);
    
    %Mask to find minutiae
    mask = zeros(3,3);
    
    for x = 2 : line-1
        for y = 2 : col-1
            e=1;
            for k = x-1 : x+1
                f=1;
                for l = y-1 : y+1
                    mask(e,f)=auxImg(k,l);
                    f=f+1;
                end
                e=e+1;
            end
            if(mask(2,2)==0)
                minutiae(x,y) = sum(sum(~mask));
            end
        end
    end
end

function [xIndexs, yIndexs] = remove_false_minutiae(xIndexs, yIndexs)
    len=length(xIndexs);
    for i=1:len-2
        if(i>len-2) 
            break;
        end
        for l=1:len-2
            if(l>len-2)
                break;
            end
            if(i~=l)
                X = [xIndexs(i,1),yIndexs(i,1); xIndexs(l,1),yIndexs(l,1)];
                if(pdist(X,'euclidean')<2)
                    xIndexs(i) = [];
                    yIndexs(i) = [];
                    len=len-1;
                elseif(pdist(X,'euclidean')<6)
                    xIndexs(i) = [];
                    yIndexs(i) = [];
                    xIndexs(l-1) = [];
                    yIndexs(l-1) = [];
                    len=len-2;
                end
            end
        end
    end
end