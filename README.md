# OpenLayers for Rails 3.1 Asset Pipeline

The [OpenLayers](http://openlayers.org/) library packaged for use with Ruby on Rails' Asset Pipeline.

## Installing the Gem

```ruby
gem 'openlayers-rails'
```

```
bundle install
```

## Usage

Add the following to your `application.js` manifest file:

```js
//= require openlayers-rails`
```

## Generator Usage

For general maintenance or customized **OpenLayer** library configuration, see the following `rails generator` commands.

### Updating OpenLayers Libraries

```
rails generator openlayers:update
```

### Customizing OpenLayers Libraries