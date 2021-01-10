class Estimate < ApplicationRecord
  belongs_to :room

  broadcasts_to ->(estimate) { [estimate.room, :estimates] }
end
