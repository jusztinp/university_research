function [vectors, labels] = own_extractLabelsAndFeatures(imgSets, featureLevel)

labels = cell(1);
allElementCount = numel(imgSets) * imgSets(1).Count;
featureLength= sum([0:1:featureLevel].^2); %sum of sequence x^2
disp(featureLength);
vectors = zeros(allElementCount,featureLength);

for i=1:numel(imgSets)
    tmpSet = imgSets(i);
    
    count = tmpSet.Count;
    for j=1:count
       img = read(tmpSet,j);
       imshow(img);
       features = own_getOwn(img,featureLevel);
       labels{j+(i-1)*count} = tmpSet.Description;
       vectors(j+(i-1)*count,:) = features;
       
    end
    
    
end

end