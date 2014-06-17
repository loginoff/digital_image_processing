function [ cimage,cratio,mse,psnr ] = perbox_wdr( img, boxsize, threshold )
%PERBOX_WDR Summary of this function goes here
%   Detailed explanation goes here
[width, height] = size(img);
if mod(width, boxsize) ~= 0 || mod(height,boxsize) ~= 0
    error('Image size not correctly divisible by boxsize');
end
cimage = zeros('like',img);
boxes=0;
comp_ratio=0.0;
for r = 1:boxsize:width
    for c = 1:boxsize:height
        box=img(r:r+boxsize-1,c:c+boxsize-1);
        bmin=min(box(:));
        bmax=max(box(:));

        if bmax-bmin <= threshold
            box(:,:)=bmin+(bmax-bmin)/2;
            comp_ratio=comp_ratio+boxsize*boxsize;
        else
            [comprat,bpp]=wcompress('c',box,'/dev/shm/tmp2.wdr','aswdr','level',4);
            %fprintf('comprat %f, bpp %f\n', comprat,bpp);
            box=wcompress('u','/dev/shm/tmp2.wdr');
            comp_ratio=comp_ratio+comprat;
        end
        cimage(r:r+boxsize-1,c:c+boxsize-1)=box(:,:);
        boxes=boxes+1;
    end
end 
cratio=comp_ratio/boxes;
[mse,psnr]=quantify(img,cimage);
end

