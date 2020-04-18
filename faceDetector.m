function [resizedImage,notDetectedImage] = faceDetector(img)
    faceDetector = vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[105,105]);
    
    %constScalFactor = 200;    % scale factor of the output can control here
    imIn = img;
    
    if(size(img,3) ~= 1)
        img = rgb2gray(img);
    end
    
    bbox = step(faceDetector,img);
    
    if(isempty(bbox) == 0)
        imageDetected = insertShape(img,'rectangle',bbox,'lineWidth',5);
        croppedFace = imcrop(img,[bbox(1)-50 bbox(2)-50 bbox(3)+50 bbox(4)+50]);
        %scaleFactor = constScalFactor/size(croppedFace,1);
        resizedImage = imresize(croppedFace,[200 200]);  
        notDetectedImage = [0];
    else
        %imshow(imIn);
        resizedImage = [0];
        notDetectedImage = imIn;
    end
end

