clear all;
close all;
clc

faceDatabase = imageSet('new','recursive');
faceNames = {faceDatabase.Description};
picCount = 0;  

for x = 1: size(faceDatabase,2)
    for y = 1:faceDatabase(x).Count
        picCount = picCount + 1; 
    end     
end

detectionCount = 0;

for x = 1:size(faceDatabase,2)
    for y = 1:faceDatabase(x).Count
        [img,notDetectedImages] = faceDetector((read(faceDatabase(x),y)));
        if(size(img,1) == 200 | size(img,1) == 201)
            detectionCount = detectionCount + 1;
        else 
            figure;
            imshow(notDetectedImages)
            title('not detected');
        end
    end
end

disp((detectionCount/picCount)*100)
