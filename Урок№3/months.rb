puts 'Привет, выведу на экрна месяцы в которых ровно 30 дней'
sleep(2)
months = {
  "April" => 30,
  "May" => 31,
  "June" => 30,
  "Julie" => 31,
  "August" => 31,
  "September" => 30,
  "October" => 31,
  "November" => 30,
  "December" => 31,
  "January " => 31,
  "February " => 28,
  "March " => 31,
}

months.each do |name, day|
  if day == 30
    puts name
  end
end
sleep(2)
puts 'И весь Хэш заодно'
sleep(2)
months.each do |name, day|
  puts "#{name} => #{day}"
end

