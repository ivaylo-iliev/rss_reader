class Entry < ApplicationRecord
  belongs_to :feed
  self.skip_time_zone_conversion_for_attributes = [:published]
end
