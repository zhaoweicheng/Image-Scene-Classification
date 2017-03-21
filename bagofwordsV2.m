function dicdescrip=bagofwordsV2(img1_dir,des_dir,words_num)
% img1_dir是图像文件夹路径
% des_dir是图像描述子存储路径
% words_num是视觉词典的单词数，就是聚类的类中心数
% 输出dicdescrip是二维矩阵，行数是图像数，列数是视觉单词数，值是每个图像中每个视觉单词出现的次数
% 最后输出结果存为dicdescrip.mat，路径与描述子存储路径相同
%%
%这部分读取路径下所有图像,并求sift描述子

error=0;
patch_size=20;
grid_spacing=20;
% words_num=50;                                                      %聚类中心数量
% img1_dir='F:\作业\计算机视觉作业\六维壁纸森林图片（统一格式）\';
% des_dir='F:\作业\程序\SIFT描述子\';
img_path_list = dir(strcat(img1_dir,'*.jpg'));                      %获取该文件夹中所有jpg格式的图像
img_num = length(img_path_list);                                    %获取图像总数量
if img_num > 0 
   for j = 1:img_num 
       image_name = img_path_list(j).name;% 图像名
       I1=imreadbw([img1_dir image_name]) ;
%       I1_rgb = imread([img1_dir image_name]) ; 
       I1=imresize(I1, [240 320]);                             %统一图像大小
%       fprintf('%d %d %s\n',k,j,strcat(img1_dir,image_name));
       try
%        [frames1,descr1,gss1,dogss1 ] = do_sift( I1, 'Verbosity', 1, 'NumOctaves', 4, 'Threshold',  0.1/3/2 ) ;
         [sift_arr, grid_x, grid_y] = dense_sift(I1, patch_size, grid_spacing);
         save([des_dir,'sift',num2str(j),'.mat'],'sift_arr');
       catch
         error=error+1;
       continue
       end
    end
end

%%
%这一段用于构建视觉词典
descriptor=load([des_dir,'sift',num2str(1),'.mat']);
alldescrip=descriptor.sift_arr;
des_size=zeros(img_num);
des_size(1)=size(descriptor.sift_arr,2);
for k=2:img_num
    descriptor=load([des_dir,'sift',num2str(k),'.mat']);
    des_size(k)=size(descriptor.sift_arr,2);
    alldescrip=cat(2,alldescrip,descriptor.sift_arr);
end
alldescrip=alldescrip';
[idx,C]=kmeans(alldescrip,words_num);


%%
%这一段把图像用视觉词典表示
dicdescrip=zeros(img_num,words_num);
for k=1:length(idx)
    
    if k<=des_size(1)
       dicdescrip(1,idx(k))=dicdescrip(1,idx(k))+1;
    end
    
    for n=1:img_num-1
        if k<=sum(des_size(1:n+1))&&k>sum(des_size(1:n))
           dicdescrip(n+1,idx(k))=dicdescrip(n+1,idx(k))+1;
        end
    end
end
for m=1:img_num
    dicdescrip(m,:)=dicdescrip(m,:)/max(dicdescrip(m,:));
end
save([des_dir,'dicdescrip.mat'],'dicdescrip');
