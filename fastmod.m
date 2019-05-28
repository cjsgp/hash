a   = imread('D:\BaiduNetdiskDownload\stamp.png');
img = a;
b   = img(:,:,1);
Fastpoints = detectFASTFeatures(b);
strongfastpoint = Fastpoints.selectStrongest(10);
metricpoint = strongfastpoint.Metric;

[e,p] = size(metricpoint);
newmetricpoints = zeros(e,p);
newMetricPoints = zeros(e,p);

strmetric = '';
for i = 1:e
    for j = 1:p
       newmetricpoints(i,j) = metricpoint(i,j) + 1;
       newMetricPoints(i,j) = newmetricpoints(i,j) - mod(newmetricpoints(i,j),4);
       strmetric = strcat(strmetric,num2str(newMetricPoints(i,j)));
    end
end

L1 = strlength(strmetric);
strmetric1 = '';
strmetric2 = '';
for i = 1:L1
    if strmetric(i) == '2'
        strmetric1 = strcat(strmetric1,strmetric(i));
    else
        strmetric2 = strcat(strmetric2,strmetric(i));
    end
end

L2 = strlength(strmetric1);
L3 = strlength(strmetric2);
for i = 1:L2
    if i <= 8
        double1 = int8(str2double(strmetric1(i)) * sqrt( 2 * i) + 0.5 * log2(i) - 1);
        strmetric1(i) = num2str(double1);
    elseif i > 8 && i <= L2
        double1 = int8(str2double(strmetric1(i)) * log(0.5 * i) + 0.25 * i);
        strmetric1(i) = num2str(double1);
    end
end

for i = 1:L3
    if i <= 7
        if strmetric2(i) == '8'
            strmetric2(i) = strmetric2(i);
        else
            double2 = int8(str2double(strmetric2(i)) * sqrt(0.5 * i) + 0.3 * log2(i) - 2);
            strmetric2(i) = num2str(double2);
        end
    elseif i > 7 && i <= L3
        double2 = int8(str2double(strmetric2(i)) * sqrt(i - 3) - log2(i));
        strmetric2(i) = num2str(double2);
   end
end

strmetric = strcat(strmetric1,strmetric2);

for i = 1:6:L1
    for j = i:i
        strmedian = strmetric(j);
        strmetric(j) = strmetric(j + 4);
        strmetric(j + 4) = strmedian;
        
        strmedian = strmetric(j + 1);
        strmetric(j + 1) = strmetric(j + 3);
        strmetric(j + 3) = strmedian;
        
        strmedian = strmetric(j + 2);
        strmetric(j + 2) = strmetric(j + 5);
        strmetric(j + 5) = strmedian;
    end
end

strmetric = strcat(strmetric,'h','x');
h = HASH(strmetric,'MD5');

% c   = img(:,:,2);
% Harrispoints = detectHarrisFeatures(c);
% d = img(:,:,3);
% Surfpoints = detectSURFFeatures(d);
% figure(1);
% plot(Fastpoints.selectStrongest(10));
% figure(2);
% plot(Harrispoints.selectStrongest(10));
% figure(3);
% plot(Surfpoints.selectStrongest(10));
% Harrispoints = detectHarrisFeaturesNew(c);
% figure(4);
% plot(Harrispoints(:,1),Harrispoints(:,2),'o');