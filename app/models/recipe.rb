class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :instructions

  accepts_nested_attributes_for :ingredients, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :instructions, reject_if: proc { |attributes| attributes['step'].blank? }, allow_destroy: true

  validates :title, :description, :image, presence: true

  has_attached_file :image, styles: { medium: '350x200#', large: '800x500#' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
