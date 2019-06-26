load('density');
sorted = sortrows(density_array')';
sorted = reshape(sorted, [], 5)
min_flow = int64(sorted(1,:));
max_flow = int64(sorted(end-2,:));
min_vel = min(sorted(2:3:end,:));
min_acc = min(sorted(3:3:end,:));
max_vel = max(sorted(2:3:end,:));
max_acc = max(sorted(3:3:end,:));
row_name = {'min_vel', 'max_vel', 'min_acc', 'max_acc'};
col_name = cellstr(string(min_flow) + '-' + string(max_flow))
col_name = matlab.lang.makeValidName(col_name);
result = [min_vel; max_vel; min_acc; max_acc];

final_table = array2table(result, 'RowNames', row_name, 'VariableNames',col_name)