function moveMotor(a, motorNum, dir)
% dir = 0 / dir = 1
if motorNum == 1
    voltage = 2;
    % motor 1 pins
    dir_pin1 = 'D26';
    dir_pin2 = 'D24';
    en = 'D2';
elseif motorNum == 2
    voltage = 4;
    % motor 2 pins
    en = 'D3';
    dir_pin1 = 'D28';
    dir_pin2 = 'D30';
elseif motorNum == 3
    voltage = 4;
    % motor 3 pins
    en = 'D4';
    dir_pin1 = 'D32';
    dir_pin2 = 'D34';
elseif motorNum == 4
    voltage = 4;
    % motor 4 pins
    en = 'D5';
    dir_pin1 = 'D38';
    dir_pin2 = 'D36';
elseif motorNum == 5
    voltage = 5;
    % motor 5 pins
    en = 'D6';
    dir_pin1 = 'D42';
    dir_pin2 = 'D40';
end

writeDigitalPin(a, dir_pin1, dir);
writeDigitalPin(a, dir_pin2, 1 - dir);
writePWMVoltage(a, en, voltage);
pause(0.01);