% Reads in a csv file from ImageJ of experimental data.
% Curve fits data to get creep material properties

% Prep the workspace
clear;
home;

% Adjust these parameters accordingly
csv_fname = 'stress_strain_points.csv';
x_units   = 'Nominal Strain';
y_units   = 'MPa';
knee_pt   = 60;

x_refPoint1 = 0.20; 
           % 20 percent strain
x_refPoint2 = 0.40; 
           % 40 percent strain

y_refPoint1 = 600;
           % 600 MPa
y_refPoint2 = 1400;
           % 1400 MPa

% The actual data starts at point 6 and after
data_start = 6;


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

% Flip to be in first quadrant
if mean(x_raw) < 0
  x_raw = -x_raw;
end
if mean(y_raw) < 0
  y_raw = -y_raw;
end

% Scale to appropriate units
x_scale1 = (x_raw(2) - x_raw(1)) / x_refPoint1;
x_scale2 = (x_raw(3) - x_raw(1)) / x_refPoint2;
x_scale  = mean( [x_scale1 x_scale2]);
% Units of pixels per x_units

y_scale1 = (y_raw(4) - y_raw(1)) / y_refPoint1;
y_scale2 = (y_raw(5) - y_raw(1)) / y_refPoint2;
y_scale  = mean( [y_scale1 y_scale2]);
% Units of pixels per y_units

x = x_raw( data_start:n) / x_scale;
y = y_raw( data_start:n) / y_scale;

figure
plot(x, y, '*')
hold on
title('Prepped Data')
xlabel( ['X Data [' x_units ']']);
ylabel( ['Y Data [' y_units ']']);

%% Estimate Material Properties
x1 = x( 1:(knee_pt - data_start + 1));
y1 = y( 1:(knee_pt - data_start + 1));

% Not strictly enforcing an origin intercept
sol = [ones( length(x1), 1) x1] \y1;
E = sol( 2);

% Adjust for percent strain to nominal 
fprintf(['Youngs Modulus, '])
E
fprintf([ y_units '\n'])

testx = min(x1):( x1( length(x1)) / 100):x1( length(x1));
testy = E * testx + sol(1);

hold on
plot( testx, testy)
grid on
legend( 'Data', 'Fitted Line', 'Location', 'southeast' )



