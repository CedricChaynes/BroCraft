class Booking < ApplicationRecord
  belongs_to :user, class_name: "Renter",
                      foreign_key: "renter_id"
  belongs_to :tool
end





# class User
#   has_many :owner_tools
# end
# => OnwerTool model => class_name => 'Tool'
# => user_id => foreign_key => 'ower_id'




# class Tool
#   belongs_to :ower
# end
# => Model Owner => class_name => 'User'
# => owner_id => true (foreign_key)
