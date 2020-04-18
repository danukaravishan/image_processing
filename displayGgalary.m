function  displayGgalary(faceDatabase)
    figure;
    for x=1:size(faceDatabase,2)
        for y = 1: faceDatabase(x).Count
            subplot(1,x,y);imshow(read(faceDatabase(x),y));
        end
    end    
end

