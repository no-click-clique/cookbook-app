class Recipe < ApplicationRecord
  # attr_accessor :title, :ingredients, :directions, :prep_time

  # # attr reader method
  # def ingredients
  #   @ingredients
  # end

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
