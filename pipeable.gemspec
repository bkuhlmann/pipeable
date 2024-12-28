# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "pipeable"
  spec.version = "0.14.0"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/pipeable"
  spec.summary = "A domain specific language for building functionally composable steps."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/pipeable/issues",
    "changelog_uri" => "https://alchemists.io/projects/pipeable/versions",
    "homepage_uri" => "https://alchemists.io/projects/pipeable",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Pipeable",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/pipeable"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.4"
  spec.add_dependency "containable", "~> 1.0"
  spec.add_dependency "dry-monads", "~> 1.6"
  spec.add_dependency "marameters", "~> 3.12"
  spec.add_dependency "refinements", "~> 13.0"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
