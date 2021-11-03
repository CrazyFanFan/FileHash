//
//  Hasher+SHA.swift
//  
//
//  Created by Crazy凡 on 2021/11/4.
//

import CoreFoundation
import CommonCrypto
import Foundation

public extension Hasher {
    static func sha1HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_SHA1_CTX>(
            objectMaker: { CC_SHA1_CTX() },
            initMethod: CC_SHA1_Init,
            updateMethod: CC_SHA1_Update,
            finalMethod: CC_SHA1_Final,
            digestLength: 20
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    static func sha224HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_SHA256_CTX>(
            objectMaker: { CC_SHA256_CTX() },
            initMethod: CC_SHA224_Init,
            updateMethod: CC_SHA224_Update,
            finalMethod: CC_SHA224_Final,
            digestLength: 28
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    static func sha256HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_SHA256_CTX>(
            objectMaker: { CC_SHA256_CTX() },
            initMethod: CC_SHA256_Init,
            updateMethod: CC_SHA256_Update,
            finalMethod: CC_SHA256_Final,
            digestLength: 32
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    static func sha384HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_SHA512_CTX>(
            objectMaker: { CC_SHA512_CTX() },
            initMethod: CC_SHA384_Init,
            updateMethod: CC_SHA384_Update,
            finalMethod: CC_SHA384_Final,
            digestLength: 48
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    static func sha512HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_SHA512_CTX>(
            objectMaker: { CC_SHA512_CTX() },
            initMethod: CC_SHA512_Init,
            updateMethod: CC_SHA512_Update,
            finalMethod: CC_SHA512_Final,
            digestLength: 64
        )

        return hashOfFile(atPath: filePath, with: &context)
    }
}
