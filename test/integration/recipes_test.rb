require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "eliane", email: "eliane@example.com")
    @recipe = Recipe.create(name: "Lovely lasagna", description: "mmh very nice lasagna from italy", chef: @chef)
    #same as:
    @recipe2 = @chef.recipes.build(name: "Banana pancakes", description: "made in costa rica")
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should get list of recipes" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text: "Edit Recipe"
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete Recipe"
    assert_select 'a[href=?]', recipes_path, text: "Return"
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "Mole"
    description_of_recipe = "Chocalate sauce traditionally prepared by the Aztec tribe in Mexico"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "reject invalid recipe submission" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: {name: " ", description: " "}}
      assert_template 'recipes/new'
      assert_select 'h2.errors-title'
      assert_select 'div.errors-body'
    end
  end


end
