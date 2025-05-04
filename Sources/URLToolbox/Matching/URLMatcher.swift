//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import Foundation

// MARK: - URLMatcher

/// Matches URLs against a collection of `URLPattern` instances.
///
/// `URLMatcher` iterates through patterns to find the first match and extracts any parameter values.
///
public struct URLMatcher {

    /// The list of URL patterns used for matching incoming URLs.
    ///
    /// `URLMatcher` uses these patterns to evaluate and match URLs. The patterns
    /// are checked in order, and the first one that matches is used to produce a `URLMatch`.
    ///
    public let patterns: [URLMatchPattern]

    /// Creates a URL matcher with a list of URL patterns to evaluate against.
    ///
    /// - Parameter patterns: An array of `URLMatchPattern` instances that the matcher
    ///   will use to test incoming URLs for matches. The order of patterns matters: the first match
    ///   found is returned.
    ///
    public init(patterns: [URLMatchPattern]) {
        self.patterns = patterns
    }

    // MARK: Match URL

    /// Attempts to match a given URL against the stored patterns.
    ///
    /// - Parameter url: The URL to match against the defined patterns.
    /// - Returns: A `URLMatch` if a pattern matches the URL; otherwise, `nil`.
    /// 
    public func matchURL(_ url: URL) -> URLMatch? {
        guard let parts = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        for pattern in patterns {
            if let parameters = matchURL(url, components: parts, for: pattern) {
                return parameters
            }
        }
        return nil
    }

    private func matchURL(
        _ url: URL,
        components: URLComponents,
        for pattern: URLMatchPattern
    ) -> URLMatch? {
        var parameters: [String: URLMatchValue] = [:]

        guard matchValue(components.scheme, to: pattern.scheme, parameters: &parameters) else {
            return nil
        }

        guard matchValue(components.scheme, to: pattern.scheme, parameters: &parameters) else {
            return nil
        }

        guard matchValue(components.user, to: pattern.user, parameters: &parameters) else {
            return nil
        }

        guard matchValue(components.host, to: pattern.host, parameters: &parameters) else {
            return nil
        }

        guard matchValue(components.port, to: pattern.port, parameters: &parameters) else {
            return nil
        }

        guard matchValue(components.fragment, to: pattern.fragment, parameters: &parameters) else {
            return nil
        }

        let path = url.pathComponents.filter { $0 != "/" }
        guard path.count == pattern.path.count else {
            return nil
        }
        for (pathElement, patternElement) in zip(path, pattern.path) {
            guard matchValue(pathElement, to: patternElement, parameters: &parameters) else {
                return nil
            }
        }

        let queryItems = Dictionary<String, String>(
            (components.queryItems ?? []).compactMap { item in
                guard let value = item.value else { return nil }
                return (item.name, value)
            },
            uniquingKeysWith: { first, second in first }
        )

        for (key, token) in pattern.query {
            let value = queryItems[key]
            guard matchValue(value, to: token, parameters: &parameters) else {
                return nil
            }
        }

        return URLMatch(id: URLMatchPatternID(pattern.id), parameters: parameters)
    }

    private func matchValue(_ value: String?, to token: URLMatchToken, parameters: inout [String: URLMatchValue]) -> Bool {
        switch token {
        case .none:
            return value == nil
        case .any:
            return true
        case .literal(let literalScheme):
            return value?.lowercased() == literalScheme.lowercased()
        case .string(let key):
            guard let value else {
                return false
            }
            parameters[key] = .string(value)
            return true
        case .int(let key):
            guard let value, let intValue = Int(value) else {
                return false
            }
            parameters[key] = .int(intValue)
            return true
        case .double(let key):
            guard let value, let doubleValue = Double(value) else {
                return false
            }
            parameters[key] = .double(doubleValue)
            return true
        }
    }

    private func matchValue(_ value: Int?, to token: URLMatchToken, parameters: inout [String: URLMatchValue]) -> Bool {
        switch token {
        case .none:
            return value == nil
        case .any:
            return true
        case .literal(let literalScheme):
            guard let value else {
                return false
            }
            return String(value) == literalScheme
        case .string(let key):
            guard let value else {
                return false
            }
            parameters[key] = .string(String(value))
            return true
        case .int(let key):
            guard let value else {
                return false
            }
            parameters[key] = .int(value)
            return true
        case .double(let key):
            guard let value else {
                return false
            }
            parameters[key] = .double(Double(value))
            return true
        }
    }
}
