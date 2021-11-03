//
//  Hasher+MD.swift
//  
//
//  Created by Crazy凡 on 2021/11/4.
//

import CoreFoundation
import CommonCrypto
import Foundation

public extension Hasher {
    static func md2HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_MD2_CTX>(
            objectMaker: { CC_MD2_CTX() },
            initMethod: CC_MD2_Init,
            updateMethod: CC_MD2_Update,
            finalMethod: CC_MD2_Final,
            digestLength: 16
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    static func md4HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_MD4_CTX>(
            objectMaker: { CC_MD4_CTX() },
            initMethod: CC_MD4_Init,
            updateMethod: CC_MD4_Update,
            finalMethod: CC_MD4_Final,
            digestLength: 16
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    static func md5HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_MD5_CTX>(
            objectMaker: { CC_MD5_CTX() },
            initMethod: CC_MD5_Init,
            updateMethod: CC_MD5_Update,
            finalMethod: CC_MD5_Final,
            digestLength: 16
        )

        return hashOfFile(atPath: filePath, with: &context)
    }
}
