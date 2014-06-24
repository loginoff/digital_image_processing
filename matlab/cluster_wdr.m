function [ cimage,cratio,mse,psnr ] = cluster_wdr( img, nclusters)
cimage=cluster_img(img,nclusters);
[cratio,bpp]=wcompress('c',cimage,'/dev/shm/tmp2.wdr','wdr');
cimage=uint8(wcompress('u','/dev/shm/tmp2.wdr'));
delete('/dev/shm/tmp2.wdr');
[mse,psnr]=quantify(img,cimage);
end

