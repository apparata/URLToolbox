//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import Foundation

// MARK: - URLMatchValue

/// A typed representation of a matched URL component.
///
/// URL components may be captured as strings, integers, or doubles.
/// 
public enum URLMatchValue {
    case string(String)
    case int(Int)
    case double(Double)
}

extension URLMatchValue {
    public var untypedValue: Any {
        switch self {
        case .string(let string):
            return string
        case .int(let int):
            return int
        case .double(let double):
            return double
        }
    }
}
