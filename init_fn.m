function init_fn()
clear all
MAX_TORQUE_REVERSE = 40;
MAX_TORQUE = 80;
assignin ('base', 'm', 1600) %kg
assignin ('base', 'r', 0.30) %m
assignin ('base', 'v0', 0) %km/h

assignin ('base', 'MAX_SPEED_FORWARD', 240) %km/h
assignin ('base', 'MAX_SPEED_BACKWARD', 60) %km/h

assignin ('base', 'MAX_TORQUE_REVERSE', 40) %Nm
assignin ('base', 'MAX_TORQUE', 80) %Nm
assignin ('base', 'TRANSMISSION_RATIO', 12)
assignin ('base','MAX_RDB_ENGAGE_SPEED', 0.5) %km/h

assignin ('base', 'S', 3.5) %m^2
assignin ('base', 'rho', 1.25) %kg/m^3
assignin ('base', 'c_x', 0.3)
S = evalin('base', 'S');
rho = evalin ('base', 'rho');
c_x = evalin ('base', 'c_x');
assignin ('base','X_air', S*rho*c_x/2) % Ns/m 
X_air = evalin('base', 'X_air'); 
assignin ('base', 'X_tyres', X_air*50/3.6) %Ns^2/m^2

% Define the elements of the bus
elems(1) = Simulink.BusElement;
elems(1).Name = 's1';
elems(1).Dimensions = 1;
elems(1).DataType = 'double'; % Adjust the data type as necessary

elems(2) = Simulink.BusElement;
elems(2).Name = 's2';
elems(2).Dimensions = 1;
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 's3';
elems(3).Dimensions = 1;
elems(3).DataType = 'double';

% Create the bus object
sensorsBus = Simulink.Bus;
sensorsBus.Elements = elems;

% Define the elements of the bus
SGelems(1) = Simulink.BusElement;
SGelems(1).Name = 'SG1';
SGelems(1).Dimensions = 1;
SGelems(1).DataType = 'double'; % Adjust the data type as necessary

SGelems(2) = Simulink.BusElement;
SGelems(2).Name = 'SG2';
SGelems(2).Dimensions = 1;
SGelems(2).DataType = 'double';

SGelems(3) = Simulink.BusElement;
SGelems(3).Name = 'SG3';
SGelems(3).Dimensions = 1;
SGelems(3).DataType = 'double';

% Create the bus object
SGBus = Simulink.Bus;
SGBus.Elements = SGelems;

% Save the bus object to the MATLAB base workspace
assignin('base', 'SGBus', SGBus);


% Save the bus object to the MATLAB base workspace
assignin('base', 'sensorsBus', sensorsBus);

% Setting UP integration test 
% Test SG1 and 2
% Define time instants and corresponding signal values
% Initialize output vector with zeros
S3 = zeros(1, 100);
% Define segments and their values
segments = [
    0,  10,  0;  % 0 from 0 to 10 seconds
    10, 17,  2;  % 2 from 10 to 17 seconds
    17, 30,  0;  % 0 from 17 to 30 seconds
    30, 35,  2;  % 2 from 30 to 35 seconds
    35, 60,  0;  % 0 from 35 to 60 seconds
    60, 75,  2;  % 2 from 60 to 75 seconds
    75, 100, 0   % 0 from 75 to 100 seconds
];

% Loop through segments and assign values to signalVector
for i = 1:size(segments, 1)
    startIndex = segments(i, 1) + 1;  % Adjust index (starting from 1)
    endIndex = segments(i, 2);
    value = segments(i, 3);
    S3(startIndex:endIndex) = value;
end
% Assign to base workspace (if needed)
assignin('base', 'S3', S3);  % Assign S3 to base workspace
% Initialize output vector with zeros
S2 = zeros(1, 100);

% Define time and output values
timeValues = [0 10 15 30 35];
outputValues = [0 1 0 1 0];

% Iterate through time intervals and assign output values
for i = 1:length(timeValues)-1
    startIdx = timeValues(i) + 1;  % Adjust index (starting from 1)
    endIdx = timeValues(i+1);
    S2(startIdx:endIdx) = outputValues(i);
end
assignin('base', 'S2', S2);  % Assign S3 to base workspace
% Test SG3

% Initialize output vectors with zeros
S2_SG3 = zeros(1, 100);
S3_SG3 = zeros(1, 100);

% Define ranges and values for S2_SG3
ranges_S2 = [10 25; 30 40];
value_S2 = 1;

% Define range and value for S3_SG3
range_S3 = [30 40];
value_S3 = 2;

% Set values for S2_SG3
for i = 1:size(ranges_S2, 1)
    startIdx = ranges_S2(i, 1) + 1;  % Adjust index (starting from 1)
    endIdx = ranges_S2(i, 2);
    S2_SG3(startIdx:endIdx) = value_S2;
end

% Set values for S3_SG3
startIdx_S3 = range_S3(1) + 1;  % Adjust index (starting from 1)
endIdx_S3 = range_S3(2);
S3_SG3(startIdx_S3:endIdx_S3) = value_S3;
assignin('base', 'S2_SG3', S2_SG3);  % Assign S3 to base workspace
assignin('base', 'S3_SG3', S3_SG3);  % Assign S3 to base workspace

end

