# https://github.com/nsidc/NSIDC-Data-Tutorials/blob/main/notebooks/SnowEx_ASO_MODIS_Snow/Snow-tutorial.ipynb

import os
import geopandas as gpd
from shapely.geometry import Polygon, mapping
from shapely.geometry.polygon import orient
import pandas as pd 
import matplotlib.pyplot as plt
#import rasterio
#from rasterio.plot import show
import numpy as np
#import pyresample as prs
import requests
import json
import pprint
#from rasterio.mask import mask
from mpl_toolkits.axes_grid1 import make_axes_locatable


# This is our functions module. We created several helper functions to discover, access, and harmonize the data below.
# import tutorial_helper_functions as fn


polygon_filepath = str(os.getcwd() + '/Data/nsidc-polygon.json') # Note: A shapefile or other vector-based spatial data format could be substituted here.

gdf = gpd.read_file(polygon_filepath) #Return a GeoDataFrame object

# Simplify polygon for complex shapes in order to pass a reasonable request length to CMR. The larger the tolerance value, the more simplified the polygon.
# Orient counter-clockwise: CMR polygon points need to be provided in counter-clockwise order. The last point should match the first point to close the polygon.
poly = orient(gdf.simplify(0.05, preserve_topology=False).loc[0],sign=1.0)

#Format dictionary to polygon coordinate pairs for CMR polygon filtering
polygon = ','.join([str(c) for xy in zip(*poly.exterior.coords.xy) for c in xy])
print('Polygon coordinates to be used in search:', polygon)
poly


