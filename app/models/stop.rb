class Stop < ActiveRecord::Base
  validates :name, presence: true
  validates :name, length: { in: 1..50 }
  validates :name, uniqueness: true
end
