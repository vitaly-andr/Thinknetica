# frozen_string_literal: true

puts 'Введите коэффициент a:'
a = gets.to_f

puts 'Введите коэффициент b:'
b = gets.to_f

puts 'Введите коэффициент c:'
c = gets.to_f

discriminant = b**2 - 4 * a * c

if discriminant.positive?
  x1 = (-b + Math.sqrt(discriminant)) / (2 * a)
  x2 = (-b - Math.sqrt(discriminant)) / (2 * a)
  puts "Дискриминант: #{discriminant}, корни: x1 = #{x1}, x2 = #{x2}"
elsif discriminant.zero?
  x1 = -b / (2 * a)
  puts "Дискриминант: #{discriminant}, корень: x = #{x1}"
else
  puts "Дискриминант: #{discriminant}, корней нет"
end
