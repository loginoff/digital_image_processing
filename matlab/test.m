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
[asi,ratio,mse,psnr]=boxthreshold(lena_orig,4,16);
fprintf('Boxthreshold, CRATIO: %f, MSE: %f, PSNR %f\n', ratio,mse,psnr);
%%
[cimg,ratio,mse,psnr]=progressivebox(lena_orig,16);
fprintf('Progressive, CRATIO: %f, MSE: %f, PSNR %f\n', ratio,mse,psnr);
%%
[cimg,ratio,mse,psnr]=perbox_wdr(lena_orig,32,16);
fprintf('Perbox WDR, CRATIO: %f, MSE: %f, PSNR %f\n', ratio,mse,psnr);
imshow(cimg);