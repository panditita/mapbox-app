class ErrorsGenerator < Rails::Generators::Base

  # class_option :email, type: :string, default: 'info@icecreamarchitecture.com'

  # @email = options.email

  FILES = [
    'internal_server_error.html.haml',
    # 'not_authorized.html.haml',
    'not_found.html.haml',
    'unacceptable.html.haml',
  ]

  def create_error_routes
    puts 'Creating Error Routes'

    inject_into_file 'config/routes.rb', after: "root 'home#index'" do
      "\n\n# ERRORS"
    end

    routes = [
      "\nmatch '/404', to: 'errors#not_found', via: :all, as: 'not_found'",
      "\nmatch '/422', to: 'errors#unacceptable', via: :all, as: 'unacceptable'",
      "\nmatch '/500', to: 'errors#internal_server_error', via: :all, as: 'error'",
    ]

    routes.each do |code|
      inject_into_file 'config/routes.rb', after: "# ERRORS" do
        code
      end
    end

  end

  def create_error_controller
    puts 'Creating Errors Controller'

    generate "controller", "errors not_found unacceptable internal_server_error --no-helper --skip-routes --no-assets"
  end

  def replace_views
      prefix = "#{Rails.root}/lib/generators/errors/"
      dest = "#{Rails.root}/app/views/errors"
      FILES.each do |v|
        filename = prefix + v
        FileUtils.cp filename, dest
      end
  end

  # TODO - set contact email in error views
  # def set_contact_email
  #   to_change = [
  #     "internal_server_error",
  #     "unacceptable",
  #   ]
  #   prefix = "#{Rails.root}/app/views/errors/"
  #   to_change.each do |f|
  #     filename = prefix + f
  #     gsub_file filename, "INSERT_EMAIL_ADDRESS", @email
  #   end
  # end

  def set_rescuer_and_login_required_files
    puts 'Copying Rescuer and LoginRequired to controllers/concerns'

    ['rescuer', 'login_required'].each do |f|
      FileUtils.cp "#{Rails.root}/lib/generators/#{f}.rb", "#{Rails.root}/app/controllers/concerns/#{f}.rb"
    end
  end

  def add_concerns
    puts 'Include Rescuer and LoginRequired in ApplicationController'

    ["include LoginRequired", "include Rescuer"].each do |inc|
      inject_into_file 'app/controllers/application_controller.rb', after: 'class ApplicationController < ActionController::Base' do
        "\n  #{inc}"
      end
    end
  end

  def remove_error_prefix_from_test_urls
    urls = [
      'errors_not_found_url',
      'errors_unacceptable_url',
      'errors_internal_server_error_url'
    ]

    urls.each do |u|
      gsub_file 'test/controllers/errors_controller_test.rb', u, u.gsub(/errors_/, '')
    end
  end

  def rename_internal_server_error_url
    gsub_file 'test/controllers/errors_controller_test.rb', 'internal_server_error_url', 'error_url'
  end


end
