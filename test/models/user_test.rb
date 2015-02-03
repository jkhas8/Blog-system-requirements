require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Nguyen Tan Thai", email: "nguyen.tan.thai@framgia.com")
  end

  test "should be valid" do
    assert @user.valid?
  end
end
