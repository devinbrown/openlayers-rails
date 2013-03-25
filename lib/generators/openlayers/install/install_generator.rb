module Openlayers
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)
      desc "Install the most recent version of OpenLayers to the Asset Pipeline"

      CURRENT_DIRECTORY = Rails.root
      SOURCE_DIRECTORY   = File.join CURRENT_DIRECTORY, 'openlayers'
      ASSETS_DIRECTORY    = File.join CURRENT_DIRECTORY, 'vendor', 'assets'
      DOCS_DIRECTORY      = File.join CURRENT_DIRECTORY, 'doc'

      # clear old cruft, prepare for updated openlayers files
      def prepare_directories
        FileUtils.rm_rf File.join Rails.root, "openlayers"
      end

      # get the updated openlayers code
      def update_openlayers_submodule
        `git submodule update`
      end

      # place primary OpenLayer JS into 'vendor/assets'
      def build_openlayers
        build_dir = File.join SOURCE_DIRECTORY, 'build'

        # NOTE: will need to make this final name specified by the user
        build_destination = File.join ASSETS_DIRECTORY, 'javascripts', 'openlayers', 'OpenLayers.js'

        FileUtils.mkdir_p File.dirname build_destination
        `cd #{build_dir} && python ./buildUncompressed.py full #{build_destination}`
      end

      # TODO: generate if specified from generate command
      # def copy_extra_files
      #   # license and authors
      #   copy_file File.join(SOURCE_DIRECTORY, "authors.txt"), File.join(CURRENT_DIRECTORY, "authors.txt")
      #   copy_file File.join(SOURCE_DIRECTORY, "LICENSE.txt"), File.join(CURRENT_DIRECTORY, "LICENSE.txt")
      # end

      # place primary OpenLayer images into 'vendor/assets'
      def copy_images
        Dir.glob(File.join(SOURCE_DIRECTORY, "img", "*")).each do |source_file|
          copy_file source_file, File.join(ASSETS_DIRECTORY, "images/openlayers/img/#{source_file.split("/").last}")
        end
      end

      # place default OpenLayer images into 'vendor/assets'
      def copy_default_images
        Dir.glob(File.join(SOURCE_DIRECTORY, "theme", "default", "img", "*")).each do |source_file|
          copy_file source_file, File.join(ASSETS_DIRECTORY, "images/openlayers/theme/default/img/#{source_file.split("/").last}")
        end
      end

      # place OpenLayer stylesheets into 'vendor/assets'
      def copy_stylesheets
        Dir.glob(File.join(SOURCE_DIRECTORY, "theme", "default", "*.css")).each do |source_file|
          copy_file source_file, File.join(ASSETS_DIRECTORY, "stylesheets/openlayers/theme/default/#{source_file.split("/").last}")
        end
      end

      # Remove files used in build process (e.g. updated / downloaded openlayers files)
      def cleanup
        FileUtils.rm_rf File.join Rails.root, "openlayers/*"
      end
    end
  end
end