f = xlsread('pd.xlsx');
x = f(:,1);
f = f(:,2:5);


for i=1:600:length(f)
    last = i+600-1;
     eye_x = f(i:last, 3);
     eye_y = f(i:last, 4);
     final_dist = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%my new%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        r_window = 5;
        d = [];
        median_before =[];
        median_after = [];
        for ii=5:length(eye_x)-5
            s_x_b = eye_x(ii-r_window+1:ii);
            s_y_b = eye_y(ii-r_window+1:ii);
            mean_before = [mean(s_x_b), mean(s_y_b)];
            s_x_a = eye_x(ii: ii+r_window-1);
            s_y_a = eye_y(ii: ii+r_window-1);
            mean_after = [mean(s_x_a), mean(s_y_a)];
            d_temp = sqrt(dot((mean_after-mean_before),(mean_after-mean_before)'));
            d = [d d_temp];
        end
        [val index] = findpeaks(d, 'MinPeakHeight', std(d));
        [unique_val unique_idx] = uniquetol(val);
        index = index(unique_idx);
        index = sort(index);
        index = index+5-1;
        index = [1 index];
        fixation_duration = [index length(eye_x)];
        fixation_duration =diff(fixation_duration);
        plot(eye_x, eye_y); hold on;
        rms_fixation = [];
        for j=1:length(index)
            try
                %plot(median(eye_x(index(j):index(j+1))), median(eye_y(index(j):index(j+1))), 'o', 'MarkerSize', 20);
                rms_fixation = [rms_fixation; median(eye_x(index(j):index(j+1))), median(eye_y(index(j):index(j+1)))];
                plot(median(eye_x(index(j):index(j+1))), median(eye_y(index(j):index(j+1))), 'o', 'MarkerSize', 20);
                hold on;
            catch
                rms_fixation = [rms_fixation; median(eye_x(index(j):end)), median(eye_y(index(j):end))];
                plot(median(eye_x(index(j):end)), median(eye_y(index(j):end)), 'o', 'MarkerSize', 20);
            end
        end
end         %create a breakpoint here to see the plot