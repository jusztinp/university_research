function [vectors, labels] = greenhalgh_extractLabelsAndFeatures(imgSets)

labels = cell(1);
allElementCount = numel(imgSets) * imgSets(1).Count;

%%Region sizes
Rwidth = 128;
Rheight = 128;
%%Cell sizes
Mwidth = 8;
Mheight = 8;
%%Number of cells in a block
B = 4;
%%Number of pins on the histogram
H = 9;

featureLength= (Rwidth/Mwidth -1)*(Rheight/Mheight -1) * B * H;

disp(featureLength);
vectors = zeros(allElementCount,featureLength);

for i=1:numel(imgSets)
    tmpSet = imgSets(i);
    
    count = tmpSet.Count;
    for j=1:count
       img = read(tmpSet,j);
       normalized = greenhalgh_normalize(img);
       tmp = imresize(normalized, [Rwidth Rheight]);
       features = extractHOGFeatures(tmp, 'CellSize', [Mwidth Mheight],...
       'BlockSize', [sqrt(B) sqrt(B)], 'NumBins', H);
       labels{j+(i-1)*count} = tmpSet.Description;
       vectors(j+(i-1)*count,:) = features;
       
    end
    
    
end

end