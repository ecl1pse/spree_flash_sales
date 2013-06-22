class Spree::FlashSale < ActiveRecord::Base
  belongs_to :saleable, polymorphic: true

  before_validation :update_permalink

  validates :name, presence: true, uniqueness: true
  validates :permalink, presence: true, uniqueness: true
  validates :end_date, presence: true
  validates :start_date, presence: true
  validates :active, presence: true


  attr_accessible :active, :end_date, :name, :permalink, :start_date, :saleable_id, :saleable_type

  def update_permalink
    self.permalink = "#{name}".parameterize
  end
end
