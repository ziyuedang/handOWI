function stopMotor(a,motorNum)
if motorNum == 1
    % motor 1 pins
    dir_pin1 = 'D26';
    dir_pin2 = 'D24';
    en = 'D2';
elseif motorNum == 2
    % motor 2 pins
    en = 'D3';
    dir_pin1 = 'D28';
    dir_pin2 = 'D30';
elseif motorNum == 3
    % motor 3 pins
    en = 'D4';
    dir_pin1 = 'D32';
    dir_pin2 = 'D34';
elseif motorNum == 4
    % motor 4 pins
    en = 'D5';
    dir_pin1 = 'D38';
    dir_pin2 = 'D36';
elseif motorNum == 5
    % motor 5 pins
    en = 'D6';
    dir_pin1 = 'D42';
    dir_pin2 = 'D40';
end
writeDigitalPin(a, dir_pin1, 0);
writeDigitalPin(a, dir_pin2, 0);
writePWMVoltage(a, en, 0);
pause(0.01);