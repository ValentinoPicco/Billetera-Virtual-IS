class Pig < ActiveRecord::Base
  belongs_to :account

  validates :creation_date, presence: true
end