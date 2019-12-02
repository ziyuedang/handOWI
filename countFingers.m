function [cnt, centroidFingers, centroidPalm, error] = countFingers(binaryImg)
se = strel('square',100);
%The fingers are smaller than the palm so we can "delete" them
%With simple morphology
BW2 = imerode(binaryImg, se);
%Reconstruct the palm (or a little bigger than the original)
palm = imdilate(BW2,se);
%If we subtract the "only palm" image from the original one we will get the fingers only
BW3 = imsubtract(binaryImg, palm);
%"noise" reduction
BW3 = bwareaopen(BW3,9000);
BW = BW3;

imshow(BW);

%Get the information about the contiguous areas

% Get centroid of the palm
stPalm = regionprops(palm);
if isempty(stPalm)
    error = 1;
    centroidPalm = 0;
else
    error = 0;
    centroidPalm = stPalm.Centroid;
end


% Get centroid of the fingers
st = regionprops(BW, 'All');
centroidFingers = zeros(length(st), 2);



for k = 1 : length(st)
    thisBB = st(k).BoundingBox;
    centroidFingers(k, :) = st(k).Centroid;
    hold on
    rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
      'EdgeColor','r','LineWidth',1 );
    hold off
end

%Sort the areas
allAreas = [st.Area];
[~, sortingIndexes] = sort(allAreas, 'descend');
cnt = length(st);
%Count the areas and label them on the binary image
for k = 1 : length(st)
    centerX = st(sortingIndexes(k)).Centroid(1);
    centerY = st(sortingIndexes(k)).Centroid(2);
    text(centerX,centerY,num2str(k),'Color', 'b', 'FontSize', 14)
end