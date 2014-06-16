Front-End Stack: An opinionated starting point for a Ruby/Sinatra front end web app
============================

The Stack
-------

* [Ruby](http://www.ruby-doc.org/core-2.1.2/)
* [Sinatra](http://www.sinatrarb.com/)
* [RSpec](https://www.relishapp.com/rspec/rspec-core/v/2-99/docs/)
* [Thin](http://code.macournoyer.com/thin/)
* [Foundation](http://foundation.zurb.com/)
* [Haml](http://haml.info/)
* [Sass](http://sass-lang.com/)
* [CoffeeScript](http://coffeescript.org/)
* [Assetpack](https://github.com/rstacruz/sinatra-assetpack)


Install
-------

Clone the repo  
```
git clone https://github.com/macosgrove/front-end-stack
```

Change directory into the project repo  
```
cd front-end-stack
```

Install gems  
```
bundle install
```

Run
---

Change directory into the project repo  
```
cd front-end-stack
```

Start the Sinatra server  
```
rackup config.ru
```
### Browse to http://localhost:5555/

Rake tasks!
-----------

Run the specs  
```
rake spec
```
