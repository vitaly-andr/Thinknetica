# Когда мы работаем с числами с плавающей точкой (например, 3.0 и 3.0000000001),
#   из-за ограниченной точности вычислений, прямое сравнение с помощью оператора == может быть ненадежным.
#   Поэтому мы используем допуск, чтобы определить, насколько близки два числа друг к другу.
# А также корень квадратный слишком много цифр после запятой дает

def is_right_triangle?(a, b, c)
  sides = [a, b, c].sort
  ((sides[2]**2) - (sides[0]**2 + sides[1]**2)).abs <= 0.1  # Измененный допуск
end

def is_isosceles_triangle?(a, b, c)
  (a - b).abs < 0.01 || (b - c).abs < 0.01 || (a - c).abs < 0.01
end

def is_equilateral_triangle?(a, b, c)
  (a - b).abs < 0.01 && (b - c).abs < 0.01
end

def is_valid_triangle?(a, b, c)
  a + b > c && a + c > b && b + c > a
end

puts "Введите первую сторону треугольника:"
a = gets.to_f

puts "Введите вторую сторону треугольника:"
b = gets.to_f

puts "Введите третью сторону треугольника:"
c = gets.to_f


if is_valid_triangle?(a, b, c)
  if is_equilateral_triangle?(a, b, c)
    puts "Треугольник равносторонний."
  elsif is_right_triangle?(a, b, c)
    puts "Треугольник прямоугольный."
    if is_isosceles_triangle?(a, b, c)
      puts "Треугольник также равнобедренный."
    end
  elsif is_isosceles_triangle?(a, b, c)
    puts "Треугольник равнобедренный."
  else
    puts "Треугольник - ничего особенного :)"
  end
else
  puts "Это не треугольник."
end