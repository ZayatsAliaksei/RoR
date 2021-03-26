puts 'Рассчет квадратного уравнения'
puts 'Введите 3 коэфицента'
puts 'A = '
a = gets.chomp.to_f
puts 'B = '
b = gets.chomp.to_f
puts 'C = '
c = gets.chomp.to_f

d = b*b - 4*a*c
 
if (d == 0)
   puts 'x = '+(-b/2/a).to_s
else
   if (d > 0)
      puts 'x1 = '+((-b-Math.sqrt(d))/2/a).to_s
      puts 'x2 = '+((-b+Math.sqrt(d))/2/a).to_s
   else
     puts 'Корней нет' + d.to_s
   end
end
