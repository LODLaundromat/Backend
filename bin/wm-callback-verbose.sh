#!/bin/bash
hdtQueue="/scratch/lodlaundromat/tmp/hdtQueue.txt"
#touch /home/lodlaundromat/wm-callback.touch
[ -z "$1" ] && echo "No dataset provided as argument" && exit 1;
md5=`basename $1`
echo "Generating HDT file ($1)"
makeHdt $1

#queue hdt file for ldf update
echo $1 >> $hdtQueue;

#analyze directory
echo "Creating C-LOD file ($1)"
streamDataset $1
createModel $1
storeModel $1

echo "Notify users"
curl http://notify.lodlaundromat.d2s.labs.vu.nl/check?md5=$md5
exit 0;
