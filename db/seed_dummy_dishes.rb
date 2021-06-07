require_relative 'helpers.rb'

names2 = "chocolate egg chicken toast avocado".split(' ')
names1 = "cake pudding muffin marshmellow".split(' ')


10.times do
    dish_name = "#{names1.sample} #{names2.sample}"
    image_url = 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/xmas-pud-holly-4483fb8.jpg'
    run_sql("insert into dishes (name, image_url) values ('#{dish_name}','#{image_url}');")
end

