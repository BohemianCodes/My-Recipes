require "test_helper"

class RecipeTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.create!(chefname: "eliane", email: "eliane@gmx.de")
    @recipe = @chef.recipes.build(name: "Vegetable Soup", description: "great veggie soup")
  end

  test "recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "description should be < 500 char" do
    @recipe.description = "x" * 3000
    assert_not @recipe.valid?
  end

  test "description should be > 5 char" do
    @recipe.description = "x" * 3
    assert_not @recipe.valid?
  end



end
