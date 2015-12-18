
%% genetic algorithm

%clear all;

global iteration;

iteration = 0;

%data_initialize;

opts = gaoptimset('PopulationType', 'bitstring', 'Generations', 100, 'PopulationSize', 200, 'EliteCount', 50);

numberOfVariables = size(data_CM1,2)-1;
FitnessFunc = @fitnessFunction;

[x1, Fval, exitFlag, Output, Population] = ga(FitnessFunc,numberOfVariables,[],[],[],[],[],[],[],opts);




