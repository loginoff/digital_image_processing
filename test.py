__author__ = 'martinl'

import qccpack
import numpy as np


img=np.arange(4,dtype='double').reshape(2,2)
qccpack.test(img)
