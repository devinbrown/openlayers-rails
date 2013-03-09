# OpenLayers-Rails Dev Notes

## Current Functionality

- [gem: ol-rails](http://rubygems.org/gems/openlayers-rails)
- [github: ol-rails](https://github.com/tmikoss/openlayers-rails)
  - poor / little support

### Questions

- what's the current process for adding OL to a native rails application
  - don't forget about **production**
- big picture, how does it work?
- **label what needs to be done and what doesn't**
- integrate & function w/ rails?

## Desired Functionality

### Customized Build Functionality

- utilize the ability to build custom OL libraries
- specify required OL functionality in YAML file?
- utilize the current python build tool provided by OL…**better idea, convert to a thor / rake / generator task**

### Better documentation

current documentation is pretty weak

### Proposed Workflow

1. install gem
2. config YAML for build preferences (optional)
2. generate library files via rake / generate / etc
3. apply OL library to respective locations


# HURM

Need to build the files before including them. Use the python script for now, or build a more robust ruby script?

Currently including the CSS styling elements into the asset pipeline automatically. **Good.** Loading the `OpenLayer.js` file via:

**openlayer-rails.js**

```
//= require openlayers/OpenLayers

OpenLayers._getScriptLocation = function(){ return '/assets/openlayers/'; };
```

ref. [OpenLayers._getScriptLocation()](http://dev.openlayers.org/docs/files/OpenLayers-js.html#OpenLayers._getScriptLocation)

Problem is, gem'd files are included "magically", need to intercept this process before they're applied