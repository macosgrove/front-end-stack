require 'sinatra/base'
require 'sinatra/assetpack'
require 'json'
require 'sinatra/reloader' if development?
require "sinatra/json"
require 'haml'
require 'redcarpet'

class App < Sinatra::Application
  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack

  assets {
    serve '/js', from: 'assets/scripts'
    serve '/css', from: 'assets/stylesheets'
    # serve '/images', from: 'assets/images'

    # The second parameter defines where the compressed version will be served.
    # (Note: that parameter is optional, AssetPack will figure it out.)
    # The final parameter is an array of glob patterns defining the contents
    # of the package (as matched on the public URIs, not the filesystem)
    js :application, '/js/app.js', [
        '/js/vendor/jquery.js',
        '/js/vendor/**/*.js',
        '/js/foundation/foundation.min.js',
        '/js/example.js',
        '/js/graph.js'
    ]

    js :inject, '/js/inject.js', [
        '/js/injections/*.js',
        '/js/buildbox_js_hook.js'
    ]

    css :application, '/css/app.css', [
        '/css/vendor/normalize.css',
        '/css/vendor/rickshaw.css',
        '/css/foundation/foundation.css',
        '/css/*.css'
    ]

    js_compression :jsmin # :jsmin | :yui | :closure | :uglify
    css_compression :sass # :simple | :sass | :yui | :sqwish
  }

  get '/' do
    haml :index
  end

  get '/builds' do

  end

  get '/:project/:branch' do
    haml :branch
  end

  get '/data/:project/:branch' do
    json [ { x: 0, y: 40 }, { x: 1, y: 49 }, { x: 2, y: 17 }, { x: 3, y: 42 } ]
  end

end