//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import Foundation

@resultBuilder
public struct URLMatchPatternBuilder {
    public static func buildBlock(_ components: URLMatchPattern...) -> [URLMatchPattern] {
        return components
    }
    
    public static func buildOptional(_ component: [URLMatchPattern]?) -> [URLMatchPattern] {
        return component ?? []
    }
    
    public static func buildEither(first component: [URLMatchPattern]) -> [URLMatchPattern] {
        return component
    }

    public static func buildEither(second component: [URLMatchPattern]) -> [URLMatchPattern] {
        return component
    }

    public static func buildArray(_ components: [[URLMatchPattern]]) -> [URLMatchPattern] {
        return components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: URLMatchPattern) -> [URLMatchPattern] {
        return [expression]
    }
}
