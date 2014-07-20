class User
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :email, :password

  validates :email, presence: true
  validates :password, presence: true

  def initialize(attributes={})
    @email = attributes[:email]
    @password = attributes[:password]
  end

end

