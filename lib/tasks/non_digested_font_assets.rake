# Rails4 doesn't create un-fingerprinted assets anymore, but we
# need a couple for umlaut's API. Let's try to hook in and make
# symlinks.
#
require 'pathname'


# Every time assets:precompile is called, trigger umlaut:create_non_digest_assets afterwards.
Rake::Task["assets:precompile"].enhance do
  Rake::Task["assets:create_non_digested_assets"].invoke
end

namespace :assets do

  # This seems to be basically how ordinary asset precompile
  # is logging, ugh.
  logger = Logger.new($stderr)

  # Based on suggestion at https://github.com/rails/sprockets-rails/issues/49#issuecomment-20535134
  # but limited to files in umlaut's namespaced asset directories.
  task :create_non_digested_assets => :"assets:environment"  do
    manifest_path = Dir.glob(File.join(Rails.root, 'public/assets/manifest-*.json')).first
    manifest_data = JSON.load(File.new(manifest_path))

    manifest_data["assets"].each do |logical_path, digested_path|
      logical_pathname = Pathname.new logical_path

      full_digested_path    = File.join(Rails.root, 'public/assets', digested_path)
      full_nondigested_path = File.join(Rails.root, 'public/assets', logical_path)

      logger.info "Copying to #{full_nondigested_path}"

      # Use FileUtils.copy_file with true third argument to copy
      # file attributes (eg mtime) too, as opposed to FileUtils.cp
      # Making symlnks with FileUtils.ln_s would be another option, not
      # sure if it would have unexpected issues.
      FileUtils.copy_file full_digested_path, full_nondigested_path, true
    end

  end
end
