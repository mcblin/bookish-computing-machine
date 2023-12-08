function generate_barker_codes()
    % Длины Баркер-кодов
    lengths = input('Введите длину Баркер-кода: ');

    for i = 1:length(lengths)
        N = lengths(i);

        % Создание Баркер-кода
        barker_code = generate_barker(N);

        % Вывод Баркер-кода и его уровня в дБ
        disp(['Код Баркера (Длина ', num2str(N), '):']);
        disp(barker_code);
        sidelobe_level = calculate_sidelobe_level(barker_code);
        disp(['Уровень боковых лепестков (дБ): ', num2str(round(sidelobe_level, 1)), ' dB']);

        % Построение графика лепестков и автокорреляции
        plot_barker_code(barker_code, N);
    end
end

function barker_code = generate_barker(N)
    % Генерация Баркер-кода длиной N
    if N == 2
        barker_code = [1 -1];
    elseif N == 3
        barker_code = [1 1 -1];
    elseif N == 4
        barker_code = [1 1 -1 -1];
    elseif N == 5
        barker_code = [1 1 1 -1 1];
    elseif N == 7
        barker_code = [1 1 1 -1 -1 1 -1];
    elseif N == 11
        barker_code = [1 1 1 -1 -1 -1 1 -1 -1 1 -1];
    elseif N == 13
        barker_code = [1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];
    else
        error('Длина Баркер-кода не поддерживается');
    end
end

function sidelobe_level = calculate_sidelobe_level(barker_code)
    % Вычисление уровня лепестков в дБ
    autocorr_result = xcorr(barker_code, barker_code);
    sidelobe_level = 20 * log10(max(abs(autocorr_result)) / max(abs(barker_code)));
end

function plot_barker_code(barker_code, N)
    % Построение графика лепестков и автокорреляции
    figure;

    % График лепестков
    subplot(2, 1, 1);
    stem(barker_code, 'Marker', 'none', 'LineWidth', 2);
    title(['Лепестки Баркер-кода (Длина ', num2str(N), ')']);
    xlabel('Отсчеты');
    ylabel('Амплитуда');
    grid on;

    % График автокорреляции
    subplot(2, 1, 2);
    autocorr_result = xcorr(barker_code, barker_code);
    lag = -length(barker_code)+1:length(barker_code)-1;
    plot(lag, autocorr_result, 'LineWidth', 2);
    title(['Автокорреляция Баркер-кода (Длина ', num2str(N), ')']);
    xlabel('Лаг (временной сдвиг)');
    ylabel('Амплитуда');
    grid on;
end
