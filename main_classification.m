%本程序先提取特征而后分类
%img1-4_dir分别是四类图片的存储路径，des1-4_dir分别是四类图片的有关特征的存储路径
%每类图片路径下选取前trainnum张图片用作训练，然后紧接着testnum张用于测试


trainnum=500;
testnum=100;

img1_dir='F:\作业\计算机视觉作业\图片\fire\';
des1_dir='F:\作业\计算机视觉作业\图片\firefeature\';
fire=featurecreate(img1_dir,des1_dir);
FireLables=ones(trainnum+testnum,1);
save([des_dir,'FireLables.mat'],'FireLables');

img2_dir='F:\作业\计算机视觉作业\图片\forest\';
des2_dir='F:\作业\计算机视觉作业\图片\forestfeature\';
forest=featurecreate(img2_dir,des2_dir);
ForestLables=ones(trainnum+testnum,1)*2;
save([des_dir,'ForestLables.mat'],'ForestLables');

img3_dir='F:\作业\计算机视觉作业\图片\ocean\';
des3_dir='F:\作业\计算机视觉作业\图片\oceanfeature\';
ocean=featurecreate(img3_dir,des3_dir);
OceanLables=ones(trainnum+testnum,1)*3;
save([des_dir,'OceanLables.mat'],'OceanLables');

img4_dir='F:\作业\计算机视觉作业\图片\snow\';
des4_dir='F:\作业\计算机视觉作业\图片\snowfeature\';
snow=featurecreate(img4_dir,des4_dir);
SnowLables=ones(trainnum+testnum,1)*4;
save([des_dir,'SnowLables.mat'],'SnowLables');



imageproject(trainnum,testnum,fire,FireLables,forest,ForestLables,ocean,OceanLables,snow,SnowLables);

