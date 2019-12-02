function [dir, dirTxt] = findDir(centroidFingers, centroidPalm)
deltaX = mean(centroidFingers(:, 1)) - centroidPalm(1);
deltaY = mean(centroidFingers(:, 2)) - centroidPalm(2);
angle = atan2d(deltaY, deltaX);
if angle >= -165 && angle <= -15
    dir = 0;
    dirTxt = 'move up';
elseif angle >= 15 && angle <= 165
    dir = 1;
    dirTxt = 'move down';
end