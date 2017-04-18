function classifier = malik_trainClassifier(rootFolder)

imgSets = [ imageSet(fullfile(rootFolder, 'stop')), ...
            imageSet(fullfile(rootFolder, 'giveway'))...
          ];


disp('Labels:');
{imgSets.Description}
imgSetCounts = [imgSets.Count]
minSetCount = min(imgSetCounts);
imgSets = partition(imgSets, minSetCount, 'randomize');

[trainingSets, validationSets] = partition(imgSets, 0.3, 'randomize');

%Here we can add custom preprocessing
%featureExtractor = @malik_SURFFeatureExtractor;
%bag = bagOfFeatures(trainingSets, 'CustomExtractor', featureExtractor);

bag = bagOfFeatures(trainingSets);

classifier = trainImageCategoryClassifier(trainingSets, bag);

confusionMatrixOfTrainingSet = evaluate(classifier, trainingSets);
confusionMatrixOfValidationSet = evaluate(classifier, validationSets);

end