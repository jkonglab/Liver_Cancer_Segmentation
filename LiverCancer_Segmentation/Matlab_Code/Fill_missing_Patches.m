clear all; clc;


name1 = '01_01_0113.svs';

global filename
    global filename1
    global viablemask
    global test_label_matrix
    global k
    
    test_label_matrix = {};
    k = 1;
    tileSize = [512, 512];

    input_svs_page = 1;   %the page of the svs file we're interested in loading approx 10x
    input_svs_file =  strcat('/raid/data/home/matlab/Mousumi/Raw_Images/', name1);
    [~,baseFilename,~]=fileparts(input_svs_file);

    filename1 = strcat('/raid/data/home/matlab/Mousumi/viable_tumors/', strtok(name1,'.svs'),'_viable.tif'); %01_01_0103_viable.tif';
    viablemask = imread(filename1);
    viablemask(viablemask==1) = 255;
    viablemask = uint8(viablemask);
    viablemask = imbinarize(viablemask);
    %figure, imshow(viablemask);
    
    
    filename = baseFilename;
    %disp filename
    svs_adapter = PagedTiffAdapter(input_svs_file,input_svs_page); %create an adapter which modulates how the large svs file is accesse
    tic
    %fun =@(block)feature_extraction(block.data);
   
    % Non-overlapping
    blockproc(svs_adapter,tileSize,@fun)     
    toc 
 
    
    % Check if the 70% of teh image area is only background remove that patch,
    % generate the patch and write in disk
    
function fun(block_struct)
    
    global filename
    global filename1
    global viablemask
    global label_matrix


    a = block_struct.data;
      %check the ratio of total no of pixels in [512 * 512] image , to remove the background patches.     
    [row col dim] = size(a);
        patch_name = strcat('/raid/data/home/matlab/Mousumi/Prediction_Images_UNet/01_01_0113_resized/',sprintf('%s_%d_%d.tiff', filename, block_struct.location(1),block_struct.location(2)));
        if ~ exist(patch_name, 'file')
            new_image=zeros(row,col,1);
            
            imwrite(new_image,patch_name);
        end    
  
end
