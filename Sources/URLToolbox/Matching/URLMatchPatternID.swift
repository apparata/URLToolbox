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

    public var switchable: Any {
        id.base
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: URLMatchPatternID, rhs: URLMatchPatternID) -> Bool {
        lhs.id == rhs.id
    }

    public static func == <T: Hashable>(lhs: URLMatchPatternID, rhs: T) -> Bool {
        lhs.id == rhs as AnyHashable
    }

    public static func == <T: Hashable>(lhs: T, rhs: URLMatchPatternID) -> Bool {
        lhs as AnyHashable == rhs.id
    }

    public static func != <T: Hashable>(lhs: URLMatchPatternID, rhs: T) -> Bool {
        lhs.id != rhs as AnyHashable
    }

    public static func != <T: Hashable>(lhs: T, rhs: URLMatchPatternID) -> Bool {
        lhs as AnyHashable != rhs.id
    }
}
