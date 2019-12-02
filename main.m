
% M1: 0 - close, 1 - open
% M2: 0 - up, 1 - down
% M3: 0 - up, 1 - down
% M4: 0 - up, 1 - down
% M5: 0 - clockwise - right (top view), 1 - counter clockwise - left

a = arduino;
% Camera snapshot

vid = videoinput('macvideo', 2);

for i = 1:10
    pause(0.5);
    img_flipped = getsnapshot(vid);
    img = ycbcr2rgb(flip(img_flipped, 2));
    % Image processing
    captionFontSize = 14;
    subplot(1, 2, 1);
    imshow(img);
    title('Original image', 'FontSize', captionFontSize)
    % Detect hand and mask hand
    [centroidX, centroidY, BW, bounds, error] = imgProcessing(img);
    if error == 1
        disp('No hand detected.');
        continue
    end
    subplot(1, 2, 2);
    imshow(BW);
    axis image;
    hold on;
    plot(bounds(:,2), bounds(:,1), 'g', 'LineWidth', 2)
    title('Updated binary image', 'FontSize', captionFontSize);
    
    % Determine number of fingers (convex hull functions?)
    [fingerCnt, centroidFingers, centroidPalm, error] = countFingers(BW);
    if error == 1
        disp('Please make sure palm is visible')
        continue
    end
    
    % Determine the direction of the motors
    switch fingerCnt
        case 0
            dir = 0;
            motorNum = 1;
            dirTxt = 'close gripper';
        case 1
            [dir, dirTxt] = findM5Dir(centroidFingers, centroidPalm);
            motorNum = 5;
        case 2
            [dir, dirTxt] = findDir(centroidFingers, centroidPalm);
            motorNum = 2;
        case 3
            [dir, dirTxt] = findDir(centroidFingers, centroidPalm);
            motorNum = 3;
        case 4
            [dir, dirTxt] = findDir(centroidFingers, centroidPalm);
            motorNum = 4;
        otherwise
            dir = 1;
            motorNum = 1;
            dirTxt = 'open gripper';
    end
   

%       
% M2 up - 2 fingers pointing up, down - 2 fingers pointing down
% M3 up - 3 fingers pointing up, down - 3 fingers pointing down
% M4 up - 4 fingers pointing up, down - 4 fingers pointing down
% M5 left - thumb pointing left, right - thumb pointing right
moveMotor(a, motorNum, dir);
pause(0.1);
stopMotor(a, motorNum);
end