require 'securerandom'

class Room < ApplicationRecord
   before_create :generate_unique_room_identifier

   has_many :participants, dependent: :delete_all

   broadcasts_to ->(room) { room }

   def hide!
      self.is_hidden = true
      self.save
   end

   def reveal!
      self.is_hidden = false
      self.save
   end

   def hidden?
      self.is_hidden
   end

   def revealed?
      !self.hidden?
   end

   private

   def generate_unique_room_identifier
      unless self.unique_identifier.present?
         generated_identifier = SecureRandom.hex(5)

         if Room.exists?(unique_identifier: generated_identifier)
            generate_unique_room_identifier
         else
            self.unique_identifier = generated_identifier
         end
      end
   end
end
