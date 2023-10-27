code_length = 5*13*13*13;

best_code = [];
best_side_lobe = inf;

% Функция для вычисления боковых лепестков
side_lobe = @(code) sum(abs(fft(code)));

for code_value = [-1, 1]
    current_code = code_value * ones(1, code_length);
    current_side_lobe = side_lobe(current_code);
    
    if current_side_lobe < best_side_lobe
        best_code = current_code;
        best_side_lobe = current_side_lobe;
    end
end

disp('Лучший код Баркера:');
disp(best_code);
disp(['Минимальные боковые лепестки: ', num2str(best_side_lobe)]);
