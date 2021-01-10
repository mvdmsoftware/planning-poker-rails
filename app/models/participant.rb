class Participant < ApplicationRecord
   belongs_to :room, counter_cache: true

   broadcasts_to ->(participant) { [participant.room, :participants] }
end