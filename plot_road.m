function plot_road(x_e,t)
%     figure(fig);
    % road
    lane_width = 3.7; %measured on google map for California I-80
    title(['t = ', num2str(t)]);
    hold on    
    plot([-200 4000],[lane_width*0,lane_width*0],'k-','LineWidth',3);
    plot([-200 4000],[lane_width*1,lane_width*1],'k--','LineWidth',3);
    plot([-200 4000],[lane_width*2,lane_width*2],'k--','LineWidth',3);
    plot([-200 4000],[lane_width*3,lane_width*3],'k--','LineWidth',3);
    plot([-200 4000],[lane_width*4,lane_width*4],'k--','LineWidth',3);
    plot([-200 4000],[lane_width*5,lane_width*5],'k--','LineWidth',3);
    plot([-200 4000],[lane_width*6,lane_width*6],'k--','LineWidth',3);
    plot([-200 4000],[lane_width*7,lane_width*7],'k-','LineWidth',3);
    axis([x_e-50 x_e+50 -2 28])
    set(gca,'ytick',[])
end