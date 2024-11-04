clc
clear all
load('Data.mat')
%Data were obtained from adni.loni.usc.edu. 
% ------------------
paras.CaGPCA.lambda.u1 = 0.1; 
paras.CaGPCA.lambda.u2 = 0.01; 
paras.CaGPCA.lambda.u3 = 0.01; 
paras.CaGPCA.lambda.v1 = 0.01; 
paras.CaGPCA.lambda.v2 = 0.01; 
paras.CaGPCA.lambda.v3 = 0.01; 
paras.CaGPCA.lambda.v4 = 0.01; 
paras.CaGPCA.lambda.v5 = 0.01; 
paras.CaGPCA.lambda.w = 0.1;
%% Cross validation 
Kfold = 5;
[n, ~] = size(X);
indices = crossvalind('Kfold', n, Kfold);
disp('Begin cross validition ...');
disp('==============================');
for k = 1 : Kfold
    fprintf('current fold: %d\n', k);
    test = (indices == k); 
    train = ~test;
    % ---------- Training sets ----------
    trainData.X = getNormalization(X(train, :),'normalize');
    trainData.Y{1} = getNormalization(Y{1}(train, :),'normalize');
    trainData.Y{2} = getNormalization(Y{2}(train, :),'normalize');
    trainData.Y{3} = getNormalization(Y{3}(train, :),'normalize');
    trainData.Y{4} = getNormalization(Y{4}(train, :),'normalize');
    trainData.Y{5} = getNormalization(Y{5}(train, :),'normalize');
    trainData.z = getNormalization(z(train, :),'normalize');
    % ---------- Testing sets ----------
    testData.X = getNormalization(X(test, :),'normalize');
    testData.Y{1} = getNormalization(Y{1}(test, :),'normalize');
    testData.Y{2} = getNormalization(Y{2}(test, :),'normalize');
    testData.Y{3} = getNormalization(Y{3}(test, :),'normalize');
    testData.Y{4} = getNormalization(Y{4}(test, :),'normalize');
    testData.Y{5} = getNormalization(Y{5}(test, :),'normalize');
    testData.z = getNormalization(z(test, :),'normalize');
    % --------------- CaGPCA ---------------
    [U_CaGPCA{k}, V_CaGPCA{k}] = CaGPCA(trainData,paras.CaGPCA);    
end
disp('==============================');



