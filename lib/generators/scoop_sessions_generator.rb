class ScoopSessionsGenerator < Rails::Generators::Base

  def generate_controller
    puts '- SCOOP - Generating Controller'

    generate "controller", "sessions --no-helper --skip-routes --no-assets -s"
  end

  def setup_routes
    src = "#{Rails.root}/lib/generators/scoop_sessions_controller.rb"
    dest = "#{Rails.root}/app/controllers/sessions_controller.rb"
    FileUtils.cp src, dest
  end


  # # inserting code by iterating (as in configure_destroy_route) doesn't work here, as Rails thinks the 'end' within the loop replaces the 'end' closing 'def ...'
  # def configure_new_route
  #   puts '- SCOOP - writing NEW route'
  #
  #   new_code = "\n    if current_user\n      redirect_to root_path, notice: 'Welcome ' + current_user.email + '!'\n    end"
  #
  #   inject_into_file 'app/controllers/sessions_controller.rb', new_code, after: 'def new'
  # end
  #
  #
  # # inserting code by iterating (as in configure_destroy_route) doesn't work here, as Rails thinks the 'end' within the loop replaces the 'end' closing 'def ...'
  # def configure_create_route
  #   puts '- SCOOP - writing CREATE route'
  #
  #   create_code = "\n    user = User.find_by_email params[:email]\n\n    if user && user.authenticate(params[:password])\n      session[:user_id] = user.id\n      redirect_to root_path, notice: 'Logged In'\n    else\n      flash.now[:alert] = 'Email or Password is invalid'\n      render 'new'\n    end"
  #
  #   inject_into_file 'app/controllers/sessions_controller.rb', create_code, after: 'def create'
  # end
  #
  #
  # def configure_destroy_route
  #
  #   # DESTROY
  #   puts '- SCOOP - writing DESTROY route'
  #
  #   destroy_code = [
  #     "\n    session[:user_id] = nil",
  #     "\n    redirect_to root_url, notice: 'Logged out!'"
  #   ]
  #
  #   destroy_code.reverse.each do |c|
  #     inject_into_file 'app/controllers/sessions_controller.rb', c, after: 'def destroy'
  #   end
  # end


  def set_routes
    puts '- SCOOP - Setting Sessions routes'

    routes = [
      "\n  get 'login', to: 'sessions#new', as: 'login'",
      "\n  post 'login', to: 'sessions#create', as: 'create_login'",
      "\n  get 'logout', to: 'sessions#destroy', as: 'logout'\n\n",
    ]

    routes.each do |r|
      inject_into_file 'config/routes.rb', r, before: 'end'
    end
  end


  # Called within
  def setup_pundit
    puts '- SCOOP - Running Pundit Generator'
    generate "scoop_pundit"
  end


  def set_auth_skips
    puts '- SCOOP - Adding skip_verify_authorized to home and sessions controllers'

    route = "app/controllers/"
    skip = "\n  skip_after_action :verify_authorized\n"
    after = "ApplicationController"
    inject_into_file "#{route}home_controller.rb", skip, after: after
    inject_into_file "#{route}sessions_controller.rb", skip, after: after
    inject_into_file "#{route}errors_controller.rb", skip, after: after
  end


  def configure_application_controller
    # add current_user
    puts '- SCOOP - Configuring ApplicationController'

    code = "\n  protect_from_forgery with: :exception\n  after_action :verify_authorized\n  helper_method :current_user\n\n  def current_user\n    # handles bug where user was deleted before session ended\n    if session[:user_id] && User.exists?(session[ :user_id])\n      @current_user ||= User.find(session[:user_id])\n    else\n      @current_user = nil\n    end\n  end\n\n"

    inject_into_file "app/controllers/application_controller.rb", code, before: 'end'
  end


  def add_alert_to_new_view
    puts '- SCOOP - Adding #alert div to sessions#new view'

    file = "#{Rails.root}/app/views/sessions/new.html.haml"
    prepend_file file, "%p#alert\n  = alert\n\n" if File.exist?(file)
  end

  def copy_test_files
    puts '- SCOOP - Copying test files'
    src = "#{Rails.root}/lib/generators/tests/sessions_controller_tests.rb"
    dest = "#{Rails.root}/test/controllers/sessions_controller_test.rb"
    FileUtils.cp src, dest
  end


  def config_test_env
    puts '- SCOOP - Add mocha/minitest to test_helper'

    inject_into_file 'test/test_helper.rb', after: "require 'rails/test_help'" do
      "\nrequire 'mocha/minitest'"
    end
  end


  def add_test_login_method
    puts '- SCOOP - Addding login method to test_helper'

    code = "\n\nclass ActionDispatch::IntegrationTest\n  def login user\n    ApplicationController.any_instance.stubs(:current_user).returns(user)\n    user\n  end\nend"

    append_file 'test/test_helper.rb', code
  end



end
