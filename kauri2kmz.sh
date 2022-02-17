#!/bin/bash

FEATURE_SERVER='https://services1.arcgis.com/n4yPwebTjJCmXB6W/ArcGIS/rest/services/TrackTrailCycleway/FeatureServer/0/'
QUERY="query?where=STATUS+<>+'NULL'&outFields=*&returnGeometry=true&resultOffset=OFFSET&f=pgeojson"

# rm -rf data || true
rm doc.kml out.json out.kmz || true
mkdir data || true

# for (( offset=0; ; offset+=2000 )) ; do 
#     curl $FEATURE_SERVER${QUERY/OFFSET/$offset} > data/$offset.json
#     if grep -q '"features" : \[\]' data/$offset.json; then
#         rm data/$offset.json
#         break
#     fi
# done

ogrmerge.py -single -o out.json data/*.json
./kauri_style.py out.json
ogr2ogr -f KML doc.kml out.json -dsco NameField=TRACKNAME
zip out.kmz doc.kml