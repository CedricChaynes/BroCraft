require 'open-uri'
require 'json'
require 'nokogiri'
require 'faker'

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

10.times do
  user = User.create!(username: Faker::Internet.username, first_name: Faker::Name.first_name,
         last_name: Faker::Name.last_name, email: Faker::Internet.email,
         password: Faker::Internet.password, mobile: generate_French_mobile_number,
         address: Faker::Address.full_address, avatar_url: generate_image_url)
  rand(1..5).times do
    tool = Tool.new(name: Faker::ElectricalComponents.electromechanical,
              description: Faker::Lorem.paragraph_by_chars(256, false),
              category: CATEGORIES.sample, price_per_day: generate_price,
              photo_url: generate_image_url)
    tool.owner = user
    tool.save!
  end
end

100.times do |variable|
  start_date = rand(Date.today..Date.civil(2050, 12, 31))
  end_date = start_date + rand(1..365)
  booking = Booking.new(status: %w[pending approved rejected].sample,
              start_date: start_date,
              end_date: end_date)
  booking.renter = User.all.sample
  booking.tool = Tool.all.sample
  booking.save!
end
