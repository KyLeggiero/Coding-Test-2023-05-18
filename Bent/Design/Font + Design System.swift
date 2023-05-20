//
//  Font + Design System.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-19.
//

import SwiftUI



extension Font {
    enum DesignSystem {
        // This enum is empty on-purpose; all memers are static
    }
}



extension Font.DesignSystem {
    static var bigTitle: Font {
        .system(size: 34, weight: .bold)
    }
    
    static var tagline: Font {
        .system(size: 17)
    }
}
