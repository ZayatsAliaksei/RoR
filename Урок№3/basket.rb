

hash = {}

def hash_view(hash)
  hash.map { |key,value|
    puts "#{key}:"
    puts value.map{|key,value| puts "#{key} руб.#{value}шт."}
  }
end

def get_all_sum(hash)
  puts "Сумма за каждый продукт:"
  product_sum = {}
  hash.map{|product,prop| product_sum[product] = (prop.map{|price,count| price*count})[0]}
  product_sum.each {|product,sum| puts "#{product} - #{sum} руб."}
  sleep(5)
  puts "Общая сумма корзины:"
  puts product_sum.values.sum.ceil(2)
end


loop do
  puts "Введите название товара"
  name = gets.chomp.to_s
  puts "Введите стоимость единицы товара"
  cost = gets.chomp.to_f
  puts "Введите количество едениц товара"
  count = gets.chomp.to_i

  hash.store(name,{cost.to_f => count})
  puts hash
  # здесь идет обработка ввода, в зависимости от выбранного варианта
  puts "Если это все покупки введите - стоп, продолжить дальше Enter"
  stop = gets.chomp.to_s
  if stop == 'стоп'
    hash_view(hash)
    sleep(5)
    get_all_sum(hash)
    sleep(20)
    break
  end
end

