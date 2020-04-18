clear all;
close all;
clc
%% load the database
faceDatabase = imageSet('Training','recursive');
faceNames = {faceDatabase.Description};

%% get the pic count of the whole database
picCount = 0;  
for x = 1: size(faceDatabase,2)
    for y = 1:faceDatabase(x).Count
        picCount = picCount + 1; 
    end     
end

%% get the size of the feature vestor
img = faceDetector((read(faceDatabase(1),1)));
tempSize = size(extractHOGFeatures(img),2);

%% Extract the features of whole database
trainingFeatures = zeros(picCount,tempSize);
featureCount = 1;
for x = 1: size(faceDatabase,2)
    for y = 1:faceDatabase(x).Count
        img = faceDetector((read(faceDatabase(x),y)));
        keepFeature = extractHOGFeatures(img);
        
        if(size(keepFeature,2) == tempSize)
            trainingFeatures(featureCount,:) = keepFeature;
        else
            trainingFeatures(featureCount,:) = 0;
        end
        trainingLabel{featureCount} = faceDatabase(x).Description; 
        featureCount = featureCount + 1;
    end
    personIndex{x} = faceDatabase(x).Description; 
end

%% Machine Learinig Technique
faceClassifier = fitcecoc(trainingFeatures,trainingLabel);

testing = imageSet('testing 2','recursive');
for z = 1:12
    tempImage = read(testing(1),z);
    quaryImage = faceDetector(tempImage);
    quaryFeatures = extractHOGFeatures(quaryImage);
    personLabel = predict(faceClassifier,quaryFeatures);
    booleanIndex = strcmp(personLabel,personIndex);
    integerIindex = find(booleanIndex);
    figure;
    subplot(1,2,1);imshow(tempImage);title('Quary Face');
    subplot(1,2,2);imshow(read(faceDatabase(integerIindex),1));title('Matched class');
end




