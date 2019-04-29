data = load('read_data.mat');
data = data.data;

time_horizon = size(data.cv);
time_horizon = time_horizon(1);

figure;
for t=350:370  % Choose the time period to animate
    xEgo = data.cv(t,4);
    cv = data.cv(t,:);
    
    clf;
    hold on
    plot_road(xEgo,t);
    plot_car2(xEgo,cv);
    
    for i = 2:33
        xov = data_matrix(t,4,i);
        ov = data_matrix(t,:,i);
        plot_car1(xov,ov);
    end
    drawnow;
    hold off
    
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
        