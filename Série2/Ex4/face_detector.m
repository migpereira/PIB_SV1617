function face = face_detector(img)
    %To detect Face
    FDetect = vision.CascadeObjectDetector;

    %Read the input image
    I = imread(img);

    %Returns Bounding Box values based on number of objects
    BB = step(FDetect,I);
    
    for i = 1:size(BB,1)
        I = insertShape(I, 'rectangle',BB(i,:),'LineWidth',3,'Color','red');
    end
    imshow(I);
    
    for i = 1:size(BB,1)
        face = imcrop(I,BB(i,:));
    end
end