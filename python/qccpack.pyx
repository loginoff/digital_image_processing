cimport numpy as np
cdef extern from "libQccPack.h":
    ctypedef struct QccIMGImageComponent:
        int num_rows
        int num_cols
        double **image

    ctypedef struct QccBitBuffer:
        int type
        int bit_cnt
        int byte_cnt
        int bits_to_go

    ctypedef struct QccWAVWavelet:
        int implementation
        int boundary
    ctypedef char QccString[1200 + 1]
    ctypedef struct QccWAVPerceptualWeights

    int QccBitBufferInitialize(QccBitBuffer *bit_buffer)

    int QccIMGImageComponentInitialize(QccIMGImageComponent* image_component)
    int QccIMGImageComponentAlloc(QccIMGImageComponent* image_component)
    int QccIMGImageComponentPrint(const QccIMGImageComponent *image_component)
    int QccIMGImageComponentSetMaxMin(QccIMGImageComponent *image_component)

    int QccWAVWaveletInitialize(QccWAVWavelet *wavelet)
    int QccWAVWaveletAlloc(QccWAVWavelet *wavelet)
    void QccWAVWaveletFree(QccWAVWavelet *wavelet)
    int QccWAVWaveletPrint(const QccWAVWavelet *wavelet)
    int QccWAVWaveletCreate(QccWAVWavelet *wavelet, const QccString wavelet_filename, const QccString boundary)

    int QccWAVwdrEncode(const QccIMGImageComponent *image, const QccIMGImageComponent *mask, QccBitBuffer *buffer, int num_levels, const QccWAVWavelet *wavelet, const QccWAVPerceptualWeights *perceptual_weights, int target_bit_cnt)
    int QccWAVwdrDecodeHeader(QccBitBuffer *buffer, int *num_levels, int *num_rows, int *num_cols, double *image_mean, int *max_coefficient_bits)
    int QccWAVwdrDecode(QccBitBuffer *buffer, QccIMGImageComponent *image, const QccIMGImageComponent *mask, int num_levels, const QccWAVWavelet *wavelet, const QccWAVPerceptualWeights *perceptual_weights, double image_mean, int max_coefficient_bits, int target_bit_cnt)


cdef QccIMGImageComponent numpy_to_QccIMGImageComponent(np.ndarray[double, ndim=2,mode="c"] np_img):
    cdef QccIMGImageComponent img
    QccIMGImageComponentInitialize(&img)
    img.num_rows=np_img.shape[0]
    img.num_cols=np_img.shape[1]
    QccIMGImageComponentAlloc(&img)
    for i in xrange(img.num_rows):
        for j in xrange(img.num_cols):
            img.image[i][j]=np_img[i,j]
    QccIMGImageComponentSetMaxMin(&img)
    QccIMGImageComponentPrint(&img)
    return img

cdef QccWAVWavelet wave

cdef initialize_wavelet():
    QccWAVWaveletInitialize(&wave)
    #(either "symmetric", "periodic", or "boundary")
    QccWAVWaveletCreate(&wave,"Haar.fbk","periodic")
    # QccWAVWaveletPrint(&wave)

cdef compress(QccIMGImageComponent *img):
    QccBitBuffer outbuf
    QccBitBufferIni



def test(np.ndarray[double, ndim=2, mode="c"] np_img):
    img=numpy_to_QccIMGImageComponent(np_img)
    initialize_wavelet()

