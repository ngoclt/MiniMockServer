//
//  GoogleBookProtocol.swift
//  GBook
//
//  Created by Ngoc LE on 2/26/19.
//  Copyright © 2019 Ngoc LE. All rights reserved.
//

import Foundation

protocol GoogleBookProtocol {
    func searchVolume(query: String, completionHandler: @escaping ([Volume], Error?) -> Void)
    func fetchBook(id: String, completionHandler: @escaping (Volume, Error?) -> Void)
}
