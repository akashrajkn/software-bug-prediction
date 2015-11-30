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
    tf = strcmp(data_CM1{i,size(data_CM1,2)}, 'Y');
    
    if tf
        data_CM1{i,size(data_CM1,2)} = 1;
    else    
        data_CM1{i,size(data_CM1,2)} = 0;
    end
end

trainDataSize = ceil(size(data_CM1, 1)*0.7);

for i=1:1:trainDataSize+1
    for j=1:1:size(data_CM1,2)
        data_CM1_train{i,j} = data_CM1{i,j};
    end
end

for i=trainDataSize:1:size(data_CM1,1)
    for j=1:1:size(data_CM1,2)
        data_CM1_validate{i-trainDataSize+1,j} = data_CM1{i,j};
    end
end
    

