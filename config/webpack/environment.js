const { environment } = require('@rails/webpacker')

module.exports = environment

// Exclude node_modules folder from babel-loader processing.
environment.loaders.delete('nodeModules');
