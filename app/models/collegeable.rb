class Collegeable < ApplicationRecord
  belongs_to :faculty
  belongs_to :college
end