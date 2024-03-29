# Liver Cancer Segmentation

Viable tumor segmentation in liver cancer histopathology Images.

Using Auto encoders to improve the liver cancer segmentation. Possibly as a submission to MICCAI 2019 challenge

This repository contains the network architectures, and the training and testing modules for segmentation of liver cancer images. Different architecture included
1. HistoCAE: our designed model
2. ResNet
3. UNet

First install the required packages provided in reqirements.txt file.

File Descriptions in ` ./LiverCancer_Segmentation/byClassification/HistoCAE/final_codes/`
* liverImages_main_10x_V3.py - contains code for reconstruction followed by classification, the dataset used is 10x resolution images.
* liverImages_main_10x_V3_MSESSIMMAEloss.py - the similar like abouve with reconstruction loss as custom loss function defined as joint loss of MSE + SSIM + MAE
* liverImages_main_bottleneck_withoutFlatten_MultiRes_FCV1.py - Multi resolution 10x, 20x an 5x dataset used for classification. FCV1 stans for the classifier architecture version1.

* batchTest.py - To generate the prediction image by using the trained model for batch of test data and prediction result save in disc.

To train the model HistoCAE model go to the path liver_cancer_project/LiverCancer_Segmentation/byClassification/HistoCAE/final_codes/

```
python liverImages_main_10x_V3.py
```

For Resnet go to the Resnet folder
- Put the images of training set into {PATH}/ResNet/train/{class_name}/
- If you have testing set, put it into {PATH}/ResNet/test/
- Modify the class name in resize.py

Execute the below command for Training
- Set parameters
- set number of layers for ResNet
- set loading pretrain weights of ImageNet or not
- set adding validation set into training set or not


```
python train.py --layers [50|101|152] --pretrain [0|1] --val [0|1]  
```
eg,
```
python train.py --pretrain 1 --val 1
```
For testing

```
python test.py --layers [50|101|152] --batch 1 --recover [0+]
```
eg,
```
python test.py --layers 101 --batch 1 --recover 50
```


For UNet:
training
```
python train.py --data_path ./datasets --checkpoint_path ./checkpoints/
```
testing
```
python eval.py --data_path ./datasets/test/ --load_from_checkpoint ./checkpoints/model-7049  --batch_size 1
```

## Reference

[Mousumi Roy, Jun Kong, Satyananda Kashyap, Vito Paolo Pastore, Fusheng Wang, Ken C. L. Wong, Vandana Mukherjee, “Convolutional autoencoder based model HistoCAE for segmentation of viable tumor regions in liver whole-slide images. Scientific Reports (11):139, 2021.](https://doi.org/10.1038/s41598-020-80610-9)

## License
This tool is available under the GNU General Public License (GPL) (https://www.gnu.org/licenses/gpl-3.0.en.html) and the LGPL (https://www.gnu.org/licenses/lgpl-3.0.en.html).

