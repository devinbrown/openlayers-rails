module Openlayers
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install the most recent version of OpenLayers to the Asset Pipeline"

      # TODO: test this as repo'd gem (not locally installed)
      source_root File.expand_path("../../../../../vendor/assets", __FILE__)

      def add_javascript
        js_dest = "vendor/assets/javascripts"
        copy_file "javascripts/Openlayers.js", "#{js_dest}/OpenLayers.js"
      end

      # TODO: allow for users to select default CSS for initial install
      def add_stylesheets
        ss = "vendor/assets/stylesheets/theme/default/style.css"
        copy_file "stylesheets/theme/default/style.css", ss
      end

      def add_images
        img_dest = "vendor/assets/images/img"
        img_source = File.join source_paths, "images", "img"
        Dir.glob("#{img_source}/*").each do |f|
          copy_file "images/img/#{File.basename f}", "#{img_dest}/#{f}"
        end
      end

      # TODO: gsub / update respective manifests based on included files
    end
  end
end
