//
//  ListVolumesPresenter.swift
//  GBook
//
//  Created by Ngoc LE on 2/26/19.
//  Copyright © 2019 Ngoc LE. All rights reserved.
//

import UIKit

protocol ListVolumesPresentationLogic {
    func presentFetchedVolumes(response: ListVolumes.SearchVolumes.Response)
}

class ListVolumesPresenter: ListVolumesPresentationLogic {
    
    weak var viewController: ListVolumesDisplayLogic?
    
    func thumbnailURL(for volume: Volume) -> URL? {
        return URL(string: volume.volumeInfo.imageLinks.smallThumbnail)
    }
    
    func publisherText(for volume: Volume) -> NSAttributedString {
        let publishedBy = NSAttributedString(string: "Published by: ", attributes: [.font : UIFont.boldSystemFont(ofSize: 13), .foregroundColor: UIColor.white])
        
        let displayedText = NSMutableAttributedString(attributedString: publishedBy)
        displayedText.append(NSAttributedString(string: volume.volumeInfo.publisher ?? "-", attributes: [.font : UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.white]))
        
        return displayedText
    }
    
    func ratingText(for volume: Volume) -> String {
        return "\(volume.volumeInfo.averageRating)"
    }
    
    // MARK: - Fetch orders
    
    func presentFetchedVolumes(response: ListVolumes.SearchVolumes.Response) {
        
        let displayedVolumes = response.volumes.map { volume in
            return ListVolumes.SearchVolumes.ViewModel.DisplayedVolume(id: volume.id,
                                                                       title: volume.volumeInfo.title,
                                                                       thumbnail: thumbnailURL(for: volume),
                                                                       publisher: publisherText(for: volume),
                                                                       rating: ratingText(for: volume))
        }
        
        let viewModel = ListVolumes.SearchVolumes.ViewModel(displayedVolumes: displayedVolumes)
        viewController?.displayFetchedVolumes(viewModel: viewModel)
    }
}
