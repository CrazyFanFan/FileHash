Pod::Spec.new do |spec|
  spec.name         = "FileHash"
  spec.version      = "0.0.1"
  spec.summary      = "A swift libray to calculate file hash."

  spec.description  = <<-DESC
  # FileHash

  A swift libray to calculate file hash.

  # Usage

  ```
  let path = "file_path_string"
  let md5 = Hasher.md5HashOfFile(atPath: path)
  let sha1 = Hasher.hash(with: .sha1, at: path)
  ```
                   DESC

  spec.homepage     = "https://github.com/CrazyFanFan/FileHash"

  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Crazy凡" => "827799383@qq.com" }

  spec.ios.deployment_target = "9.0"
  spec.osx.deployment_target = "10.10"
  spec.watchos.deployment_target = "3.0"
  spec.tvos.deployment_target = "9.0"

  spec.source       = { :git => "https://github.com/CrazyFanFan/FileHash.git", :tag => "#{spec.version}" }
  spec.requires_arc = true
  spec.source_files  = "Classes", "Sources/FileHash/**/*.{swift}"
  spec.swift_version = '5.3'
end
