import requests
import json
import urllib, json
import math
import datetime
#https://locator.aids.gov/data?lat=36.180774&long=-86.735863&distance=10
def main(lat,longi,distance):
    lat = str(lat)
    longi = str(longi)
    distance = str(distance)
    url = "https://locator.aids.gov/data?lat={}&long={}&distance={}".format(lat,longi, distance)
    response = urllib.urlopen(url)
    data = json.loads(response.read())
    print data

def testing():
    url = "https://locator.aids.gov/data?lat=36.180774&long=-86.735863"
    response = urllib.urlopen(url)
    data = json.loads(response.read())
    print data
# testing()
main(36.180774,-86.735863,10)
