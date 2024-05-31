# frozen_string_literal: true

# Строка с русским алфавитом
alphabet = ('а'..'я').to_a
alphabet.insert(6, 'ё') # Добавляем "ё" после "е", так как в основном диапазоне "ё" нет

# Массив гласных букв
vowels = %w[а е ё и о у ы э ю я]

# Хеш для хранения гласных и их индексов
vowel_indices = {}

# Заполнение хеша
alphabet.each_with_index do |letter, index|
  if vowels.include?(letter)
    vowel_indices[letter] = index + 1 # Порядковый номер, начиная с 1
  end
end

# Вывод хеша
puts vowel_indices.inspect
