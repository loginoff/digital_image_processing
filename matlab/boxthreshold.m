function [ cimage,cratio,mse,psnr ] = boxthreshold( img, boxsize, threshold )
%BOXTHRESHOLD Summary of this function goes here
%   Detailed explanation goes here
[width, height] = size(img);
if mod(width, boxsize) ~= 0 || mod(height,boxsize) ~= 0
    error('Image size not correctly divisible by boxsize');
end
cimage = zeros('like',img);
boxes=0;
%comp_ratio=0.0;
for r = 1:boxsize:width
    for c = 1:boxsize:height
        box=img(r:r+boxsize-1,c:c+boxsize-1);
        bmin=min(box(:));
        bmax=max(box(:));

        if bmax-bmin <= threshold
            box(:,:)=bmin+(bmax-bmin)/2;
            %comp_ratio=comp_ratio+boxsize*boxsize;
        end
        cimage(r:r+boxsize-1,c:c+boxsize-1)=box(:,:);
    end
end
[cratio,bpp]=wcompress('c',cimage,'/dev/shm/tmp2.wdr','wdr');
cimage=uint8(wcompress('u','/dev/shm/tmp2.wdr'));
[mse,psnr]=quantify(img,cimage);
end

