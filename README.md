# handOWI
Hand gesture controlled OWI robotic arm with Matlab

This program is designed for OWI-535 robotic arm edge. A webcam is used to capture live image.

Steps:

a. Image capturing with live camera feed.

b. Image processing:
  1. Hand detection: thresholding.
  2. Finger counting: imerode function in Matlab which uses simple morphology.
  3. Determining direction of the motor: use atan2d function to find the angle between the centroid of the palm and the centroid of the fingers.

c. Pass direction to arduino, control the movement


Demo video:
https://youtu.be/TgM2ST8WmoI?si=Lm3f2UdDPqu7qz89
