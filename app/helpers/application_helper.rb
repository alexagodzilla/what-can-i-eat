module ApplicationHelper
  def truncate_zero(ingredient_quantity)
    if ingredient_quantity.to_s.end_with?('.0')
      ingredient_quantity.to_i
    else
      ingredient_quantity.round(2)
    end
  end

  def sort_recipes_by_rating(recipes, low_to_high = false)
    res = recipes.sort_by(&:average_rating)
    low_to_high ? res : res.reverse
  end
end

# db controller view helper
