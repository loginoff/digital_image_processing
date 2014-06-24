function [ cimage,cratio,mse,psnr ] = cluster_wdr( img, threshold)
cimage=cluster_patch(img,threshold);
[cratio,bpp]=wcompress('c',cimage,'/dev/shm/tmp2.wdr','wdr');
cimage=uint8(wcompress('u','/dev/shm/tmp2.wdr'));
delete('/dev/shm/tmp2.wdr');
[mse,psnr]=quantify(img,cimage);
end

