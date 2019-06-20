
data = load('read_data.mat');
data = data.data;

time_horizon = size(data.cv);
time_horizon = time_horizon(1);

figure;
% profile on
%read image from here
setappdata(gca,'LegendColorbarManualSpace',1);
setappdata(gca,'LegendColorbarReclaimSpace',1);
im1 = imread('cars/car_blue.png');
im2 = imread('cars/car_green.png');
for t=1050:1100 % Choose the time period to animate
    xEgo = data.cv(t,4);
    cv = data.cv(t,:);
    clf;
%     hold on
    plot_road(xEgo,t);
    plot_car2(xEgo,cv,im2);
    
    for i = 2:29
        if i == 26
            continue
        else
            xov = data_matrix(t,4,i);
            ov = data_matrix(t,:,i);
            plot_car1(xov,ov,im1);
        end
    end

    drawnow limitrate
%     hold off
    
%     xov1 = data.ov1(t,4);
%     xov2 = data.ov2(t,4);
%     
%     ov1 = data.ov1(t,:);
%     ov2 = data.ov2(t,:);
% %     plot_road(xEgo,data.cv(t,1));
%     clf;
%     hold on
%     plot_road(xEgo,t);
%     plot_car2(xEgo,cv);
%     plot_car1(xov1,ov1);
%     plot_car1(xov2,ov2);
%     drawnow;
%     hold off
end
drawnow
% profile viewer
