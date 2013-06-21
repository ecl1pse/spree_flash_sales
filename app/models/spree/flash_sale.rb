class Spree::FlashSale < ActiveRecord::Base
  belongs_to :saleable, polymorphic: true

  validates :name, presence: true
  validates :permalink, presence: true
  validates :end_date, presence: true
  validates :start_date, presence: true
  validates :active, presence: true

  attr_accessible :active, :end_date, :name, :permalink, :start_date, :saleable_id, :saleable_type
end
