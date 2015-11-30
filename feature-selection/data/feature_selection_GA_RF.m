
%% clean the data, convert everything into integers

% features array contains all the features
% rawdata_CM1 matrix contains the 

data_CM1 = {};
data_CM1_train = {};
data_CM1_validate = {};

for i=2:1:size(rawdata_CM1,1)
    for j=1:1:size(rawdata_CM1,2)
        data_CM1{i-1,j} = rawdata_CM1{i,j};
    end
end

for i=1:1:size(data_CM1,1)
    tf = strcmp(data_CM1{i,38}, 'Y');
    
    if tf
        data_CM1{i,38} = 1;
    else    
        data_CM1{i,38} = 0;
    end
end

for i=1:1:241
    for j=1:1:38
        data_CM1_train{i,j} = data_CM1{i,j};
    end
end

for i=242:1:size(data_CM1,1)
    for j=1:1:38
        data_CM1_validate{i-241,j} = data_CM1{i,j};
    end
end
    


%% genetic algorithm

opts = gaoptimset('PopulationType', 'bitstring');

numberOfVariables = 38;
FitnessFunc = @fitnessFunction;

[x, Fval, exitFlag, Output, Population] = ga(FitnessFunc,numberOfVariables,[],[],[],[],[],[],[],opts);





















