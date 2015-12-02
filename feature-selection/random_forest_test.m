
features_CM1 = [];
classLabels = [];

for i=1:1:size(data_CM1_train,1)
    for j=1:1:(size(data_CM1_train,2)-1)
        features_CM1(i,j) = data_CM1_train{i,j};
    end
end

for i=1:1:size(data_CM1_train,1)
    classLabels(i,1) = data_CM1_train{i,size(data_CM1_train,2)};
end


numTrees = 1000;

B = TreeBagger(numTrees, features_CM1, classLabels, 'Method', 'classification');

newData1 = [];

for i=1:1:size(data_CM1_validate,1)
    
    for j=1:1:(size(data_CM1,2)-1)
        newData1(i,j) = data_CM1_validate{i,j};
    end

end

%predChar1 = B.predict(newData1);
[label, score] = predict(B, newData1);

%predictedClass = str2double(predChar1);
% 
% [yfit, scores] = B.predict(newData1);
% 

[x,y,t,auc] = perfcurve(label, score(:,2), '1');


