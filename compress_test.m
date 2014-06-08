function [cimage,cratio,mse,psnr] = compress_test(img, boxsize, threshold)
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
            [comprat,bpp]=wcompress('c',box,'/dev/shm/tmp2.wdr','spiht');
            %fprintf('comprat %f, bpp %f\n', comprat,bpp);
            wcompress('u','/dev/shm/tmp2.wdr');
            comp_ratio=comp_ratio+comprat;
        end
        cimage(r:r+boxsize-1,c:c+boxsize-1)=box(:,:);
        boxes=boxes+1;
    end
end 
cratio=comp_ratio/boxes;
mse=calc_mse(img,cimage);
psnr=calc_psnr(img,cimage);
end

function error=calc_mse(img1,img2)
error=sum((img1(:)-img2(:)).^2)/(size(img1,1)*size(img1,2));
end
function psnr=calc_psnr(img1,img2)
psnr=20*log10(255)-10*log10(calc_mse(img1,img2));
end