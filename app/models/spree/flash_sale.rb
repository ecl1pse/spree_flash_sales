class Spree::FlashSale < ActiveRecord::Base
  belongs_to :saleable, polymorphic: true

  validates :name, presence: true
  validates :end_date, presence: true
  validates :start_date, presence: true

  attr_accessible :active, :end_date, :name, :permalink, :start_date, :saleable_id, :saleable_type

  scope :live, lambda { where("start_date <= :start_date AND end_date >= :end_date AND active = :active ", {start_date: DateTime.now.in_time_zone, end_date: DateTime.now.in_time_zone, active: true}) }

  def live?
    return false if !self.active?
    self.start_date.in_time_zone <= DateTime.now.in_time_zone && self.end_date.in_time_zone >= DateTime.now.in_time_zone
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def taxon?
    self.saleable_type == "Spree::Taxon"
  end

  def product?
    self.saleable_type == "Spree::Product"
  end
end
