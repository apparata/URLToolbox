import Testing
import Foundation
@testable import URLToolbox

@Suite("URL Matcher Pattern Builder", .tags(.functionality))
class URLMatcherPatternTests {

    @Test("Basic builder")
    func basicBuilder() {
        let _ = URLMatcher {
            URLMatchPattern(
                id: "DeepLinkID.movieGallery",
                scheme: "moviedb",
                path: ["movies", .int("movieID"), "gallery"],
                query: [
                    ("page", .int("pageID"))
                ]
            )
        }
    }
}
