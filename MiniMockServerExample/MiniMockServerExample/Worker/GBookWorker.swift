//
//  GBookWorker.swift
//  GBook
//
//  Created by Ngoc LE on 2/26/19.
//  Copyright © 2019 Ngoc LE. All rights reserved.
//

import Foundation

class GBookWorker {
    let googleBook: GoogleBookProtocol
    
    init(googleBook: GoogleBookProtocol) {
        self.googleBook = googleBook
    }
    
    func searchVolume(query: String, completionHandler: @escaping ([Volume], Error?) -> Void) {
        googleBook.searchVolume(query: query, completionHandler: completionHandler)
    }
}

