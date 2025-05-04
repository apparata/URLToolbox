//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import Foundation

// MARK: - URLMatch

/// A result returned by `URLMatcher` when a URL successfully matches a pattern.
///
/// Provides access to captured parameters and the identifier of the matched pattern.
///
/// You can access captured values by key or using dynamic member lookup:
///
/// ```swift
/// let match = matcher.matchURL(someURL)
/// if let movieID = match?["movieID"] {
///     print(movieID) // URLValue.int(123)
/// }
///
/// if let movieID = match?.movieID {
///     print(movieID) // 123
/// }
/// ```
@dynamicMemberLookup public struct URLMatch {

    /// The identifier of the matched URL pattern.
    ///
    /// Corresponds to the `id` property of the `URLMatchPattern` that matched the input URL.
    ///
    public let id: URLMatchPatternID

    /// A dictionary of values extracted from the matched URL.
    ///
    /// The keys are parameter names defined in the pattern, and the values are
    /// typed representations such as `.string`, `.int`, or `.double`.
    ///
    public var parameters: [String: URLMatchValue]

    /// Accesses a captured value by parameter name.
    ///
    /// - Parameter key: The name of the captured parameter.
    /// - Returns: A `URLValue` if found; otherwise, `nil`.
    /// 
    public subscript(key: String) -> URLMatchValue? {
        return parameters[key]
    }

    /// Dynamically accesses a captured value by parameter name using dot notation.
    ///
    /// This provides untyped access to values (e.g., `match.userID`), returning them as `Any?`.
    ///
    /// - Parameter member: The name of the captured parameter.
    /// - Returns: The untyped value (`String`, `Int`, or `Double`) or `nil` if not present.
    ///
    public subscript(dynamicMember member: String) -> Any? {
        return parameters[member]?.untypedValue
    }
}
