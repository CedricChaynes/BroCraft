require 'open-uri'
require 'json'
require 'nokogiri'
require 'faker'

Booking.destroy_all
Tool.destroy_all
User.destroy_all
queries = %w[hand-tools automotive-tools home-and-garden air-tools power-tools metal-working-tools]
baseurl = 'https://www.toolplanet.com/category/'
img_url_list = []
queries.each do |query|
  url = "#{baseurl}#{query}"
  response = open(baseurl).read
  doc = Nokogiri::HTML(response)
  doc.search('.image a img').each do |elem|
    img_url_list << elem.attribute('src').value
  end
end

def generate_French_mobile_number
  "#{%w[+33 (+33) 0].sample}#{rand(6..7)}#{rand.to_s[2..9]}"
end

def generate_image_url
  size = [*200..400].sample
  Faker::LoremPixel.image("#{size}x#{size}")
end

def generate_price
  rand(1.0..100.0).round(2)
end

def generate_date
  rand(Date.today..Date.civil(2019, 12, 31))
end

CATEGORIES = ['outillage à main', 'outillage électroportatif',
              'outillage spécialisé', 'protection', 'équipement de chantier',
              "machine d'atelier"]

user = User.create!(username: "sirtaylor88", email: "nhattai.nguyen88@gmail.com",
         password: '123456', mobile: generate_French_mobile_number,
         address: Faker::Address.full_address, remote_avatar_url: generate_image_url)
10.times do
  tool = Tool.new(name: "#{Faker::ElectricalComponents.electromechanical}#{rand(100)}",
            description: Faker::Lorem.paragraph_by_chars(256, false),
            category: CATEGORIES.sample, price_per_day: generate_price,
            remote_photo_url: img_url_list.sample)
  tool.owner = user
  tool.save
end

count = 1
while count < 4
  user = User.create!(username: "user#{count}", email: "user#{count}@gmail.com",
         password: '123456', mobile: generate_French_mobile_number,
         address: 'Lyon',remote_avatar_url: generate_image_url)

  rand(1..5).times do
    tool = Tool.new(name: "#{Faker::ElectricalComponents.electromechanical}#{rand(100)}",
              description: Faker::Lorem.paragraph_by_chars(256, false),
              category: CATEGORIES.sample, price_per_day: generate_price,
              remote_photo_url: img_url_list.sample)
    tool.owner = user
    tool.save
  end
  count += 1
end

50.times do |variable|
  start_date = rand(Date.today..Date.civil(2020, 12, 31))
  end_date = start_date + rand(1..365)
  booking = Booking.new(status: %w[pending approved rejected].sample,
              start_date: start_date,
              end_date: end_date)
  booking.renter = User.all.sample
  booking.tool = Tool.all.sample
  booking.save
end

