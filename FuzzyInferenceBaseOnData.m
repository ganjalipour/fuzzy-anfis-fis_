clc;
clear;
close all;

% generate FIS from Data (grid partioning)
inputData = [rand(10,1) 10*rand(10,1)-5];
outputData = rand(10,1);

opt = genfisOptions('GridPartition');
opt.NumMembershipFunctions = [3 5];
opt.InputMembershipFunctionType = ["gaussmf" "trimf"];
ganjifis = genfis(inputData,outputData,opt);

showrule(ganjifis)

[x,mf] = plotmf(ganjifis,'input',1);
subplot(2,1,1)
plot(x,mf)
xlabel('input 1 (gaussmf)')
[x,mf] = plotmf(ganjifis,'input',2);
subplot(2,1,2)
plot(x,mf)
xlabel('input 2 (trimf)')

fis1 = genfis(inputData,outputData);

% generate FIS by FCM fuzzy c means mamdani

load clusterdemo.dat
inputData = clusterdemo(:,1:2);
outputData = clusterdemo(:,3);

ganjiFCMopt = genfisOptions('FCMClustering','FISType','mamdani');
ganjiFCMopt.NumClusters = 3;
ganjiFCMopt.Verbose = 0;
ganjiFCMFis = genfis(inputData,outputData,ganjiFCMopt);
showrule(ganjiFCMFis)

% generate FIS by FCM fuzzy c means sugeno

ganjiFCMSugenoopt = genfisOptions('FCMClustering','FISType','sugeno');
ganjiFCMSugenoopt.NumClusters = 3;
ganjiFCMSugenoopt.Verbose = 0;
ganjiFCMFisSugeno = genfis(inputData,outputData,ganjiFCMSugenoopt);
showrule(ganjiFCMFisSugeno)

MaxEpoch=100;
ErrorGoal=0;
InitialStepSize=0.01;
StepSizeDecreaseRate=0.9;
StepSizeIncreaseRate=1.1;
TrainOptions=[MaxEpoch ...
              ErrorGoal ...
              InitialStepSize ...
              StepSizeDecreaseRate ...
              StepSizeIncreaseRate];

DisplayInfo=true;
DisplayError=true;
DisplayStepSize=true;
DisplayFinalResult=true;
DisplayOptions=[DisplayInfo ...
                DisplayError ...
                DisplayStepSize ...
                DisplayFinalResult];

OptimizationMethod=1;
% 0: Backpropagation
% 1: Hybrid
TrainData = [inputData outputData];            
ganjiFCMFisSugenoAfterTraing = anfis(TrainData,ganjiFCMFisSugeno,TrainOptions,DisplayOptions,[],OptimizationMethod)






