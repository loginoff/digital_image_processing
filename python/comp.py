#!/usr/bin/env python

import numpy as np
class CompressedImage:
    def __init__(self, img, box_size=16, threshold=10):
        width=img.shape[0]
        height=img.shape[1]
        if width % box_size != 0 or height % box_size != 0:
            raise Exception("Image not correctly divisible by box size")

        self.original_img = img
        self.box_size=box_size
        self.threshold=threshold

        #Here we just assume a grayscale image 8-bytes per pixel
        self.original_size=width*height*8
        self.compress()

    def compress(self):
        """
        The compression works by dividing the original image into squares
        with a side length of box_size. Each square is either represented
        by a single pixel value or the output of wavelet difference reduction
        """
        #The representation of our compressed image as a list of "boxes"
        img = []
        rows=self.original_img.shape[0]/self.box_size
        cols=self.original_img.shape[1]/self.box_size
        bs=self.box_size
        self.compressed_size=0

        for r in xrange(rows):
            for c in xrange(cols):
                box=self.original_img[r*bs:r*bs+bs,c*bs:c*bs+bs]
                max=np.max(box)
                min=np.min(box)
                if np.abs(max-min) < self.threshold:
                    img.append(min+(max-min)/2)
                    self.compressed_size+=8
                else:
                    img.append(box)
                    self.compressed_size+=bs**2*8

        self.img=img
        self.rows=rows
        self.cols=cols

    def reconstruct(self):
        rimage=np.zeros_like(self.original_img)
        bs=self.box_size
        rows=self.rows
        cols=self.cols
        for r in xrange(rows):
            for c in xrange(cols):
                box=self.img[r*cols+c]
                rimage[r*bs:r*bs+bs,c*bs:c*bs+bs]=box
        return rimage

    def showStats(self):
        rimage=self.reconstruct()
        print "MSE %f" % MSE(self.original_img,rimage)
        print "PSNR %f" % PSNR(self.original_img,rimage)
        print "Compression ratio %f" % (float(self.original_size)/float(self.compressed_size))


def PSNR(img1, img2):
    return 20*np.log10(255)-10*np.log10(MSE(img1,img2))

def MSE(img1, img2):
    return np.sum(np.sqrt(img1-img2))/(img1.shape[0]*img1.shape[1])

if __name__=='__main__':
    import scipy.misc
    lena_orig = scipy.misc.imread('lena512.bmp')
    img = CompressedImage(lena_orig)
    img.compress()
