//
//  Hasher+Kind.swift
//  
//
//  Created by Crazy凡 on 2021/11/4.
//

import Foundation

public extension Hasher {
    enum Kind {
        case md2, md4, md5
        case sha1, sha224, sha256, sha384, sha512
    }

    static func hash(with kind: Kind, for filePath: String?) -> String? {
        switch kind {
        case .md2: return md2HashOfFile(atPath: filePath)
        case .md4: return md4HashOfFile(atPath: filePath)
        case .md5: return md5HashOfFile(atPath: filePath)
        case .sha1: return sha1HashOfFile(atPath: filePath)
        case .sha224: return sha224HashOfFile(atPath: filePath)
        case .sha256: return sha256HashOfFile(atPath: filePath)
        case .sha384: return sha384HashOfFile(atPath: filePath)
        case .sha512: return sha512HashOfFile(atPath: filePath)
        }
    }
}
