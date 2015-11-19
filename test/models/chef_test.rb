require "test_helper"

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(name: "john", email: "john@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chef name should be present" do
    @chef.name = " "
    assert_not @chef.valid?
  end
  
  test "chef name should not be too long" do
    @chef.name = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chef name should not be too short" do
    @chef.name = "aa"
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email length should be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
    valid_addresses.each do |e|
      @chef.email = e
      assert @chef.valid?, '#{e.inspect} should be valid'
    end
  end
  
  test "email validation should reject valid addresses" do
    invalid_addresses = %w[user@eee,com R_TDD-DS_at_eee.hello.org user@example first.last@i_am_.au laura+joe@ee+aa.cm]
      invalid_addresses.each do |e|
        @chef.email = e
        assert_not @chef.valid?, '#{e.inspect} should be invalid'
      end
  end
end