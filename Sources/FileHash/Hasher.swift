//
//  FileHash+SHA.swift
//
//
//  Created by Crazy凡 on 2021/11/3.
//

import CoreFoundation
import CommonCrypto
import Foundation

public enum Hasher {
    public static var defaultChunkSizeForReadingData: Int = 4096
}

extension Hasher {
    struct Context<CTX> {
        typealias ObjectMaker = () -> CTX
        typealias InitMethod = (UnsafeMutablePointer<CTX>?) -> Int32
        typealias UpdateMethod = (UnsafeMutablePointer<CTX>?, UnsafeRawPointer?, CC_LONG) -> Int32
        typealias FinalMethod = (UnsafeMutablePointer<UInt8>?, UnsafeMutablePointer<CTX>?) -> Int32

        var objectMaker: ObjectMaker
        var initMethod: InitMethod
        var updateMethod: UpdateMethod
        var finalMethod: FinalMethod

        var digestLength: Int
    }

    static func hashOfFile<CTX>(atPath filePath: String?, with context: inout Context<CTX>) -> String? {
        guard let filePath = filePath else { return nil }

        let url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, filePath as CFString, .cfurlposixPathStyle, false)
        let readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, url)

        var didSucceed = CFReadStreamOpen(readStream)

        guard didSucceed else { return nil }

        var hashObject = context.objectMaker()
        _ = context.initMethod(&hashObject)
        var hasMoreData = true
        var buffer = [UInt8](repeating: 0, count: defaultChunkSizeForReadingData)

        while hasMoreData {
            let readBytesCount = CFReadStreamRead(readStream, &buffer, defaultChunkSizeForReadingData)

            if readBytesCount == -1 {
                break
            } else if readBytesCount == 0 {
                hasMoreData = false
            } else {
                _ = context.updateMethod(&hashObject, &buffer, CC_LONG(readBytesCount))
            }
        }
        CFReadStreamClose(readStream);

        var digest = [UInt8](repeating: 0, count: context.digestLength)
        _ = context.finalMethod(&digest, &hashObject)

        didSucceed = !hasMoreData

        guard didSucceed else { return nil }

        var result: String = ""

        digest.forEach { result += String(format: "%02x",$0) }

        return result
    }
}
