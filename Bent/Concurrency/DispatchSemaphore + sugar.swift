//
//  DispatchSemaphore + sugar.swift
//  Plural Diagramming
//
//  Created by The Ky Leggiero on 2023-01-17.
//

import Foundation



public extension DispatchSemaphore {
    static var `default`: Self {
        Self.init(value: 0)
    }
}
