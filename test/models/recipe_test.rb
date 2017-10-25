require "test_helper"

class RecipeTest < ActiveSupport::TestCase

  def setup
   @recipe = Recipe.new(name: "Vegetable Soup", description: "great veggie soup")
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
