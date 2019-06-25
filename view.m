figure;
for t = 1:1450
    M = imread(['temp/', 'frame_', num2str(t),'.png']);
    imshow(M)
    drawnow
end