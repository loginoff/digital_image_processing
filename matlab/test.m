lena_orig=imread('lena512.bmp');
[asi,ratio,mse,psnr]=compress_test(lena_orig, 32, 16);
%%
imshow(uint8(asi));
