require 'securerandom'

class Room < ApplicationRecord
   before_create :generate_unique_room_identifier

   has_many :estimates, dependent: :delete_all

   private 
   
   def generate_unique_room_identifier
      generated_identifier = SecureRandom.hex(5)

      if Room.exists?(unique_identifier: generated_identifier)
         generate_unique_room_identifier() 
      else
         self.unique_identifier = generated_identifier
      end
   end
end
