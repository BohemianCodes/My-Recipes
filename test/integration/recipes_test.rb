require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "eliane", email: "eliane@example.com")
    @recipe = Recipe.create(name: "lovely lasagna", description: "mmh very nice lasagna from italy", chef: @chef)
    #same as:
    @recipe2 = @chef.recipes.build(name: "banana pancakes", description: "made in costa rica")
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should get list of recipes" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end



end
