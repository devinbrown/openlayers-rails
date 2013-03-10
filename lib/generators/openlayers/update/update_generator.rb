module Openlayers
  module Generators
    class UpdateGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      current_directory = File.expand_path File.join File.dirname(__FILE__), "..", "..", "..", ".."
      source_directory  = File.join current_directory, 'openlayers'
      assets_directory  = File.join current_directory, 'vendor', 'assets'
      docs_directory    = File.join current_directory, 'doc'

      puts "Updating sources..."

      # git submodule taps into the most recent OpenLayer version via git repo
      `git submodule update`

      puts "Trashing the old stuff..."

      # FIXME: this will destroy all vendored assets
      FileUtils.rm_r Dir.glob(File.join assets_directory, '*')

      puts "Building the main JS file..."

      build_dir         = File.join source_directory, 'build'
      # NOTE: will need to make this final name specified by the user
      build_destination = File.join assets_directory, 'javascripts', 'openlayers', 'OpenLayers.js'

      # NOTE: looks like we've found a way to build this mofo!
      # mkdir_p = final dest. + all parents
      # FIXME: "sh: line 0: cd: /Users/dgb/Dropbox/development/openlayers-rails/openlayers/build: No such file or directory"
      # FIXME: "python: can't open file './buildUncompressed.py': [Errno 2] No such file or directory"
      FileUtils.mkdir_p File.dirname build_destination
      `cd #{build_dir} && python ./buildUncompressed.py full #{build_destination}`

      puts "Copying over other files..."

      # FIXME: "No such file or directory - /Users/dgb/Dropbox/development/openlayers-rails/openlayers/authors.txt"
      # FIXME: "No such file or directory - /Users/dgb/Dropbox/development/openlayers-rails/openlayers/license.txt"
      # copy author and lisence from (updated) source_directory to deployment directory (current_directory, based of gem)
      # ["authors.txt", "license.txt"].each do |file|
      #   FileUtils.cp File.join(source_directory, file), File.join(current_directory, file)
      # end

      # appears to be copying relevant files from "openlayers" to vendor/assets
      # source => destination
      {
        "img/*"               => File.join(assets_directory, "images/openlayers/img"),
        "theme/default/img/*" => File.join(assets_directory, "images/openlayers/theme/default/img"),
        "theme/default/*.css" => File.join(assets_directory, "stylesheets/openlayers/theme/default"),
        "licenses/*"          => File.join(docs_directory, "licenses")
      }.each do |source, destination|
        FileUtils.mkdir_p destination
        FileUtils.cp_r Dir.glob(File.join source_directory, source), destination
      end

      # TODO: need to clean up files that were used for precompiling, especially if running rake task from gem'd loc
      puts "Done! Now update version information and release!"
    end
  end
end