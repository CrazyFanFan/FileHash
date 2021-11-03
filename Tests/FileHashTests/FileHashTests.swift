import XCTest
@testable import FileHash

final class FileHashTests: XCTestCase {
    private var cacheFileURL: URL?

    override func setUp() {
        super.setUp()

        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            XCTAssertTrue(false, "Read cache dir failed.")
            return
        }

        let fileRUL = URL(fileURLWithPath: cachePath).appendingPathComponent("FileHashTestData.txt")
        try? FileManager.default.removeItem(atPath: fileRUL.path)

        do {
            try "FileHashTestData".write(toFile: fileRUL.path, atomically: true, encoding: .utf8)
        } catch {
            XCTAssertTrue(false, "Write test data failed.")
        }

        cacheFileURL = fileRUL
    }

    override func tearDown() {
        super.tearDown()

        if let cacheFileURL = cacheFileURL {
            do {
                try FileManager.default.removeItem(atPath: cacheFileURL.path)
            } catch {
                XCTAssertTrue(false, "Remove test file error.")
            }
        }
    }

    func testMD2() {
        XCTAssertEqual(FileHash.md2HashOfFile(atPath: cacheFileURL?.path),
                       "da979acd488aadbe44085b68bf56be97")
        XCTAssertEqual(FileHash.md2HashOfFile(atPath: cacheFileURL?.path),
                       FileHash.hash(with: .md2, for: cacheFileURL?.path))
        XCTAssertNil(FileHash.md2HashOfFile(atPath: nil))
    }

    func testMD4() {
        XCTAssertEqual(FileHash.md4HashOfFile(atPath: cacheFileURL?.path),
                       "da622ec461bd3e8e8590a49845b1f393")
        XCTAssertEqual(FileHash.md4HashOfFile(atPath: cacheFileURL?.path),
                       FileHash.hash(with: .md4, for: cacheFileURL?.path))
        XCTAssertNil(FileHash.md4HashOfFile(atPath: nil))
    }

    func testMD5() {
        XCTAssertEqual(FileHash.md5HashOfFile(atPath: cacheFileURL?.path),
                       "6069d978fa7af33751c08654903b5516")
        XCTAssertEqual(FileHash.md5HashOfFile(atPath: cacheFileURL?.path),
                       FileHash.hash(with: .md5, for: cacheFileURL?.path))
        XCTAssertNil(FileHash.md5HashOfFile(atPath: nil))
    }

    func testSHA1() {
        XCTAssertEqual(
            FileHash.sha1HashOfFile(atPath: cacheFileURL?.path),
            "27c38e2a73e30a7b393a5b1cb15d9cbf36394bff")
        XCTAssertEqual(FileHash.sha1HashOfFile(atPath: cacheFileURL?.path),
                       FileHash.hash(with: .sha1, for: cacheFileURL?.path))
        XCTAssertNil(FileHash.sha1HashOfFile(atPath: nil))
    }

    func testSHA224() {
        XCTAssertEqual(FileHash.sha224HashOfFile(atPath: cacheFileURL?.path),
                       "c080cdccc5b4979fee52f175b1ebec3ce88361e7ea1f7d88b798e2d4")
        XCTAssertEqual(FileHash.sha224HashOfFile(atPath: cacheFileURL?.path),
                       FileHash.hash(with: .sha224, for: cacheFileURL?.path))
        XCTAssertNil(FileHash.sha224HashOfFile(atPath: nil))
    }

    func testSHA256() {
        XCTAssertEqual(FileHash.sha256HashOfFile(atPath: cacheFileURL?.path),
                       "f74c815a5b879306b5008a22f2d9b1c9a92014e5d0a8c25cba12f9b8fcd7c726")
        XCTAssertEqual(FileHash.sha256HashOfFile(atPath: cacheFileURL?.path),
                       FileHash.hash(with: .sha256, for: cacheFileURL?.path))
        XCTAssertNil(FileHash.sha256HashOfFile(atPath: nil))
    }

    func testSHA384() {
        XCTAssertEqual(FileHash.sha384HashOfFile(atPath: cacheFileURL?.path),
                       "55d3e8336b58b420e9981062f6b7f57d105b91b98f549379836757795ff8e1fdd365c56732d6deee0be89d58a6c98d3a")
        XCTAssertEqual(FileHash.sha384HashOfFile(atPath: cacheFileURL?.path),
                       FileHash.hash(with: .sha384, for: cacheFileURL?.path))
        XCTAssertNil(FileHash.sha384HashOfFile(atPath: nil))
    }

    func testSHA512() {
        XCTAssertEqual(FileHash.sha512HashOfFile(atPath: cacheFileURL?.path),
                       "eef2b3c08cee9680f72a499d88e60d0547fa87e0f5a8465fa7b0314f85dee6da02b5ef530cae071690b7d3552f20dfedd3aceb3e937bf606bb1e295b00dc27d7")
        XCTAssertEqual(FileHash.sha512HashOfFile(atPath: cacheFileURL?.path),
                       FileHash.hash(with: .sha512, for: cacheFileURL?.path))
        XCTAssertNil(FileHash.sha512HashOfFile(atPath: nil))
    }
}
