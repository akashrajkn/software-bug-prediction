%% clean the data, convert everything into integers

% features array contains all the features
% rawdata_CM1 matrix contains the 

%clear all

rawdata_CM1 = read_mixed_csv('CM1.csv', ',');

global data_CM1;
global data_CM1_train;
global data_CM1_validate;
global size_CM_train;
global size_CM_validate;
data_CM1 = cell(size(rawdata_CM1,1)-1, size(rawdata_CM1,2));

for i=2:1:size(rawdata_CM1,1)
    for j=1:1:size(rawdata_CM1,2)
        data_CM1{i-1,j} = rawdata_CM1{i,j};
    end
end

for i=1:1:size(data_CM1,1)
    for j=1:1:(size(data_CM1,2)-1)
        data_CM1{i,j} = str2double(data_CM1{i,j});
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

data_CM1_vector = cell2mat(data_CM1);

trainDataSize = ceil(size(data_CM1, 1)*0.7);

data_CM1_train = data_CM1_vector(1:trainDataSize, :);
data_CM1_validate = data_CM1_vector(trainDataSize+1:end, :);

size_CM_train = size(data_CM1_train);
size_CM_validate = size(data_CM1_validate);

