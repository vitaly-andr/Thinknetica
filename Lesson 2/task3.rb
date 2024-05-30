# Массив для хранения чисел Фибоначчи
fibonacci_numbers = []

# Начальные значения
a, b = 0, 1

# Заполняем массив числами Фибоначчи, не превышающими 100
while a <= 100
  fibonacci_numbers << a
  a, b = b, a + b  # Переходим к следующему числу Фибоначчи
end

# Выводим массив
puts fibonacci_numbers.inspect