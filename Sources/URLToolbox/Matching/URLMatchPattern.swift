//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import Foundation

// MARK: - URLMatchPattern

/// A pattern that describes how a URL should be matched.
///
/// `URLMatchPattern` specifies expected values for various components of a URL, such as
/// scheme, host, path segments, and query parameters.
///
public struct URLMatchPattern: Identifiable {

    /// A unique identifier for the matching pattern. Useful for distinguishing between multiple patterns.
    public let id: AnyHashable

    /// The expected scheme component of the URL (e.g., "https").
    public let scheme: URLMatchToken

    /// The expected user component of the URL, if any.
    public let user: URLMatchToken

    /// The expected host component of the URL (e.g., "example.com").
    public let host: URLMatchToken

    /// The expected port component of the URL (e.g., 443).
    public let port: URLMatchToken

    /// The expected fragment component of the URL (e.g., "section1").
    public let fragment: URLMatchToken

    /// The expected path components of the URL as an ordered list of tokens.
    public let path: [URLMatchToken]

    /// The expected query parameters as key-token pairs (e.g., "key=value").
    public let query: [(String, URLMatchToken)]

    /// Creates a new URL matching pattern with optional constraints on URL components.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the pattern.
    ///   - scheme: The expected scheme component (default is `.any`).
    ///   - user: The expected user component (default is `.any`).
    ///   - host: The expected host component (default is `.any`).
    ///   - port: The expected port component (default is `.any`).
    ///   - fragment: The expected fragment component (default is `.any`).
    ///   - path: The expected path components of the URL.
    ///   - query: The expected query parameters of the URL (default is `[]`).
    ///
    public init(
        id: AnyHashable,
        scheme: URLMatchToken = .any,
        user: URLMatchToken = .any,
        host: URLMatchToken = .any,
        port: URLMatchToken = .any,
        fragment: URLMatchToken = .any,
        path: [URLMatchToken],
        query: [(String, URLMatchToken)] = []
    ) {
        self.id = id
        self.scheme = scheme
        self.user = user
        self.host = host
        self.port = port
        self.fragment = fragment
        self.path = path
        self.query = query
    }
}
