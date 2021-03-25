puts "Введите длинну каждой из трех сторон треугольника"
sleep(1)
puts "Введите сторону A"
a = gets.chomp.to_f
puts "Введите сторону В"
b = gets.chomp.to_f
puts "Введите сторону С"
c = gets.chomp.to_f
puts "Начинаем рассчет"
sleep(2)

if a != b && a != c && b != c
  arr = [a, b, c].sort
  if arr[0]**2 == arr[1]**2 + arr[2]**2
    puts "Ваш треугольник - прямоугольный"
  end
  puts "Просто треугольник"
elsif a == b && b != c || b == c && c != a
  puts "Ваш треугольник равнобедренный"
elsif a == b && a == c && b == c
  puts "Треугольник равносторонний и равнобедренный"
end

n = 1
while n <= 5
  puts ("* " * n).rjust(10)
  n += 1
end

