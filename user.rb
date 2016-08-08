class User
  attr_accessor :email

  def initialize(email)
    self.email = email
  end

  def self.authenticate(email, pass)
    if pass == 'password'
      User.new(email)
    else
      nil
    end
  end
end
