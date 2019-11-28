class ScoopGemsGenerator < Rails::Generators::Base
  def add_scoop_gems

    # REPLACE SASS-RAILS
    gsub_file 'Gemfile', "gem 'sass-rails', '~> 5'", "gem 'sassc-rails'"

    # UNCOMMENT BCRYPT
    gsub_file 'Gemfile', "# gem 'bcrypt', '~> 3.1.7'", "gem 'bcrypt', '~> 3.1.7'"

    # UNCOMMENT IMAGE PROCESSING
    gsub_file 'Gemfile', "# gem 'image_processing', '~> 1.2'", "gem 'image_processing', '~> 1.2'"

    # EXTRA GEMS
    inject_into_file 'Gemfile', after: "gem 'bootsnap', '>= 1.4.2', require: false\n\n" do
      "# EXTRAS\ngem 'haml', '~> 5.0.4'\ngem 'haml-rails', '~> 2.0'\ngem 'foundation-rails', '~> 6.5.3.0'\ngem 'autoprefixer-rails', '~> 9.5.1'\ngem 'pundit', '~> 2.0.1'\ngem 'font-awesome-rails'\ngem 'jquery-rails'\n\n"
    end

    inject_into_file "Gemfile", "\n  gem 'mocha'", after: "group :test do"
  end
end
