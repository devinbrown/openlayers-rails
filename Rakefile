require "bundler/gem_tasks"
require "fileutils"

desc "Update included OpenLayers sources"
task :update_from_source do
  current_directory = File.expand_path File.dirname(__FILE__)
  source_directory  = File.join current_directory, 'openlayers'
  assets_directory  = File.join current_directory, 'vendor', 'assets'
  docs_directory    = File.join current_directory, 'doc'

  puts "Updating sources..."

  `git submodule update`

  puts "Trashing the old stuff..."

  # FIXME: this will destroy all vendored assets
  FileUtils.rm_r Dir.glob(File.join assets_directory, '*')

  puts "Building the main JS file..."

  build_dir         = File.join source_directory, 'build'
  build_destination = File.join assets_directory, 'javascripts', 'openlayers', 'OpenLayers.js'

  # NOTE: looks like we've found a way to build this mofo!
  FileUtils.mkdir_p File.dirname build_destination
  `cd #{build_dir} && python ./buildUncompressed.py full #{build_destination}`

  puts "Copying over other files..."

  ["authors.txt", "license.txt"].each do |file|
    FileUtils.cp File.join(source_directory, file), File.join(current_directory, file)
  end

  {
    "img/*"               => File.join(assets_directory, "images/openlayers/img"),
    "theme/default/img/*" => File.join(assets_directory, "images/openlayers/theme/default/img"),
    "theme/default/*.css" => File.join(assets_directory, "stylesheets/openlayers/theme/default"),
    "licenses/*"          => File.join(docs_directory, "licenses")
  }.each do |source, destination|
    FileUtils.mkdir_p destination
    FileUtils.cp_r Dir.glob(File.join source_directory, source), destination
  end

  puts "Done! Now update version information and release!"
end
