function [m5dir, dirTxt] = findM5Dir(centroidFingers, centroidPalm)
deltaX = centroidFingers(1) - centroidPalm(1);
deltaY = centroidFingers(2) - centroidPalm(2);
angle = atan2d(deltaY, deltaX);
if abs(angle) <= 75
    m5dir = 0;
    dirTxt = 'move right';
elseif abs(angle) >= 105
    m5dir = 1;
    dirTxt = 'move left';
end