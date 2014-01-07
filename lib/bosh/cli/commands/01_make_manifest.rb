require "bosh/manifests"

module Bosh::Cli::Command
  class Manifests < Base
    include Bosh::Cli::Validation
    include Bosh::Manifests

    usage "manifests"
    desc "Show the list of available manifests"
    def manifests
      setup_manifest_manager

      nl
      say(@manifest_manager.to_table)
      nl
    end

    usage "make manifest"
    desc "Create manifest (assumes current directory to be a manifests repo)"
    def make_manifest(name = nil)
      setup_manifest_manager
      manifest = @manifest_manager.find(name)
    end

    private

    def setup_manifest_manager
      @manifest_manager = Bosh::Manifests::ManifestManager.discover(work_dir)
      @manifest_manager.validate_manifests
    end
  end
end
