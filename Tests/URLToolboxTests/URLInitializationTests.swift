import Testing
import Foundation
@testable import URLToolbox

/// Test suite for verifying URL initialization behaviors in various scenarios.
///
/// This suite ensures that safe initializers like `vouchedFor:` and `tryString:` behave as expected
/// when handling valid and invalid URL strings.
@Suite("URL Initialization", .tags(.functionality))
class URLInitializationTests {

    /// Tests that initializing a URL with a vouched-for string does not crash.
    ///
    /// This test confirms that the `URL(vouchedFor:)` initializer functions correctly for a
    /// valid string literal.
    ///
    @Test("Vouched for string")
    func vouchedForURL() {
        _ = URL(vouchedFor: "https://apparata.io")
        // Passes if the initializer does not crash.
    }

    /// Tests that initializing with known bad URL strings throws an error.
    ///
    /// This ensures that `URL(tryString:)` properly throws `URLInitializingError` for
    /// malformed strings.
    ///
    @Test("Init throws", arguments: [
        "ht!tp://bad_url",
        ""
    ])
    func initThrows(urlString: String) {
        #expect(throws: URLInitializingError.self) {
            try URL(tryString: urlString)
        }
    }

    /// Tests that valid URL strings do not throw when passed to `URL(tryString:)`.
    ///
    /// This validates that well-formed URLs are accepted by the non-optional throwing initializer.
    ///
    @Test("Init doesn't throw", arguments: [
        "https://",
        "https://good.url.com",
        "custom://also.works.com"
    ])
    func initDoesNotThrow(urlString: String) {
        #expect(throws: Never.self) {
            try URL(tryString: urlString)
        }
    }
}
