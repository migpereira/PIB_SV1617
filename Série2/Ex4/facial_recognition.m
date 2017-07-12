function facial_recognition()
    errorImage = imread('forbidden.png');
    threshold = 9;
    % Load Image Information from ATT Face Database Directory
    faceDatabase = imageSet('ImagesDB','recursive');
    
    % Split Database into Training & Test Sets
    [training,test] = partition(faceDatabase,[0.8 0.2]);

    face = face_detector(read(training(1),1),0,0);
    [x,y,~] = size(face);
    
    trainingFeatures = zeros(size(training,2),11664);
    
    for i=1:size(training,2)
        trainingFeatures(i,:) = getFeaturesVector(training(i),x,y);
    end
    
    for person = 1:size(test,2)
        figure;
        figureNum = 1;
        for j = 1:test(person).Count
            queryImage = read(test(person),j);
            face = face_detector(queryImage,x,y);
            queryFeatures = extractHOGFeatures(face);
            
            [minVal,idx] = classifier(trainingFeatures, queryFeatures);
            
            subplot(2,2,figureNum);imshow(face);title('Query Face');
            if(minVal > threshold)
                subplot(2,2,figureNum+1);imshow(errorImage);title('No Match');
            else
                matchedFace = face_detector(read(training(idx),1),x,y);
                subplot(2,2,figureNum+1);imshow(matchedFace);title('Matched Class');
            end
            figureNum = figureNum+2;
        end
    end
end

function vector = getFeaturesVector(training, x, y)
    features = zeros(training(1).Count,11664);
    for i=1:training(1).Count
        face = face_detector(read(training(1),i),x,y);
        features(i,:) = extractHOGFeatures(face);
    end
    vector = mean(features);
end

function [minVal,idx] = classifier(trainingFeatures, queryFeatures)
    arrayAux = zeros(1,size(trainingFeatures,1)) ;
    for i=1:size(trainingFeatures,1)
        arrayAux(1,i) = sqrt(sum((trainingFeatures(i,:) - queryFeatures) .^ 2));
    end
    [minVal,idx] = min(arrayAux);
end
