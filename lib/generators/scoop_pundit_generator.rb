class ScoopPunditGenerator < Rails::Generators::Base

  def setup_pundit
    generate "pundit:install"
  end

  def clearout_pundit_defaults
    file = "#{Rails.root}/app/policies/application_policy.rb"
    File.delete(file) if File.exist?(file)

    # this puts in placeholders - attrs, init - that can be gsub_ed out
    create_file file, "class ApplicationPolicy\n\n  attrs\n\n  init\n\nend"

    gsub_file file, "attrs", "attr_reader :user, :record"
    gsub_file file, "init", "def initialize user, record\n    @user=user\n    @record=record\n  end"
  end

  def include_in_app
    inject_into_file "#{Rails.root}/app/controllers/application_controller.rb", "\n  include Pundit", after: "ActionController::Base"
  end

end
