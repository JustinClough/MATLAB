%ASME IAM3D Project: Image post-processor
%Written by: Justin Clough
%Written on: 3/18/16
%Written for:
%This script will import image data in the form [point#, X, Y] where X and
%Y are measured pixel locations.  First point is the left side of a well,
%second point is the right side of the well.  These are used for scaleling.
% Third point is the bottom center of the well.  All other points are not
% unque to their number.

%% Prep workspace
clear
clc
close all

%% Import data & Strip Values

Raw_Data=textread('Results083.txt');

Point_number=Raw_Data(:,1)';
X_px=Raw_Data(:,6)';
Y_px=Raw_Data(:,7)';
clear Raw_Data

plot(X_px,Y_px, '*')
title('Imported Raw Data')
pause


%% Set Scaling Ratio, Scale Data Set

Left=[X_px(1), Y_px(1)];
Right=[X_px(2), Y_px(2)];

Distance_X=Right(1)-Left(1);
Distance_Y=Right(2)-Left(2);

Mag_Distance=sqrt((Distance_X)^2+(Distance_Y)^2);
%Determines total distance from left calibration point to right calibration
%point in units of pixels

px_to_um=Mag_Distance/600;
%Determines pixel distance to actual distance (microns) ratio

X=X_px/px_to_um;
Y=Y_px/px_to_um;
%Adjusts whole data set to units of microns

figure
plot(X,Y, '*')
title('Scaled Data')
xlabel('X Position [um]')
ylabel('Y Position [um]')
pause

%% Translate & Rotate Data to 3rd Calibration Point

%Adjust for Translation:
X_cent=X(3);
Y_cent=Y(3);

for i=1:max(Point_number)
    x(i)=X(i)-X_cent;
    y(i)=Y(i)-Y_cent;
end
clear i

%Adjust for Rotation:
%Blunt rotations to force majority of points to first quadrant
if mean(y)<0
    y=-y;
end
if mean(x)<0
    x=-x;
end

Ad_Ang=pi/2-1/2*(atan2(y(1),x(1))+atan2(y(2),x(2)));
%Adjustment angle determined

for i=1:max(Point_number)
    a=atan2(y(i),x(i));
    mag=sqrt(x(i)^2+y(i)^2);
    x(i)=mag*cos(Ad_Ang+a);
    y(i)=mag*sin(Ad_Ang+a);
end
clear i mag a

figure
plot(x,y, '.')
title('Transformed and Rotated Data')
xlabel('X Position [um]')
ylabel('Y Position [um]')


%% Prep Image Analysis

for i=1:max(Point_number)
    if x(i)<0
        x(i)=-x(i);
    end
end
clear i
%points in 4th quadrant mirrored to first

Y=y;
X=x;
clear y x
for i=1:max(Point_number)
    if Y(i)<=300 && X(i)<=300
        y(i)=Y(i);
        x(i)=X(i);
    else
    end
end
%Points out of range truncated

figure
plot(x,y,'.')

for i=1:601
    X_t(i)=(i-1)/2; %step size of 0.5 microns
    Y_t(i)=300-sqrt(600^2-4*X_t(i)^2)/2;
    %Z_t(i)=300+sqrt(600^2-4*X_t(i)^2)/2;
end
clear i
%Theorical curve established

hold on
plot(X_t,Y_t)
%plot(X_t,Z_t)
axis equal

for i=1:length(x)
    yt(i)=300-sqrt(600^2-4*x(i)^2)/2;
    Ydiff(i)=y(i)-yt(i); %difference in actual vs theorical 
    Y_reg(i)=Ydiff(i)+x(i); %difference added to slope of unity
end
clear i yt

% figure
% plot(x,Ydiff, '.')
% figure 
% plot(x,Y_reg, '.')

%% Perform Linear Regression on Prepared Data Set

%Prepare Sum of Squares Values
SumX=sum(x);
SumY=sum(Y_reg);
n=numel(x);

for i=1:n
    xy(i)=x(i)*Y_reg(i);
    xx(i)=x(i)*x(i);
    yy(i)=Y_reg(i)*Y_reg(i);
end

SumXY=sum(xy);
SumXsq=sum(xx);
SumYsq=sum(yy);

SXX=SumXsq-(SumX)^2/n;
SYY=SumYsq-(SumY)^2/n;
SXY=SumXY-(SumX*SumY)/n;

slope=SXY/SXX;
intercept=SumY/n-slope*SumX/n;
r=SXY/sqrt(SXX*SYY)


%% End of script