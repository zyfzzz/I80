figure;
for t = 800:1100
    M = imread(['temp/', 'frame_', num2str(t),'.png']);
    imshow(M)
    drawnow
end