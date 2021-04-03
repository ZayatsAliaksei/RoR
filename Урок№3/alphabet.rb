puts "Соберем хэш из гласных букв"

arr_ru = ['а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'э', 'ю', 'я'];
hash = { }

arr_ru.each_with_index  do |key,value|
  if key =~ /[ауоыиэяюёе]/
    hash[key] = value + 1
  end
end


puts"Выведем на экран результат"

hash.each do |key,value|
  puts "#{key} => #{value}"
end