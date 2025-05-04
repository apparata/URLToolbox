//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import Foundation

extension URL {

    /// Creates a new URL from the given string or throws an error if the string is not a valid URL.
    ///
    /// - Parameter tryString: The string to use to construct the URL.
    /// - Throws: `URLError.invalidURL` if the string cannot be converted into a valid `URL`.
    public init(tryString: String) throws {
        guard let url = URL(string: tryString) else {
            throw URLInitializingError.invalidURL(tryString)
        }
        self = url
    }
}
