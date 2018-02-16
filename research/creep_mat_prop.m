% Reads in a csv file from ImageJ of experimental data.
% Curve fits data to get creep material properties

% Prep the workspace
clear;
home;

% Adjust these parameters accordingly
csv_fname = 'stress_strain_points.csv';
x_units   = 'Percent Strain';
y_units   = 'MPa';
knee_pt   = 60;

x_refPoint = 40; 
           % 40 percent strain
y_refPoint = 1400;
           % 1400 MPa

%% Read in csv
Data = csvread( csv_fname);

% Pull needed info from whole set
x_raw = Data( :, 6);
y_raw = Data( :, 7);

%% Translate and Scale to match graph origin
% The first point is assumed to be at the origin
x_o = x_raw( 1);
y_o = y_raw( 1);


% Translate to origin
n = length( x_raw);
for i = 1:n
  x_raw(i) = x_raw(i) - x_o;
  y_raw(i) = y_raw(i) - y_o
end

% Rotate to be in first quadrant
if mean(x_raw) < 0
  x_raw = -x_raw;
end
if mean(y_raw) < 0
  y_raw = -y_raw;
end

figure
plot(x_raw, y_raw, '*')
hold on
title('Translated and Rotated Imported Data')
xlabel('X Position [px]')
ylabel('Y Position [px]')

% Scale to appropriate units
x_scale = (x_raw(2) - x_raw(1)) / x_refPoint;
        % Units of pixels per x_units
y_scale = (y_raw(3) - y_raw(1)) / y_refPoint;
        % Units of piyels per y_units

x = x_raw( 4:n) / x_scale;
y = y_raw( 4:n) / y_scale;

figure
plot(x, y, '*')
hold on
title('Prepped Data')
xlabel( ['X Data [' x_units ']']);
ylabel( ['Y Data [' y_units ']']);

%% Estimate Material Properties
x1 = x(4:knee_pt);
y1 = y(4:knee_pt);

% Not strictly enforcing an origin intercept
E = [ones( length(x1), 1) x1] \y1;

% Adjust for percent strain to nominal 
E = E *100;
fprintf(['Youngs Modulus, E = '])
E
fprintf([ y_units '\n'])


