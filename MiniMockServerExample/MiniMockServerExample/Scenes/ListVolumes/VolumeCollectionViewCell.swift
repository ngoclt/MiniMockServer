//
//  VolumeCollectionViewCell.swift
//  MiniMockServerExample
//
//  Created by Ngoc LE on 2/28/19.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import UIKit
import Kingfisher

class VolumeCollectionViewCell: UICollectionViewCell, Reusable {
    
    private var cornerRadius: CGFloat = 5.0
    
    var data: ListVolumes.SearchVolumes.ViewModel.DisplayedVolume! {
        didSet {
            if let imageURL = data.thumbnail {
                imageView.kf.setImage(with: imageURL)
            }
            
            publisherLabel.attributedText = data.publisher
            ratingLabel.text = data.rating
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAccessibilityIdentifiers()
    }
    
    private func setAccessibilityIdentifiers() {
        publisherLabel.accessibilityIdentifier = "publisherLabel"
    }
}
