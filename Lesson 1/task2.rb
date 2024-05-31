# frozen_string_literal: true

def calculate_triangle_area(base, height)
  (base * height) / 2.0
end

puts 'Введите основание треугольника:'
base = gets.to_f

puts 'Введите высоту треугольника:'
height = gets.to_f

area = calculate_triangle_area(base, height)
puts "Площадь треугольника: #{area}"
