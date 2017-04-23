function [] = match_surfFeatures(img1, img2)

%img1 = imresize(img1,[128 128])
%img2 = imresize(img2,[128 128]);
bin1 = malik_preProcessing(img1);
bin2 = malik_preProcessing(img2);
surf1 = detectSURFFeatures(bin1);
surf2 = detectSURFFeatures(bin2);
surf1 = surf1.selectStrongest(60);
surf2 = surf2.selectStrongest(60);
[features1, valid1]=extractFeatures(bin1,surf1);
[features2, valid2]=extractFeatures(bin2,surf2);
indexPairs = matchFeatures(features1, features2);
matchedPoints1 = valid1(indexPairs(:,1),:);
matchedPoints2 = valid2(indexPairs(:,2),:);
figure; showMatchedFeatures(img1,img2,matchedPoints1,matchedPoints2);

end