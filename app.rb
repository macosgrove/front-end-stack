require 'sinatra/base'
require 'sinatra/assetpack'
require 'json'
require 'sinatra/reloader' if development?
require "sinatra/json"
require 'haml'
require 'redcarpet'
require './lib/buildbox'

class App < Sinatra::Application
  set :root, File.dirname(__FILE__)
  configure do
    $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
    Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib|
      require File.basename(lib, '.*')
    }
  end

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
        '/js/foundation/foundation.min.js'
    ]

    js :inject, '/js/inject.js', [
        '/js/graph_d3.js',
        '/js/injections/*.js',
        '/js/buildbox_js_hook.js'
    ]

    js :graphd3, '/js/graphd3.js', [
        '/js/graph_d3.js',
        '/js/graph_loader.js'
    ]

    css :application, '/css/app.css', [
        '/css/vendor/normalize.css',
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

  get '/d3/:project/:branch' do
    haml :branchd3
  end

  get '/data/:project/:branch' do
    bb = BranchDurationGraphDataParser.new(BuildBox.new)
    response = bb.fetch_and_parse(params[:project], params[:branch])
    "#{params[:callback]}(#{json response});"
  end

end