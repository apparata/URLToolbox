import Testing
import Foundation
@testable import URLToolbox

/// Test suite for validating URL pattern matching behavior using the URLToolbox library.
///
/// This suite ensures that the `URLMatcher` correctly matches valid URLs to defined patterns
/// and rejects invalid ones.
///
/// It also verifies that values embedded in URL path and query components are accurately
/// extracted and typed.
///
@Suite("URL Matching", .tags(.functionality))
class URLMatchingTests {

    private enum DeepLinkID {
        case cast
        case movieGallery
        case tabB
    }

    private let patterns = [

        // "moviedb://*@*:*/movies/:movieID:/gallery?page=:pageID:"
        URLMatchPattern(
            id: DeepLinkID.movieGallery,
            scheme: "moviedb",
            path: ["movies", .int("movieID"), "gallery"],
            query: [
                ("page", .int("pageID"))
            ]
        ),

        // "moviedb://*@*:*/cast"
        URLMatchPattern(
            id: DeepLinkID.cast,
            scheme: "moviedb",
            path: ["cast"]
        ),

        // "beenlink:tab/b"
        URLMatchPattern(
            id: DeepLinkID.tabB,
            scheme: "beenlink",
            path: ["tab", "b"]
        )
    ]

    /// Tests that a valid deep link URL correctly matches a pattern and extracts expected values.
    ///
    /// This test verifies that the URL matching engine correctly identifies a matching pattern
    /// and extracts typed values such as `movieID` and `pageID` from the URL components.
    ///
    @Test("Matching URLs")
    func matchingURLs() {
        let url = URL(vouchedFor: "moviedb://host/movies/123/gallery?page=4")
        let matcher = URLMatcher(patterns: patterns)
        guard let match = matcher.matchURL(url) else {
            Issue.record("No match found")
            return
        }

        switch match.id.switchable {
        case DeepLinkID.movieGallery:
            break
        case DeepLinkID.cast:
            Issue.record("Incorrect pattern ID match")
        default:
            Issue.record("Incorrect pattern ID match")
        }

        #expect(match.id == DeepLinkID.movieGallery, "The correct pattern ID should be returned.")
        #expect(match.id != DeepLinkID.cast, "The correct pattern ID should be returned.")
        #expect(match.movieID is Int, "Movie ID should be an integer.")
        #expect(match.movieID as? Int == 123, "Movie ID should be 123.")
        #expect(match.pageID as? Int == 4, "Page ID should be 4.")
        #expect(match.dummy == nil)
    }

    /// Tests that a valid deep link URL correctly matches a pattern and extracts expected values.
    ///
    /// This test verifies that the URL matching engine correctly identifies a matching pattern
    /// and extracts typed values such as `movieID` and `pageID` from the URL components.
    ///
    @Test("Matching scheme URLs", arguments: [
        URL(vouchedFor: "beenlink:tab/b"),
        URL(vouchedFor: "beenlink:/tab/b"),
        URL(vouchedFor: "beenlink:///tab/b")
    ])
    func matchingSchemeURLs(url: URL) {
        let matcher = URLMatcher(patterns: patterns)
        guard let match = matcher.matchURL(url) else {
            Issue.record("No match found")
            return
        }

        switch match.id.switchable {
        case DeepLinkID.tabB:
            break
        default:
            Issue.record("Incorrect pattern ID match")
        }

        #expect(match.id == DeepLinkID.tabB, "The correct pattern ID should be returned.")
        #expect(match.id != DeepLinkID.cast, "The correct pattern ID should be returned.")
        #expect(match.dummy == nil)
    }

    /// Tests that a malformed or incomplete URL does not match any defined patterns.
    ///
    /// This ensures that invalid or partially matching URLs are correctly rejected by the matcher.
    /// 
    @Test("Non-matching URLs")
    func nonMatchingURLs() {
        let url = URL(vouchedFor: "moviedb://host/movies/gallery?page=4")
        let matcher = URLMatcher(patterns: patterns)
        let match = matcher.matchURL(url)
        #expect(match == nil, "A match should not be returned.")
    }
}
