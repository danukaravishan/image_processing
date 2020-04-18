clear all;
close all;
clc;
%load the information
faceDataBase = imageSet('face database','recursive');

% show set of images
% figure;
% img = faceDataBase(8).ImageLocation;
% 
% title('images of single face');

% split the database into training and testing

[training,testing] = partition(faceDataBase,[.8 .2]);
person = 5;
[hogFeature , visualization] = ...
    extractHOGFeatures(read(training(person),1));
% figure;
% subplot(2,1,1);imshow(read(training(person),1));title('input face');
% subplot(2,1,2);plot(visualization);title('HOG Feature');

% Extract all the features of trainig database
trainingFeatures = zeros(size(training,2)*training(1).Count,4680);
featureCount = 1;

for i = 1:size(training,2)
    for j=1:training(i).Count
        trainingFeatures(featureCount,:) = extractHOGFeatures(read(training(i),j));
        trainingLabel{featureCount} = training(i).Description; 
        featureCount = featureCount + 1;
    end
    personIndex{i} = training(i).Description; 
end
    
faceClassifier = fitcecoc(trainingFeatures,trainingLabel);

%check the detection for person 1
person = 3;
quaryImage = read(testing(person),1);
quaryFeatures = extractHOGFeatures(quaryImage);
personLabel = predict(faceClassifier,quaryFeatures);
booleanIndex = strcmp(personLabel,personIndex);
integerIindex = find(booleanIndex);
subplot(1,2,1);imshow(quaryImage);title('Quary Face');
subplot(1,2,2);imshow(read(training(integerIindex),1));title('Mmatched class');
















