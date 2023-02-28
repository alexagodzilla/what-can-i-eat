module ApplicationHelper
  def truncate_zero(ingredient_quantity)
    if ingredient_quantity.to_s.end_with?('.0')
      ingredient_quantity.to_i
    else
      ingredient_quantity.round(2)
    end
  end
end
