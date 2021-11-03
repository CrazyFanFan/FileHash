//
//  FileHash+SHA.swift
//
//
//  Created by Crazy凡 on 2021/11/3.
//

import CoreFoundation
import CommonCrypto
import Foundation

public enum FileHash {
    public static var defaultChunkSizeForReadingData: Int = 4096

    case md2, md4, md5
    case sha1, sha224, sha256, sha384, sha512

    public static func hash(with type: FileHash, for filePath: String?) -> String? {
        switch type {
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

extension FileHash {
    struct Context<HashObject> {
        typealias ObjectMaker = () -> HashObject
        typealias InitMethod = (UnsafeMutablePointer<HashObject>?) -> Int32
        typealias UpdateMethod = (UnsafeMutablePointer<HashObject>?, UnsafeRawPointer?, CC_LONG) -> Int32
        typealias FinalMethod = (UnsafeMutablePointer<UInt8>?, UnsafeMutablePointer<HashObject>?) -> Int32

        var objectMaker: ObjectMaker
        var initMethod: InitMethod
        var updateMethod: UpdateMethod
        var finalMethod: FinalMethod

        var digestLength: Int
    }

    static func hashOfFile<T>(atPath filePath: String?, with context: inout Context<T>) -> String? {
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

        var result: String = ""
        didSucceed = !hasMoreData

        if didSucceed {
            for index in 0..<context.digestLength {
                result += String(format: "%02x", digest[index])
            }
        } else {
            return nil
        }

        return result
    }
}
