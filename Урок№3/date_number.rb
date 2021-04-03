print 'Введите день: '
day = gets.to_i

print 'Введите номер месяца (1,2,3...12): '

month = gets.strip.to_i

print 'Введите год: '
year = gets.to_i

all = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def leap_year?(year)
  if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) || year == 2000
    true
  else
    false
  end
end

all[1] = 29 if leap_year?(year)

puts day + all[0..month - 1].sum