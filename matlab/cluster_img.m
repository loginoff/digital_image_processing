function [out_img] = cluster_img( img, nclusters )
input = double(reshape(img,size(img,1)*size(img,2),1));
[idx,c] = kmeans(input,nclusters, 'MaxIter',1000);
for i=1:size(idx,1)
    img(i)=c(idx(i));
end
out_img=img;
end

