#!/bin/bash

#GET 3 IMAGES TO MAKE A TRAIN CAR.
#IMAGES WILL BE PLACED SIDE BY SIDE TRAIN CAR DIMENSIONS ARE 450 BY 1700
#convert image1.jpg image2.jpg +append output.jpg
#SET IMAGE HEIGHT 450
#AND WIDTH 566 BE SURE TO CROP THE IMAGE

#CREATE AN ARRAY OF .JPG FILES
freightTags=(~/monikermikes/*.jpg)
images=()
count=0
imageIndex=0

applyEffects(){
	x=1
	
	for i in "${images[@]}"
	do
		echo "Zink Oxide"
		echo $i
		magick convert $i -resize x450 tmp$x.png
		echo $((x += 1))
	done
	
	magick convert tmp1.png tmp2.png tmp3.png +append output.png
	magick mogrify -resize 1700x -crop 1700x450+0+0 output.png
	magick convert output.png -edge .5 output1.png
	magick convert output1.png -transparent "#000000" final_tmp.png
	
	magick convert -composite sampleCar.png final_tmp.png \
	-geometry +55+30 freightCar$4.png
images=()

rm output.png output1.png final_tmp.png
}




while [ ${#freightTags[@]} -gt 3 ]; do
imageIndex=0
echo "There are  ${#freightTags[@]} images left..."
#EMPTY ARRAY TO HOLD TAG IMAGES USED TO BUILD THE FREIGHT CAR
for i in "${freightTags[@]}"
	
do
#ADD TO THE IMAGES ARRAY BUT REMOVE THE ITEMS FROM FREIGHTTAGS
images+=("${freightTags[$imageIndex]}")
#echo "${freightTags[$i]}"
delete=${freightTags[$imageIndex]}
freightTags=(${freightTags[@]/$delete})
#BREAK AT 3
if [ ${#images[@]} -eq 3 ];then
	
	echo "Apply Effects."
	echo $((count += 1))
	applyEffects "${images[0]}" "${images[1]}" "${images[2]}" $count
	break 1
fi
	echo $((imageIndex += 1))
done
	


done