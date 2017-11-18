require "test_helper"

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Eliane", email: "test@test.de")
  end

  test "should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname shouldbe less than 30 char" do
    @chef.chefname = "x" * 40
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email should not be longer than 255 char" do
    @chef.email ="x" * 200
    assert_not @chef.valid?
  end

  test "email should be valid format" do
    valid_emails = %w[user@example.com MASHRUR@gmail.com m.first@yahoo.ca john+smith@co.uk.org eliane@gmail.berlin]
    valid_emails.each do |valid|
      @chef.email = valid
      assert @chef.valid?, "#{valid.inspect} should be valid"
    end
  end

  test "should reject invalid email addresses" do
    invalid_emails =%w[mashrur@example MASHRUR@example,com jie@bar+foo.de]
    invalid_emails.each do |invalid|
      @chef.email = invalid
      assert_not @chef.valid?, "#{invalid.inspect} should be invalid"
    end
  end

  test "email should be unique and case insensitive" do
    duplicatechef = @chef.dup
    duplicatechef.email = @chef.email.upcase
    @chef.save
    assert_not duplicatechef.valid?
  end

  test "email should be lowercase before saving" do
    mixed_email = "JohN@GmAiL.CoM"
    @chef.email = mixed_email
    @chef.save
    #assert_equal compares two arguments to see if they are the same
    assert_equal mixed_email.downcase, @chef.reload.email
  end

end
