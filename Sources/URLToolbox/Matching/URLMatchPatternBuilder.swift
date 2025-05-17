//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import Foundation

@resultBuilder
public struct URLMatchPatternBuilder {
    public static func buildBlock(_ components: URLMatchPattern...) -> [URLMatchPattern] {
        return components
    }
}
