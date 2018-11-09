class Feed < ApplicationRecord
  has_many :entries, dependant: :destroy
end
