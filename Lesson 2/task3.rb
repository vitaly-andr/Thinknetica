# frozen_string_literal: true

# Массив для хранения чисел Фибоначчи
fibonacci_numbers = []

# Начальные значения
a = 0
b = 1

# Заполняем массив числами Фибоначчи, не превышающими 100
while a <= 100
  fibonacci_numbers << a
  a, b = b, a + b # Переходим к следующему числу Фибоначчи
end

# Выводим массив
puts fibonacci_numbers.inspect
