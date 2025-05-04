//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import Foundation

// MARK: - URLMatchToken

/// A token that represents a component of a URL pattern.
///
/// `URLMatchToken` allows for matching specific literal values, capturing values as strings, integers,
/// or doubles, and matching any or no value.
///
public enum URLMatchToken: ExpressibleByStringLiteral {

    case none
    case any
    case literal(String)

    case string(String)
    case int(String)
    case double(String)

    /// Creates a `.literal` token from a string literal.
    ///
    /// This initializer enables the use of string literals to directly represent literal matching tokens.
    ///
    /// - Parameter value: The string literal to use as the literal match.
    /// 
    public init(stringLiteral value: String) {
        self = .literal(value)
    }
}
