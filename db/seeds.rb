require 'open-uri'
require 'json'
require 'nokogiri'
require 'faker'

base_url = 'https://www.thecocktaildb.com/browse.php?s='

response = open('https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json').read
cocktails = JSON.parse(response)
cocktails.each_with_index do |cocktail, cocktail_index|
  cocktail_db = Cocktail.new(name: cocktail['name'], preparation: cocktail['preparation'])
  doc = Nokogiri::HTML(open("#{base_url}#{cocktail['name'].downcase.tr(' ', '+')}").read)
  cocktail_db.image_url = doc.search('.col-sm-3 a img').first.attribute('src').value unless doc.search('.col-sm-3 a img').empty?
  cocktail_db.save

  [*3..5].sample.times do
    content = Faker::Lorem.paragraph_by_chars([*56..256].sample, false)
    content += Faker::SlackEmoji.people
    review = Review.new(content: content, rating: [*1..5].sample)
    review.cocktail = cocktail_db
    review.save
  end

  cocktail['ingredients'].each_with_index do |dose, dose_index|
    if dose.key?('ingredient')
      ingredient_db = Ingredient.new(name: dose['ingredient'])
      ingredient_db.save
      ingredient_db = Ingredient.find_by(name: dose['ingredient']) unless ingredient_db.save
      dose = Dose.new(description: "#{dose['amount']} #{dose['unit']} of #{dose['label'] || dose['ingredient']}")
      dose.cocktail = cocktail_db
      dose.ingredient = ingredient_db
      p dose
      dose.save
    elsif dose.key?('special')
      special_ingredient = Ingredient.new(name: "Special_#{cocktail_index + 1}_#{dose_index + 1}")
      special_ingredient.save(validate: false)
      dose = Dose.new(description: dose['special'])
      dose.cocktail = cocktail_db
      dose.ingredient = Ingredient.find_by(name: "Special_#{cocktail_index + 1}_#{dose_index + 1}")
      p dose
      dose.save
    end
  end
end
