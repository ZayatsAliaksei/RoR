puts 'Собеерм массив чисел от 10 до 100  с шагом в 5'

arr = [10]
while arr.last < 100
  arr<< arr.last + 5
end

puts "Выведем полученный массив на экран"

arr.each { |value| puts value }