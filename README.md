# FileHash

A swift libray to calculate file hash.

# Usage

```
    let path = "file_path_string"
    let md5 = Hasher.md5HashOfFile(atPath: path)
    let sha1 = Hasher.hash(with: .sha1, at: path)
```
