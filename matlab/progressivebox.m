function [ cimage,cratio,mse,psnr ] = progressivebox( img, threshold )
%PROGRESSIVEWINDOW Summary of this function goes here
%   Detailed explanation goes here
[width, height] = size(img);
if width ~= height
    error('Image is not a square');
end
cimage = img;
boxsize=width/2;
fid=fopen('algorithm.log','w');
while boxsize > 2
    for r=1:boxsize:width
        for c=1:boxsize:height
            box=cimage(r:r+boxsize-1,c:c+boxsize-1);
            bmin=min(box(:));
            bmax=max(box(:));
            fprintf(fid,'boxsize: %d. min: %d, max: %d\n',boxsize,bmin,bmax);
            
            if (bmax-bmin) <= threshold
                fprintf(fid,'wtf: %d\n',boxsize);
                box(:,:)=bmin+(bmax-bmin)/2;
                %comp_ratio=comp_ratio+boxsize*boxsize;
            end
            cimage(r:r+boxsize-1,c:c+boxsize-1)=box(:,:);
        end
    end
    boxsize = boxsize/2;
end
fclose(fid);
cratio=0;
mse=0;
psnr=0;
end

