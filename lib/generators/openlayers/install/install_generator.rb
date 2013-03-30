# FIXME: refactor / simplify / make more Thorsy
module Openlayers
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install the most recent version of OpenLayers to the Asset Pipeline"

      source_root File.expand_path("../../../../../vendor/assets", __FILE__)

      JS_PATH = File.join source_root, "javascripts"
      CSS_PATH = File.join source_root, "stylesheets"
      IMG_PATH = File.join source_root, "images"

      def add_javascript
        copy_file "javascripts/Openlayers.js", "vendor/assets/javascripts/OpenLayers.js"
      end

      def add_stylesheets
      end

      def add_images
      end
    end
  end
end
