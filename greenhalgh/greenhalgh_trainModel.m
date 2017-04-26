function [classifier] = greenhalgh_trainModel(rootFolder)

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

[vectors, labels] = greenhalgh_extractLabelsAndFeatures(trainingSets);

classifier = fitcecoc(vectors, labels);

[vVectors, vLabels] = greenhalgh_extractLabelsAndFeatures(validationSets);

pLabels = predict(classifier, vVectors);

confMat = confusionmat(vLabels, pLabels);

disp(['Confusion matrix: ']);
disp([confMat*100 / validationSets(1).Count]);

end