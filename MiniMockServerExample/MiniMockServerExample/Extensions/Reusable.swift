//
//  Reusable.swift
//  MiniMockServerExample
//
//  Created by Ngoc LE on 2/28/19.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import Foundation

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        /// Use the class's name as an identifier
        return String(describing: Self.self)
    }
}
