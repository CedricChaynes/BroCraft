require 'open-uri'
require 'json'
require 'nokogiri'
require 'faker'

=begin
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
3.times do
  tool = Tool.new(name: "#{Faker::ElectricalComponents.electromechanical}#{rand(100)}",
            description: Faker::Lorem.paragraph_by_chars(256, false),
            category: CATEGORIES.sample, price_per_day: generate_price,
            remote_photo_url: img_url_list.sample)
  tool.owner = user
  tool.save!
end

count = 1
while count < 3
  user = User.create!(username: Faker::Name.unique.name, email: "user#{count}@gmail.com",
         password: '123456', mobile: generate_French_mobile_number,
         address: ADDRESSES.sample,remote_avatar_url: generate_image_url)

  rand(2..3).times do
    tool = Tool.new(name: "#{Faker::ElectricalComponents.electromechanical}#{rand(100)}",
              description: Faker::Lorem.paragraph_by_chars(256, false),
              category: CATEGORIES.sample, price_per_day: generate_price,
              remote_photo_url: img_url_list.sample)
    tool.owner = user
    tool.save!
  end
  count += 1
end

20.times do |variable|
  start_date = rand(Date.today..Date.civil(2020, 12, 31))
  end_date = start_date + rand(1..365)
  booking = Booking.new(status: %w[pending approved rejected].sample,
              start_date: start_date,
              end_date: end_date)
=end

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

puts "Destroying previous data........."

Booking.destroy_all
Tool.destroy_all
User.destroy_all
puts "Previous data destroyed !"

puts "Creating new users........."
adele = User.create({
  username: "adele",
  password: "123456",
  email: "adele@gmail.com",
  mobile: "#{%w[+33 (+33) 0].sample}#{rand(6..7)}#{rand.to_s[2..9]}",
  remote_avatar_url: "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558689263/seedata/adele_ojiwzn.jpg",
  address: "23 rue Valentin Couturier, 69004 Lyon"
})

vicouille = User.create({
  username: "vicouille",
  password: "123456",
  email: "vicouille@gmail.com",
  mobile: "#{%w[+33 (+33) 0].sample}#{rand(6..7)}#{rand.to_s[2..9]}",
  remote_avatar_url: "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558689263/seedata/vicouille_m7y96c.jpg",
  address: "1 avenue du Parc, 38300 Bourgoin-Jallieu"
})

thai = User.create({
  username: "thai",
  password: "123456",
  email: "thai@gmail.com",
  mobile: "#{%w[+33 (+33) 0].sample}#{rand(6..7)}#{rand.to_s[2..9]}",
  remote_avatar_url: "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558689264/seedata/thai_dkeo6j.jpg",
  address: "Chemin des Moines, 01120 Montluel"
})

cedric = User.create({
  username: "cedric",
  password: "123456",
  email: "cedric@gmail.com",
  mobile: "#{%w[+33 (+33) 0].sample}#{rand(6..7)}#{rand.to_s[2..9]}",
  remote_avatar_url: "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558689264/seedata/cedric_us0hbt.jpg",
  address: "78 avenue Berthelot, 69007 Lyon"
})

manolo = User.create({
  username: "manolo",
  password: "123456",
  email: "manolo@gmail.com",
  mobile: "#{%w[+33 (+33) 0].sample}#{rand(6..7)}#{rand.to_s[2..9]}",
  remote_avatar_url: "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558689839/seedata/manolo_rcdu0e.jpg",
  address: "01800 Joyeux"
})

valerie = User.create({
  username: "valerie",
  password: "123456",
  email: "valerie@gmail.com",
  mobile: "#{%w[+33 (+33) 0].sample}#{rand(6..7)}#{rand.to_s[2..9]}",
  remote_avatar_url: "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558689626/seedata/valerie_rtry2t.jpg",
  address: "14 Rue du Colombier, 69800 Saint-Priest"
})

puts "Users created !"
puts "creating new Tools.............."

tools = ["scie sauteuse", "toupie d'établi", "visseuse d'angle à fil", "ponceuse à bande", "raboteuse dégauchiseusse", "meuleuse", "pince à encoche", "lime à métaux", "Fer à souder 100W", "ebauchoirs en buis", "ciseau à pierre","aiguille P47", "burin", "scie à mèches", "perceuse", "perceuse", "perceuse", "carelette manuelle", "tablier de protection", "serre joint", "défonceuse", "tournette basse"]
desc1 = ["parfait état", "a très peu servi", "un peu abimé sur le devant", "toujours aussi utile après des années d'utilisation", "ne m'a jamais trahi", "état convenable", "fragile, mais fonctionne bien", "j'ai construit ma maison uniquement avec cet outil", "solide et robuste, de bonne facture"]
desc2 = ["de marque Black & Decker", "se branche sur une prise 20V minimum", "ne pas utiliser les jours de pluie", "prêté avec la notice", "acheté chez Castorama il y'a 2 semaines", "puissance 1600W", "pour lames de 550mm", "longueur 1160mm", "avec semelle en fonte", "embout caoutchouc", "avec plaque de coupe 60x45","modèle MV Dremel 510 Pro Turbo", "marque Trima 25mm UltraPower", "recommandé dans l'émission Déco", "avec douille theromstatique", "en polypropylène"]
CATEGORIES = ['outillage à main', 'outillage électroportatif',
              'outillage spécialisé', 'protection', 'équipement de chantier',
              "machine d'atelier"]
# ADDRESSES = %w[Paris Lyon Marseille Toulouse Lille Grenoble Melun Courcouronnes Evry Cublize
#                Saint-Nazaire Ardennes Nantes Bordeaux Rennes Tours Poitiers Limoges
#               Bourges Montpellier Nice Corse Dijon Strasbourg Reims Le-Havre Poitiers]



user = User.create!(username: "sirtaylor88", email: "nhattai.nguyen88@gmail.com",
         password: '123456', mobile: generate_French_mobile_number,
         address: '2 rue de la République, Lyon', remote_avatar_url: generate_image_url)

img_cl_url = ["https://res.cloudinary.com/dl8rau6sl/image/upload/v1558688593/seedata/jsem4rwn7ny2yjvss4u5.jpg",
          "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558688592/seedata/iasjic6kckfkzsdnvs46.jpg",
          "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558688593/seedata/g6bsual8wvlgoufoeoej.jpg",
          "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558688577/seedata/j6uecuo4r4z4zsohw2vk.jpg",
          "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558688562/seedata/gjvvvsaj2j2prnubtyuz.jpg",
          "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558623944/seedata/xo9q7bz71g8jomoehiy0.jpg",
          "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558688589/seedata/enkzlcnweszhz1c8aduc.jpg",
          "https://res.cloudinary.com/dl8rau6sl/image/upload/v1558691408/seedata/perceuse_jnfymd.jpg"
          ]

50.times do
  tool = Tool.new(name: tools.sample,
            description: desc1.sample + ", " + desc2.sample,
            category: CATEGORIES.sample,
            price_per_day: rand(1.0..30.0).round(1),
            remote_photo_url: img_cl_url.sample)
  tool.owner = User.all.sample
  tool.save!
end

puts "Tools created !"
puts "Creating new bookings.........."

40.times do
  start_date = Date.today + (rand(5)-2).day
  end_date = start_date + rand(1..9)
  booking = Booking.new(status: %w[pending approved].sample,
              start_date: Date.tomorrow,
              end_date: 2.days.from_now)

  booking.renter = User.all.sample
  booking.tool = Tool.all.sample
  booking.save!
  booking.update_columns(start_date: start_date, end_date: end_date)
  if booking.start_date <= Date.today
    booking.update_columns(status: "approved")
  end
end

puts "Bookings created !"
