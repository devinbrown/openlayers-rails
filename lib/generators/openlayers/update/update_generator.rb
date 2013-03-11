# # TODO: extract module
# module Thor::Actions
#   def source_paths
#     [File.join(Rails.root, "openlayers")]
#   end
# end

module Openlayers
  module Generators
    class UpdateGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)
      desc "This updates the local OpenLayers library"

      CURRENT_DIRECTORY = Rails.root

      # source_path() ?
      SOURCE_DIRECTORY   = File.join CURRENT_DIRECTORY, 'openlayers'

      # destination_root() ?
      ASSETS_DIRECTORY    = File.join CURRENT_DIRECTORY, 'vendor', 'assets'
      DOCS_DIRECTORY      = File.join CURRENT_DIRECTORY, 'doc'

      def prepare_directories
        FileUtils.rm_rf File.join Rails.root, "openlayers"
      end

      def update_openlayers_submodule
        puts "Updating sources..."
        `git submodule update`
      end

      def trash_vendored_assets
        # FIXME: this will destroy ALL vendored assets, not sure if this is acutally needed
        # puts "Trashing the old stuff..."
        # FileUtils.rm_r Dir.glob(File.join ASSETS_DIRECTORY, '*')
      end

      def build_openlayers
        puts "Building the main JS file..."
        build_dir = File.join SOURCE_DIRECTORY, 'build'
        # NOTE: will need to make this final name specified by the user
        build_destination = File.join ASSETS_DIRECTORY, 'javascripts', 'openlayers', 'OpenLayers.js'

        # NOTE: looks like we've found a way to build this mofo!
        # mkdir_p = final dest. + all parents
        # FIXME: "sh: line 0: cd: /Users/dgb/Dropbox/development/openlayers-rails/openlayers/build: No such file or directory"
        # FIXME: "python: can't open file './buildUncompressed.py': [Errno 2] No such file or directory"
        FileUtils.mkdir_p File.dirname build_destination
        `cd #{build_dir} && python ./buildUncompressed.py full #{build_destination}`
      end

      def copy_extra_files
        # license and authors
        copy_file File.join(SOURCE_DIRECTORY, "authors.txt"), File.join(CURRENT_DIRECTORY, "authors.txt")
        copy_file File.join(SOURCE_DIRECTORY, "LICENSE.txt"), File.join(CURRENT_DIRECTORY, "LICENSE.txt")
      end

      def copy_images
        Dir.glob(File.join(SOURCE_DIRECTORY, "img", "*")).each do |source_file|
          copy_file source_file, File.join(ASSETS_DIRECTORY, "images/openlayers/img/#{source_file.split("/").last}")
        end
      end

      def copy_default_images
        Dir.glob(File.join(SOURCE_DIRECTORY, "theme", "default", "img", "*")).each do |source_file|
          copy_file source_file, File.join(ASSETS_DIRECTORY, "images/openlayers/theme/default/img/#{source_file.split("/").last}")
        end
      end

      def copy_stylesheets
        Dir.glob(File.join(SOURCE_DIRECTORY, "theme", "default", "*.css")).each do |source_file|
          copy_file source_file, File.join(ASSETS_DIRECTORY, "stylesheets/openlayers/theme/default/#{source_file.split("/").last}")
        end
      end

      # Remove files used in build process
      def cleanup
        FileUtils.rm_rf File.join Rails.root, "openlayers"
      end
    end
  end
end