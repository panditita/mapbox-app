class ConvertHamlGenerator < Rails::Generators::Base
  def convert_haml
    generate "haml:application_layout", "convert"
  end

  def remove_erb_layout
    File.delete("#{Rails.root}/app/views/layouts/application.html.erb") if File.exist?("#{Rails.root}/app/views/layouts/application.html.erb")
  end
end
