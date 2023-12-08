# This script doesn't work that well

from PIL import Image
import os

# Get all file names
folder_path = 'data'
file_names = [f.split('.')[0] for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f))]

for file_name in file_names:
    img = Image.open(f'data/{file_name}.jpg')

    # Crop out name column
    # left, upper, right, lower
    name_crop_area = (100, 600, 910, 1000)
    cropped_img = img.crop(name_crop_area)
    cropped_img.save(f'data/cropped/{file_name}_name_cropped.jpg')

    # Crop out "by whom established" column
    establishment_crop_area = (910, 600, 1590, 1000)
    cropped_img = img.crop(establishment_crop_area)
    cropped_img.save(f'data/cropped/{file_name}_establishment_cropped.jpg')