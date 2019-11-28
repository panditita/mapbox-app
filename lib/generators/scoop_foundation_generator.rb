class ScoopFoundationGenerator < Rails::Generators::Base

  def add_foundation_javascript
    puts '- SCOOP - adding Foundation to Javascript pack'

    append_file 'app/javascript/packs/application.js', "\n\nrequire('foundation-sites');\n$(document).on('turbolinks:load', function() {\n  $(function(){ $(document).foundation(); });\n});"
  end

  def add_viewport_config
    puts '- SCOOP - configuring Viewport meta tag in application.hml.haml'

    code = "\n\n    %meta{ name: 'viewport', content: 'width=device-width, initial-scale=1, shrink-to-fit=no' }\n\n"
    inject_into_file 'app/views/layouts/application.html.haml', code, after: '%head'
  end

  def add_jquery_to_webpacker
    puts '- SCOOP - adding jquery to webpacker'

    require = "\n\nconst webpack = require('webpack');\n\n"

    inject_into_file 'config/webpack/environment.js', require, before: 'module.exports = environment'

    code = "environment.plugins.append('Provide', new webpack.ProvidePlugin({\n  $: 'jquery',\n  jQuery: 'jquery'\n}));\n\n"

    inject_into_file 'config/webpack/environment.js', code, before: 'module.exports = environment'
  end

end
