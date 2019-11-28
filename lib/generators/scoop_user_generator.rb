class ScoopUserGenerator < Rails::Generators::Base

  def create_user_model
    generate "model", "user email:uniq password:digest --no-fixture"
  end

  def create_seed_user

    new_user = "\n\n\n# USERS\n\nUser.create email: 'king_cone', password: 'bra1nFr33z3@' "
    append_file "#{Rails.root}/db/seeds.rb", new_user
  end

  def set_user_validation
    validation = "\n  validates :email, presence: true, uniqueness: true \n"
    inject_into_file "#{Rails.root}/app/models/user.rb", validation, after: "has_secure_password"
  end

  def set_user_fixture
    fixture = "one:\n  email: one@one.com\n  password_digest: <%= BCrypt::Password.create('one') %>"
    create_file "#{Rails.root}/test/fixtures/users.yml", fixture
  end

end
