import numpy as np
import sys
sys.path.append('/usr/local/lib/python3.7/site-packages')
import cv2

bgSubtractor = cv2.createBackgroundSubtractorMOG2(history=10, varThreshold=30, detectShadows=False)
