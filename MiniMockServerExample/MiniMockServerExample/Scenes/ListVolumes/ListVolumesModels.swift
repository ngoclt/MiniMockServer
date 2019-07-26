//
//  ListVolumesModels.swift
//  GBook
//
//  Created by Ngoc LE on 2/26/19.
//  Copyright © 2019 Ngoc LE. All rights reserved.
//

import Foundation

enum ListVolumes {
    
    enum SearchVolumes {
        
        struct Request {
            var query: String
        }
        
        struct Response {
            var volumes: [Volume]
        }
        
        struct ViewModel {
            
            struct DisplayedVolume {
                var id: String
                var title: String
                var thumbnail: URL?
                var publisher: NSAttributedString
                var rating: String
            }
            
            var displayedVolumes: [DisplayedVolume]
        }
    }
}
