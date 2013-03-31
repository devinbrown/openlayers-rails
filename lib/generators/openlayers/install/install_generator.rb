module Openlayers
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install the most recent version of OpenLayers to the Asset Pipeline"

      source_root File.expand_path("../templates", __FILE__)

      def add_javascript
        js_dest = "vendor/assets/javascripts"
        copy_file "js/Openlayers.js", "#{js_dest}/OpenLayers.js"
      end

      # TODO: allow for users to select default CSS for initial install
      def add_stylesheets
        ss = "vendor/assets/stylesheets/theme/default/style.css"
        copy_file "css/style.css", ss
      end

      # FIXME: not creating in the correct directory on remote install
      def add_images
        img_dest = "vendor/assets/images/img"
        img_source = File.join source_paths, "img"
        Dir.glob("#{img_source}/*").each do |f|
          copy_file "img/#{File.basename f}", "#{img_dest}/#{File.basename f}"
        end
      end

      def include_js_manifest
      
        js_manifest = "vendor/assets/javascripts/application.js"
        
        if File.exist?(js_manifest)
          content = File.read js_manifest
          unless content.match(/require OpenLayers/)
            insert_into_file js_manifest, "//= require OpenLayers"
          end
        else
          copy_file 'application.js', js_manifest
        end
      end 

      def include_css_manifest

        css_manifest = "vendor/assets/stylesheets/application.css"

        if File.exist?(css_manifest)
          content = File.read css_manifest
          unless content.match(/require theme\/default\/style/)
            insert_into_file css_manifest, "/* require theme/default/style */"
          end
        else
          copy_file 'application.css', css_manifest
        end
      end
    end
  end
end

