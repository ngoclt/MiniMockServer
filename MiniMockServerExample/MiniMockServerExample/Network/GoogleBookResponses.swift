//
//  GoogleBookResponses.swift
//  GBook
//
//  Created by Ngoc LE on 2/26/19.
//  Copyright © 2019 Ngoc LE. All rights reserved.
//

import Foundation

struct ListItemResponse<T: Codable>: Codable {
    let items: [T]
}
