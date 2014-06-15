require 'sinatra/base'
require 'sinatra/assetpack'
require 'json'
require 'sinatra/reloader' if development?
require 'haml'
require 'redcarpet'

set :public_folder, 'public'

class App < Sinatra::Application
  set :root, File.dirname(__FILE__) # You must set app root

  register Sinatra::AssetPack

  assets {
    serve '/js', from: 'assets/js'
    serve '/css', from: 'assets/css'
    serve '/images', from: 'assets/images'

    # The second parameter defines where the compressed version will be served.
    # (Note: that parameter is optional, AssetPack will figure it out.)
    # The final parameter is an array of glob patterns defining the contents
    # of the package (as matched on the public URIs, not the filesystem)
    js :app, '/js/app.js', [
        '/js/vendor/**/*.js',
        '/js/lib/**/*.js'
    ]

    css :application, '/css/application.css', [
        '/css/screen.css'
    ]

    js_compression :jsmin # :jsmin | :yui | :closure | :uglify
    css_compression :simple # :simple | :sass | :yui | :sqwish
  }

  get '/' do
    haml :index
  end

end