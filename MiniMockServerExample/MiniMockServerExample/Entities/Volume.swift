//
//  Volume.swift
//  GBook
//
//  Created by Ngoc LE on 2/26/19.
//  Copyright © 2019 Ngoc LE. All rights reserved.
//

import Foundation

struct Volume: Codable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

extension Volume: CustomDebugStringConvertible {
    var debugDescription: String {
        return "<Volume:\(id)> - \(volumeInfo.title)"
    }
}

extension Volume {
    struct VolumeInfo: Codable {
        let title: String
        let subtitle: String?
        let authors: [String]?
        let publisher: String?
        let publishedDate: String?
        let description: String?
        let pageCount: Int?
        let mainCategory: String?
        let categories: [String]?
        let averageRating: Double = 0
        let ratingsCount: Int = 0
        let contentVersion: String?
        let imageLinks: ImageLinks
        let language: String?
        let previewLink: String?
        let infoLink: String?
    }
}

extension Volume {
    struct ImageLinks: Codable {
        let smallThumbnail: String
        let thumbnail: String
    }
}

extension Volume {
    struct SaleInfo: Codable {
        let country: String
        let saleability: String
        let isEbook: Bool
        let listPrice: PriceInfo?
        let retailPrice: PriceInfo?
        let buyLink: String?
    }
}

extension Volume {
    struct PriceInfo: Codable {
        let amount: Double
        let currencyCode: String
    }
}
