puts "Заполним массив числами Фибоначчи до 100"


arr = [0]

while arr.last < 100
  if arr.last == 0
    arr << 1
  end
  fib = arr[-1] + arr[-2]
  break if fib > 100
  arr<<fib
end

puts "Выведем на экран"
arr.each {|value| puts value}