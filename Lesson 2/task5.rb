# Запрашиваем у пользователя день, месяц и год
puts "Введите день:"
day = gets.to_i
puts "Введите месяц:"
month = gets.to_i
puts "Введите год:"
year = gets.to_i

# Функция для проверки, является ли год високосным
def leap_year?(year)
  (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
end

# Массив с количеством дней в каждом месяце
days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# Корректируем февраль, если год високосный
if leap_year?(year)
  puts 'А год то високосный!'
  days_in_months[1] = 29
end

# Вычисляем порядковый номер даты
ordinal_date = day + days_in_months.take(month - 1).sum

# Выводим результат
puts "Порядковый номер даты: #{ordinal_date}"
