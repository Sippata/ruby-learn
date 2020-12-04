class UserEmailForm
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true

  def user
    User.find_by_email(email)
  end
end
