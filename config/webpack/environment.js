const { environment } = require('@rails/webpacker')



const webpack = require('webpack');


///////////////////////////////////////////////////////////////////////////////

// EXCLUDE MAPBOX from babel transpilation
// Solution from:
//    https://github.com/rails/webpacker/issues/1903#issuecomment-456862100
//    and
//    https://github.com/lewagon/rails-templates/issues/78

const nodeModulesLoader = environment.loaders.get('nodeModules')
if (!Array.isArray(nodeModulesLoader.exclude)) {
  nodeModulesLoader.exclude = (nodeModulesLoader.exclude == null)
    ? []
    : [nodeModulesLoader.exclude]
}
nodeModulesLoader.exclude.push(/mapbox-gl/)

// to exclude all nodeModules:
// environment.loaders.delete('nodeModules')



environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery'
}));

module.exports = environment
