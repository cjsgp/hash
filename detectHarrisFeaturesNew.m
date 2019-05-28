function pointer = detectHarrisFeaturesNew(I)
%I--单通道图像
[m,n] = size(I);

fx=[-1,0,1];%x方向梯度模板
Ix=filter2(fx,I);%x方向滤波
fy=[-1;0;1];%y方向梯度模板(注意是分号)
Iy=filter2(fy,I);
%%%%计算两个方向梯度的乘积%%%%%
Ix2=Ix.^2;
Iy2=Iy.^2;
Ixy=Ix.*Iy;
% Ix(:,2:n) = tmp(:,3:n+1) - tmp(:,1:n-1);
% Iy(2:m,:) = tmp(3:m+1,:) - tmp(1:m-1,:);
% Ix2 = Ix(2:m+1,2:n+1).^2;
% Iy2 = Iy(2:m+1,2:n+1).^2;
% Ixy = Ix(2:m+1,2:n+1).*Iy(2:m+1,2:n+1);

h = fspecial('gaussian',[7 7],2);
Ix2 = filter2(h,Ix2);
Iy2 = filter2(h,Iy2);
Ixy = filter2(h,Ixy);

% Rmax = 0;
R = zeros(m,n);
for i=1:m
    for j=1:n
        M = [Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)];
        R(i,j) = det(M)-0.06 * (trace(M))^2;
    end
end

Rmax=max(max(R));
%阈值
t=0.005 * Rmax;
for i=1:m
    for j=1:n
        if R(i,j) < t
            R(i,j)=0;
        end
    end
end

tmp = zeros(m+2,n+2);
tmp(2:m+1,2:n+1) = R;
img_re = zeros(m+2,n+2);
img_re(2:m+1,2:n+1) = I;
pointer1 = zeros(m + 2,1);
pointer2 = zeros(1,n +2);
newrow = 1;
newcol = 1;

for i = 2:m+1
    for j = 2:n+1
        if tmp(i,j) > 0.04 * Rmax &&...
           tmp(i,j) > tmp(i-1,j-1) && tmp(i,j) > tmp(i-1,j) && tmp(i,j) > tmp(i-1,j+1) &&...
           tmp(i,j) > tmp(i,j-1) && tmp(i,j) > tmp(i,j+1) &&...
           tmp(i,j) > tmp(i+1,j-1) && tmp(i,j) > tmp(i+1,j) && tmp(i,j) >  tmp(i+1,j+1)
                img_re(i,j) = 255;
                pointer1(newrow,1) = i;
                pointer2(1,newcol) = j;
                newrow = newrow + 1;
                newcol = newcol + 1;
        end
    end
end
pointer = [pointer1,pointer2'];