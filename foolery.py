from PIL import Image
from kraken import pageseg
from kraken.binarization import nlbin
from kraken.lib import models

name = '772_22'
im = Image.open(f'data/cropped/{name}_name_cropped.jpg')

im_bin = nlbin(im)
seg = pageseg.segment(im_bin)
model = models.load_any('en_best.mlmodel')
result = models.recognize(im_bin, seg, model)

print(result)