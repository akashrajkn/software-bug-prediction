function output_fitness_value = fitnessFunction( input_population )

    global data_CM1_train;
    global data_CM1_validate;
    global iteration;
    global size_CM_train;
    global size_CM_validate;
    
    iteration = iteration+1
    
    %preallocate the matrices
    features_subset = zeros(size_CM_train(1), sum(input_population));
    class_labels = zeros(size_CM_train(1),1);
    validation_data = zeros(size_CM_validate(1), sum(input_population));
    validate_class_labels = zeros(size_CM_validate(1),1);

    feature_count = 0;

    for i=1:1:size(input_population,2)
        if input_population(i) == 1 %ith feature is included in this population
            feature_count = feature_count +1;
            features_subset(:,feature_count) = data_CM1_train(:,i);
            validation_data(:,feature_count) = data_CM1_validate(:,i);

        end
    end
    
    class_labels(:,1) = data_CM1_train(:, size_CM_train(2));
    
    validate_class_labels(:,1) = data_CM1_validate(:, size_CM_validate(2));

    numTrees = 1000;
    
    B = TreeBagger(numTrees, features_subset, class_labels, 'Method', 'classification');
    
    [label, score] = predict(B, validation_data);
    
    [x,y,t,auc] = perfcurve(validate_class_labels, score(:, 2), '1');
    
    output_fitness_value = -auc;
    
end
