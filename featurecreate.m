function feature=featurecreate(img1_dir,des_dir)

% img1_dir='F:\作业\计算机视觉作业\六维壁纸森林图片（统一格式）\';
% des_dir='F:\作业\程序\SIFT描述子\';
words_num=50;
img_path_list = dir(strcat(img1_dir,'*.jpg'));                    
img_num = length(img_path_list);
error=0;

for i = 1:img_num 
    image_name = img_path_list(i).name;% 图像名
    rgb = imread([img1_dir image_name]) ; 
    rgb=imresize(rgb, [240 320]); 
    try
       colorfeature = colorhist(rgb);
       colorfeature=colorfeature/max(colorfeature);
       save([des_dir,'color',num2str(i),'.mat'],'colorfeature');
%        fprintf('%d %s\n',i,strcat(img1_dir,image_name));
    catch
        error=error+1;
    end
end
color=load([des_dir,'color',num2str(1),'.mat']);
colorf=zeros(img_num,256);
colorf(1,:)=color.colorfeature;
for k=2:img_num
    color=load([des_dir,'color',num2str(k),'.mat']);
    colorf(k,:)=color.colorfeature;
end

dicdescrip=bagofwordsV2(img1_dir,des_dir,words_num);
feature=[dicdescrip,colorf];
save([des_dir,'feature.mat'],'feature');

