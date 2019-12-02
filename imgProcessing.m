function [centroidX, centroidY, nickelBinaryImage, bounds, error] = imgProcessing(img)

% convert img to grayscale
originalImage = rgb2gray(img);
% Threshold the image to get a binary image
thresholdValue = 80;
binaryImage = originalImage > thresholdValue; % Bright objects will be chosen if you use >.
% Do a "hole fill" to get rid of any background pixels or "holes" inside the blobs.
binaryImage = imfill(binaryImage, 'holes');


% Identify individual blobs by seeing which pixels are connected to each other.
% Each group of connected pixels will be given a label, a number, to identify it and distinguish it from the other blobs.
% Do connected components labeling with either bwlabel() or bwconncomp().
labeledImage = bwlabel(binaryImage, 8);     % Label each blob so we can make measurements of it

% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
blobMeasurements = regionprops(labeledImage, originalImage, 'all');
numberOfBlobs = size(blobMeasurements, 1);

% bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
boundaries = bwboundaries(binaryImage);

blobECD = zeros(1, numberOfBlobs);
% Print header line in the command window.
%fprintf(1,'Blob #      Mean Intensity  Area   Perimeter    Centroid       Diameter\n');
% Loop over all blobs printing their measurements to the command window.
for k = 1 : numberOfBlobs           % Loop through all blobs.
    % Find the mean of each blob.  (R2008a has a better way where you can pass the original image
    % directly into regionprops.  The way below works for all versions including earlier versions.)
    thisBlobsPixels = blobMeasurements(k).PixelIdxList;  % Get list of pixels in current blob.
    meanGL = mean(originalImage(thisBlobsPixels)); % Find mean intensity (in original image!)
    meanGL2008a = blobMeasurements(k).MeanIntensity; % Mean again, but only for version >= R2008a
    
    blobArea = blobMeasurements(k).Area;		% Get area.
    blobPerimeter = blobMeasurements(k).Perimeter;		% Get perimeter.
    blobCentroid = blobMeasurements(k).Centroid;		% Get centroid one at a time
    blobECD(k) = sqrt(4 * blobArea / pi);					% Compute ECD - Equivalent Circular Diameter.
    %fprintf(1,'#%2d %17.1f %11.1f %8.1f %8.1f %8.1f % 8.1f\n', k, meanGL, blobArea, blobPerimeter, blobCentroid, blobECD(k));
end
allBlobCentroids = [blobMeasurements.Centroid];
centroidsX = allBlobCentroids(1:2:end-1);
centroidsY = allBlobCentroids(2:2:end);
allBlobAreas = [blobMeasurements.Area];
% Now let's get the nickels (the larger coin type).
keeperIndices = find(allBlobAreas > 10000);  % Take the larger objects.

if isempty(keeperIndices)
    error = 1;
    bounds = 0;
    centroidX = 0;
    centroidY = 0;
    nickelBinaryImage = originalImage;
else
    error = 0;
    % Note how we use ismember to select the blobs that meet our criteria.
    nickelBinaryImage = ismember(labeledImage, keeperIndices);
    bounds  = boundaries(keeperIndices);
    bounds = bounds{1,1};
    
    
    centroidX = centroidsX(keeperIndices);
    centroidY = centroidsY(keeperIndices);
end


