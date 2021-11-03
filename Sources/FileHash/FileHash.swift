import CommonCrypto
import CoreFoundation
import Foundation

public enum FileHash {
    public static var defaultChunkSizeForReadingData: Int = 4096

    private static func hashOfFile<T>(atPath filePath: String?, with context: inout Context<T>) -> String? {
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

    public static func md2HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_MD2_CTX>(
            objectMaker: { CC_MD2_CTX() },
            initMethod: CC_MD2_Init,
            updateMethod: CC_MD2_Update,
            finalMethod: CC_MD2_Final,
            digestLength: 16
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    public static func md4HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_MD4_CTX>(
            objectMaker: { CC_MD4_CTX() },
            initMethod: CC_MD4_Init,
            updateMethod: CC_MD4_Update,
            finalMethod: CC_MD4_Final,
            digestLength: 16
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    public static func md5HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_MD5_CTX>(
            objectMaker: { CC_MD5_CTX() },
            initMethod: CC_MD5_Init,
            updateMethod: CC_MD5_Update,
            finalMethod: CC_MD5_Final,
            digestLength: 16
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    public static func sha1HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_SHA1_CTX>(
            objectMaker: { CC_SHA1_CTX() },
            initMethod: CC_SHA1_Init,
            updateMethod: CC_SHA1_Update,
            finalMethod: CC_SHA1_Final,
            digestLength: 20
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    public static func sha224HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_SHA256_CTX>(
            objectMaker: { CC_SHA256_CTX() },
            initMethod: CC_SHA224_Init,
            updateMethod: CC_SHA224_Update,
            finalMethod: CC_SHA224_Final,
            digestLength: 28
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    public static func sha256HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_SHA256_CTX>(
            objectMaker: { CC_SHA256_CTX() },
            initMethod: CC_SHA256_Init,
            updateMethod: CC_SHA256_Update,
            finalMethod: CC_SHA256_Final,
            digestLength: 32
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    public static func sha384HashOfFile(atPath filePath: String?) -> String? {
        var context = Context<CC_SHA512_CTX>(
            objectMaker: { CC_SHA512_CTX() },
            initMethod: CC_SHA384_Init,
            updateMethod: CC_SHA384_Update,
            finalMethod: CC_SHA384_Final,
            digestLength: 48
        )

        return hashOfFile(atPath: filePath, with: &context)
    }

    public static func sha512HashOfFile(atPath filePath: String?) -> String? {
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

private extension FileHash {
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
}
