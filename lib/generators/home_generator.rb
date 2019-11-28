class HomeGenerator < Rails::Generators::Base
  def create_home_controller
    generate "controller", "home index --no-helper --skip-routes --no-assets --template-engine=haml"
  end

  def set_root
    inject_into_file 'config/routes.rb', after: "# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html" do
      "\n\nroot 'home#index'\n\n"
    end
  end

  def update_test
    gsub_file "#{Rails.root}/test/controllers/home_controller_test.rb", "home_index_url", "root_url"
  end

end
