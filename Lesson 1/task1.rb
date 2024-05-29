def calculate_ideal_weight(name, height)
  ideal_weight = (height - 110) * 1.15

  if ideal_weight > 0
    "Ваш идеальный вес: #{ideal_weight.round(2)} кг."
  else
    'Ваш вес уже оптимальный.'
  end
end

# Получение данных от пользователя
puts "Как вас зовут?"
name = gets.chomp
puts "Привет, #{name}! Какой у Вас рост?"
height = gets.to_f

# Вывод результата
result = calculate_ideal_weight(name, height)
puts result