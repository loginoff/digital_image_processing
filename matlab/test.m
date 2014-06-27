lena_orig=imread('../lena512.bmp');
%%
%Let's compress the original image with plain WDR, this will be our
%baseline
[wdr_ratio,wdrbits]=wcompress('c',lena_orig,'test.wdr','wdr');
wdrimage=uint8(wcompress('u','test.wdr'));
delete('test.wdr');
[wdr_mse,wdr_psnr]=quantify(lena_orig,wdrimage);
fprintf('Regular WDR, CRATIO: %f, MSE: %f, PSNR %f\n', wdr_ratio,wdr_mse,wdr_psnr);
%%
for n=[2,4,8,16,32,64,128,256]
[asi,ratio,mse,psnr]=boxthreshold(lena_orig,n,16);
%fprintf('Boxthreshold n=%3d, CRATIO: %f, MSE: %f, PSNR %f\n', n,ratio,mse,psnr);
fprintf('%f \n',psnr);
end
%%
for n=1:32
[cimg,ratio,mse,psnr]=progressivebox(lena_orig,n);
%fprintf('Progressive, N=%d, CRATIO: %f, MSE: %f, PSNR %f\n', n,ratio,mse,psnr);
fprintf('%f\n',psnr);
end
%%
%for n=[2,4,8,16,32,64]
[cimg,ratio,mse,psnr]=perbox_wdr(lena_orig,128,16);
fprintf('Perbox WDR, CRATIO: %f, MSE: %f, PSNR %f\n', ratio,mse,psnr);
%imshow(cimg);
%end
%%
[cimg,ratio,mse,psnr]=cluster_wdr(lena_orig,2);
fprintf('Cluster WDR, CRATIO: %f, MSE: %f, PSNR %f\n', ratio,mse,psnr);
%%
imshow(img);
%%
[v,nr]=cluster_patch(lena_orig,8);
subplot(1,2,1);
imshow(v,[]);
subplot(1,2,2);
imshow(lena_orig);
