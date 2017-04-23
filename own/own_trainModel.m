function [classifier] = own_trainModel(rootFolder, featureLevel)

%featureLevel = 10;

imgSets = [ imageSet(fullfile(rootFolder, 'stop')), ...
            imageSet(fullfile(rootFolder, 'giveway')),...
            imageSet(fullfile(rootFolder, 'noentry'))...
          ];
      
disp('Labels:');
{imgSets.Description}
imgSetCounts = [imgSets.Count]
minSetCount = min(imgSetCounts);
imgSets = partition(imgSets, minSetCount, 'randomize');

[trainingSets, validationSets] = partition(imgSets, 0.6, 'randomize');

[vectors, labels] = own_extractLabelsAndFeatures(trainingSets, featureLevel);

classifier = fitcecoc(vectors, labels);

[vVectors, vLabels] = own_extractLabelsAndFeatures(validationSets, featureLevel);

pLabels = predict(classifier, vVectors);

confMat = confusionmat(vLabels, pLabels);

disp(['Confusion matrix: ']);
disp([confMat*100 / validationSets(1).Count]);

end