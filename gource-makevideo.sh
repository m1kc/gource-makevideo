#!/bin/bash
echo "gource-makevideo 1.0"
# devel:
#        -c 4
#        -s 0.1
if [ $1 == "--xvid" ]; then
	gource --highlight-users -s 0.25 -a 0.1 -1280x720 --output-ppm-stream - | \
		ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - \
		-vcodec libxvid \
		-mbd rd -flags +mv4+aic -trellis 2 -cmp 2 -subcmp 2 -g 300 \
		-vb 500k \
		gource.avi
elif [ $1 == "--mpeg4" ]; then
	gource --highlight-users -s 0.25 -a 0.1 -1280x720 --output-ppm-stream - | \
		ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - \
		-vcodec mpeg4 \
		-mbd rd -flags +mv4+aic -trellis 2 -cmp 2 -subcmp 2 -g 300 \
		-vb 500k \
		gource.avi
else
	gource --highlight-users -s 0.25 -a 0.1 -1280x720 --output-ppm-stream - | \
		ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - \
		-x264opts "subq=6:partitions=all:8x8dct:me=umh:frameref=5:bframes=3:b_pyramid=normal:weight_b:crf=19" \
		gource.mp4
fi
