//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import Foundation

extension URL {

    /// Initializes a URL from a string that is vouched for to be valid, crashing if the string is not a valid URL.
    ///
    /// - Parameters:
    ///   - urlString: A runtime string that is assumed to be a valid URL.
    ///
    public init(vouchedFor urlString: String) {
        guard let url = URL(string: urlString) else {
            fatalError("ERROR: Invalid URL: \(urlString)")
        }
        self = url
    }
}
