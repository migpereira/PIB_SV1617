function facial_recognition()
    % Load Image Information from ATT Face Database Directory
    faceDatabase = imageSet('ImagesDB','recursive');
    
    % Split Database into Training & Test Sets
    [training,test] = partition(faceDatabase,[0.8 0.2]);
    
    % Extract HOG Features for training set 
    trainingFeatures = zeros(size(training,2)*training(1).Count,4680);
    featureCount = 1;
    for i=1:size(training,2)
        for j = 1:training(i).Count
            trainingFeatures(featureCount,:) = extractHOGFeatures(read(training(i),j));
            trainingLabel{featureCount} = training(i).Description;    
            featureCount = featureCount + 1;
        end
        personIndex{i} = training(i).Description;
    end
    
    % Create 40 class classifier using fitcecoc 
    faceClassifier = fitcecoc(trainingFeatures, trainingLabel);
    
end