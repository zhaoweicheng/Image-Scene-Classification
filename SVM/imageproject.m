function imageproject(trainnum,testnum,fire,FireLables,forest,ForestLables,ocean,OceanLables,snow,SnowLables)

% 选定训练集和测试集
% load ocean
% load OceanLables
% load snow
% load SnowLabels
% load forest
% load ForestLables
% load fire
% load FireLables

% feature1=load('F:\作业\计算机视觉作业\图片\firefeature\dicdescrip.mat');
% feature2=load('F:\作业\计算机视觉作业\图片\forestfeature\dicdescrip.mat');
% feature3=load('F:\作业\计算机视觉作业\图片\oceanfeature\dicdescrip.mat');
% feature4=load('F:\作业\计算机视觉作业\图片\snowfeature\dicdescrip.mat');
% fire=feature1.dicdescrip;
% forest=feature2.dicdescrip;
% ocean=feature3.dicdescrip;
% snow=feature4.dicdescrip;
% 
% 
% trainnum=500;
% testnum=100;
% FireLables=ones(trainnum+testnum,1);
% ForestLables=ones(trainnum+testnum,1)*2;
% OceanLables=ones(trainnum+testnum,1)*3;
% SnowLables=ones(trainnum+testnum,1)*4;   





% train = [feature1(1:trainnum,:);feature2(1:trainnum,:);feature3(1:trainnum,:);feature4(1:trainnum,:)];
% % 相应的训练集的标签也要分离出来
% train_labels = [label1(1:trainnum);label1(1:trainnum);label1(1:trainnum);label1(1:trainnum)];
% 
% test = [feature1(trainnum+1:trainnum+testnum,:);feature2(trainnum+1:trainnum+testnum,:);feature3(trainnum+1:trainnum+testnum,:);feature4(trainnum+1:trainnum+testnum,:)];
% % 相应的测试集的标签也要分离出来
% test_labels = [label1(trainnum+1:trainnum+testnum);label2(trainnum+1:trainnum+testnum);label3(trainnum+1:trainnum+testnum);label4(trainnum+1:trainnum+testnum)];


train = [snow(1:trainnum,:);ocean(1:trainnum,:);forest(1:trainnum,:);fire(1:trainnum,:)];

train_labels = [SnowLables(1:trainnum);OceanLables(1:trainnum);ForestLables(1:trainnum);FireLables(1:trainnum)];

test = [snow(trainnum+1:trainnum+testnum,:);ocean(trainnum+1:trainnum+testnum,:);forest(trainnum+1:trainnum+testnum,:);fire(trainnum+1:trainnum+testnum,:)];

test_labels = [SnowLables(trainnum+1:trainnum+testnum);OceanLables(trainnum+1:trainnum+testnum);ForestLables(trainnum+1:trainnum+testnum);FireLables(trainnum+1:trainnum+testnum)];


%% 数据预处理
% 数据预处理,将训练集和测试集归一化到[0,1]区间

[mtrain,ntrain] = size(train);
[mtest,ntest] = size(test);

dataset = [train;test];
% mapminmax为MATLAB自带的归一化函数
[dataset_scale,ps] = mapminmax(dataset',0,1);
dataset_scale = dataset_scale';

train = dataset_scale(1:mtrain,:);
test = dataset_scale( (mtrain+1):(mtrain+mtest),: );
% 做交叉验证
% [bestacc,bestc,bestg] = SVMcgForClass(train_labels,train,-5,5,-5,5);
% [bestacc,bestc,bestg] = SVMcgForClass(train_labels,train,-2,4,-4,4,3,0.5,0.5,0.9);
% cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];

model = svmtrain(train_labels, train, '-c 2 -g 1 -q ');
% 将第一类的1-30,第二类的60-95,第三类的131-153做为训练集
% train_snow = train(1:500,:);
%  train_ocean = train(501:1000,:);
%  train_forest = train(1001:1500,:);
%  train_fire =train(1501:2000,:);
% train_1 = [train_snow;train_forest];
% train_2 = [train_snow;train_fire];
% train_3 = [train_snow;train_ocean];
% train_4 = [train_forest;train_fire];
% train_5 = [train_forest;train_ocean];
% train_6 = [train_fire;train_ocean];
% % % 相应的训练集的标签也要分离出来
% trainlabels_1 = [SnowLables(1:500);ForestLables(1:500)];
% trainlabels_2 = [SnowLables(1:500);FireLables(1:500)];
% trainlabels_3 = [SnowLables(1:500);OceanLables(1:500)];
% trainlabels_4 = [ForestLables(1:500);FireLables(1:500)];
% trainlabels_5 = [ForestLables(1:500);OceanLables(1:500)];
% trainlabels_6 =  [FireLables(1:500);OceanLables(1:500)];
% % 将第一类的31-59,第二类的96-130,第三类的154-178做为测试集
% test_snow = test(1:100,:);
% test_ocean = test(101:200,:);
% test_forest = test(201:300,:);
% test_fire = test(301:400,:);
% test_1 = [test_snow;test_forest];
% test_2 = [test_snow;test_fire];
% test_3 = [test_snow;test_ocean];
% test_4 = [test_forest;test_fire];
% test_5 = [test_forest;test_ocean];
% test_6 = [test_fire;test_ocean];
% % % 相应的测试集的标签也要分离出来
% testlabels_1 = [SnowLables(501:600);ForestLables(501:600)];
% testlabels_2 = [SnowLables(501:600);FireLables(501:600)];
% testlabels_3 = [SnowLables(501:600);OceanLables(501:600)];
% testlabels_4 = [ForestLables(501:600);FireLables(501:600)];
% testlabels_5 = [ForestLables(501:600);OceanLables(501:600)];
% testlabels_6 = [FireLables(501:600);OceanLables(501:600)];
% 

%% SVM网络训练
% model = svmtrain(train_labels, train, '-c 2 -g 1 ');
% model1 = svmtrain(trainlabels_1, train_1, '-c 2 -g 1 ');
% model2 = svmtrain(trainlabels_2, train_2, '-c 2 -g 1 ');
% model3 = svmtrain(trainlabels_3, train_3, '-c 2 -g 1 ');
% model4 = svmtrain(trainlabels_4, train_4, '-c 2 -g 1 ');
% model5 = svmtrain(trainlabels_5, train_5, '-c 2 -g 1 ');
% model6 = svmtrain(trainlabels_6, train_6, '-c 2 -g 1 ');
%% SVM网络预测
[predict_label, accuracy, decision_values] = svmpredict(test_labels,   test, model, '-b 0 ');
% [predict_label1, accuracy1, decision_values1] = svmpredict(test_labels,   test, model1,'-b 0');
% [predict_label2, accuracy2, decision_values2] = svmpredict(test_labels,  test, model2,'-b 0');
% [predict_label3, accuracy3, decision_values3] = svmpredict(test_labels, test, model3,'-b 0');
% [predict_label4, accuracy4, decision_values4] = svmpredict(test_labels,   test, model4,'-b 0');
% [predict_label5, accuracy5, decision_values5] = svmpredict(test_labels,   test, model5,'-b 0');
% [predict_label6, accuracy6, decision_values6] = svmpredict(test_labels,   test, model6,'-b 0');
%% SVM合并
% for x=1:400
%     a = predict_label3(x,1);
%     b = predict_label2(x,1);
%     c = predict_label4(x,1);
%     
% 
%     if a == 2
%     predict_label(x,1) =2;
% end
% if a==0 && b == 4
%     predict_label(x,1) =4;
% end
% if a==0 && b == 0 && c == 3
%     predict_label(x,1)=3;
% end
%     if a==0 && b ==0 && c==0
%         predict_label(x,1)=1;
%     end
% end 
% d = predict_label - test_labels;
% for k = 1:400
%     if d(k,1) == 0
%         d(k,1) = 0;
%     else
%         d(k,1) =1;
%     end
% end
%  n =sum(sum(d));
%  1-(n/400)
% sum(sum(predict_label1))
% 投票并计算正确率
% predict = [predict_label1,predict_label2,predict_label3,predict_label4,predict_label5,predict_label6];
% % a=0;
% % b=0;
% % c=0;
% % d=0;
% for i = 1:400
%  
% N1 = numel(find(predict(i,:)==1));
% N2 = numel(find(predict(i,:)==2));
% N3 = numel(find(predict(i,:)==3));
% N4 = numel(find(predict(i,:)==4));
% e = max([N1,N2,N3,N4]);
% if e == N1
%     data(i,1)=1;
% elseif e == N2
%     data(i,1)=2;
% elseif e == N3
%     data(i,1)=3;
% elseif e == N4
%     data(i,1)=4;
%     
% end
% end
% f=test_labels-data;
% for z=1:400
% if f(z,1)==0
%     f(z,1)=0;
% else
%     f(z,1)=1;
% end
% end
% n =sum(sum(f));
% 1-n/400
N1 = numel(find(predict_label(1:100,:)==4));
N2 = numel(find(predict_label(101:200,:)==3));
N3 = numel(find(predict_label(201:300,:)==2));
N4 = numel(find(predict_label(301:400,:)==1));

NSnow = numel(find(predict_label(:,1)==4));
NForest = numel(find(predict_label(:,1)==3));
NFire= numel(find(predict_label(:,1)==2));
NOcean = numel(find(predict_label(:,1)==1));

SnowRecall = N1/100;
ForestRecall = N3/100;
FireRecall = N4/100;
OceanRecall = N2/100;
SnowPrecision = N1/NSnow;
ForestPrecision = N3/NForest;
FirePrecision = N4/NFire;
OceanPrecision = N2/NOcean;
disp(['SnowRecall = ', num2str(SnowRecall)]);
disp(['ForestRecall = ', num2str(ForestRecall)]);
disp(['FireRecall = ', num2str(FireRecall)]);
disp(['OceanRecall = ', num2str(OceanRecall)]);
disp(['SnowPrecision = ', num2str(SnowPrecision)]);
disp(['ForestPrecision = ', num2str(ForestPrecision)]);
disp(['FirePrecision = ', num2str(FirePrecision)]);
disp(['OceanPrecision = ', num2str(OceanPrecision)]);


        
        


%% 结果分析

% 测试集的实际分类和预测分类图
% 通过图可以看出只有一个测试样本是被错分的
figure;
hold on;
plot(test_labels,'o');
plot(predict_label,'r*');
xlabel('测试集样本','FontSize',12);
ylabel('类别标签','FontSize',12);
legend('实际测试集分类','预测测试集分类');
title('测试集的实际分类和预测分类图','FontSize',12);
grid on;

