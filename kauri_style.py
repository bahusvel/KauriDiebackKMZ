#!/sbin/python
import json
import sys

styles = {
    "Closed":"PEN(c:#FF0000)",
    "Closed Dieback": "PEN(c:#FF0000)",
    "Closed upgrade":"PEN(c:#FFFF00)",
    "Open":"PEN(c:#00FF00)",
    "Open pending closure": "PEN(c:#FFFF00)",
    "Open pending upgrade": "PEN(c:#FFFF00)",
    "Permanent": "PEN(c:#FF0000)",
    "Temp Closed": "PEN(c:#FFFF00)",
}

with open(sys.argv[1], 'r+') as gj_file:
    gj = json.load(gj_file)
    for feature in gj["features"]:
        feature["properties"]["OGR_STYLE"] = styles[feature["properties"]["STATUS"]]
    gj_file.truncate(0)
    gj_file.seek(0)
    json.dump(gj, gj_file)