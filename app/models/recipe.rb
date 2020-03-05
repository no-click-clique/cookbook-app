class Recipe < ApplicationRecord

  validates :title, presence: true
  validates :prep_time, numericality: true

  # # attr reader method
  # def ingredients
  #   @ingredients
  # end

  # reutrns a hash of data of whoever created THIS recipe
  belongs_to :user

  def ingredients_list
    ingredients.split(", ")
  end

  def directions_list
    directions.split(", ")
  end

  def friendly_created_at
    created_at.strftime("%b %d, %Y")
  end

  def friendly_prep_time
    hours = prep_time / 60
    minutes = prep_time % 60
    result = ""
    result += "#{hours} hours " if hours > 0
    result += "#{minutes} minutes" if minutes > 0
    result
  end

end
