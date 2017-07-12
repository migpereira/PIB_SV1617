function face = face_detector(originalImg, x, y)
    %To detect Face
    FDetect = vision.CascadeObjectDetector;
    
    finalImg = originalImg;
    
    %Returns Bounding Box values based on number of objects
    BB = step(FDetect,originalImg);
    
    %If face not found, rotate image until find the face
    if(size(BB,1) == 0)
       for angle = 0:25:360
           finalImg = imrotate(originalImg,angle,'crop');
           %imshow(finalImg);
           BB = step(FDetect,finalImg);
           if(size(BB,1) ~= 0) 
               break;
           end
       end
    end
    
    for i = 1:size(BB,1)
        if(x == 0 && y == 0) face = imcrop(finalImg,BB(i,:));
        else face = imcrop(finalImg,[BB(i,1),BB(i,2),x, y]);
        end
    end
    
end