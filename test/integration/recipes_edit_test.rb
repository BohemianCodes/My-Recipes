require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "eliane", email: "eliane@example.com")
    @recipe = Recipe.create(name: "Lovely lasagna", description: "mmh very nice lasagna from italy", chef: @chef)
  end

  test "reject invalid recipes update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "hello"} }
    assert_template 'recipes/edit'
    assert_select 'h2.errors-title'
    assert_select 'div.errors-body'
  end

  test "successfully added recipe" do

  end

end
