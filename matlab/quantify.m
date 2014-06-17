function [ mse, psnr ] = quantify( img1, img2 )
%QUANTIFY returns the Mean Square Error and Peak signal to noise ratio
%of the two input images
mse=sum(abs((img1(:)-img2(:))).^2)/(size(img1,1)*size(img1,2));
psnr=20*log10(255)-10*log10(mse);
end

