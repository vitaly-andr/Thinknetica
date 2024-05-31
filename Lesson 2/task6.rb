# frozen_string_literal: true

# Хеш для хранения данных о покупках
cart = {}

loop do
  puts "Введите название товара или 'стоп' для завершения:"
  title = gets.chomp
  break if title == 'стоп'

  puts 'Введите цену за единицу товара:'
  price = gets.to_f

  puts 'Введите количество купленного товара:'
  quantity = gets.to_f

  # Добавляем информацию в хеш
  cart[title] = { price: price, quantity: quantity }
end

total = 0

puts 'Список покупок:'
cart.each do |title, info|
  sum = info[:price] * info[:quantity]
  puts "#{title}: #{info[:quantity]} шт. по #{info[:price]} руб. = #{sum} руб."
  total += sum
end

puts "Итоговая сумма всех покупок: #{total} руб."
