lena_orig=imread('../lena512.bmp');
[asi,ratio,mse,psnr]=perbox_wdr(lena_orig, 32, 10);
%%
[asi,ratio,mse,psnr]=boxthreshold(lena_orig,64,16);
imshow(uint8(asi));

%%
img=progressivebox(lena_orig,16);

imshow(img);

