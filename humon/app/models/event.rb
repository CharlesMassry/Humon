class Event < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  
  has_many :attendances
  has_many :users, through: :attendances

  validates :name, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
  validates :started_at, presence: true
end
