class Place < ActiveRecord::Base

  belongs_to :user
  has_many :comments

  geocoded_by :address
  after_validation :geocode
  validates :name, presence: { message: "Name is a required field"}, length: {minimum: 4, message: "Name has to be at least 3 characters"}
  validates :address, presence: { message: "Address is a required field"}
  validates :description, presence: { message: "Description is a required field"}



end
