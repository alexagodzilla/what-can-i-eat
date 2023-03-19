class RecipesController < ApplicationController
  def index
    if params[:query].present?
      params[:ingredient_id].present? ? search(params[:query], params[:ingredient_id]) : search(params[:query])
    elsif params[:ingredient_id].present?
      search("", params[:ingredient_id])
    elsif params.values.include?("1") && params[:query].empty?
      empty_query
    else
      @recipes = Recipe.where(id: popular_recipes_ids)
    end
  end

  def show
    @chatroom = Chatroom.first
    @bookmark = Bookmark.new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
    @user_bookmarks = Bookmark.where(user: current_user)
    @friendship = Friendship.new
  end

  private

  def search(params_query, user_ingredient = "")
    user_ingredient.map! { |id| Ingredient.find(id).name }.join(" ") if user_ingredient.length.positive?
    if params.values.include?("1")
      arr = params.select { |_key, value| value == "1" }.keys
      @recipes = Recipe.search_recipes("#{params_query} #{user_ingredient}").where(arr.to_h { |key| [key, true] })
    else
      @recipes = Recipe.search_recipes("#{params_query} #{user_ingredient}")
    end
  end

  def empty_query
    arr = params.select { |_key, value| value == "1" }.keys
    @recipes = Recipe.where(arr.to_h { |key| [key, true] })
  end

  def popular_recipes_ids
    Recipe.where(title: "Easy Eggplant Curry").pluck(:id) +
      Recipe.where(title: "Dolsot Bibimbap").pluck(:id) +
      Recipe.where(title: "Smokey Rainbow Chili").pluck(:id) +
      Recipe.where(title: "Vietnamese Pancakes with Vegetables, Herbs and a Fragrant Dipping Sauce (Bánh Xèo)").pluck(:id) +
      Recipe.where(title: "Super Speedy Spicy Sweet and Sour Shrimp").pluck(:id) +
      Recipe.where(title: "Spaghetti Squash & Tomato Basil Meat Sauce").pluck(:id) +
      Recipe.where(title: "Caldo Verde - Portuguese Kale Soup").pluck(:id) +
      Recipe.where(title: "Grilled Fish With Sun Dried Tomato Relish").pluck(:id)
  end
  # other less minging recipes: Thai Savory Brown Fried Rice; Kale & chickpea stew with cumin, smoked paprika and lime
end
