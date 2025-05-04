//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import Foundation

// MARK: - URLMatchPatternID

/// A type-safe identifier used to label URL patterns.
///
/// Useful for distinguishing matched patterns and retrieving associated values.
/// 
public struct URLMatchPatternID: ExpressibleByStringLiteral, Hashable {

    let id: AnyHashable

    public init(stringLiteral value: String) {
        self.id = value
    }

    public init(_ id: AnyHashable) {
        self.id = id
    }
}
