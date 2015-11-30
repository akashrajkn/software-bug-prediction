
%% genetic algorithm

opts = gaoptimset('PopulationType', 'bitstring');

numberOfVariables = 38;
FitnessFunc = @fitnessFunction;

[x, Fval, exitFlag, Output, Population] = ga(FitnessFunc,numberOfVariables,[],[],[],[],[],[],[],opts);





















