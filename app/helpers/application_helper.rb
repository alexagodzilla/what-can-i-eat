module ApplicationHelper
  def truncate_zero(ingredient_quantity)
    if ingredient_quantity.to_s.end_with?('.0')
      ingredient_quantity.to_i
    else
      ingredient_quantity.round(2)
    end
  end

  def minutes_to_hour(total_time)
    "1h" if total_time == 60
    total_time > 60 ? "#{total_time / 60}h #{total_time - ((total_time / 60) * 60)}m" : "#{total_time}m"
  end
end
