//
//  ListVolumesInteractor.swift
//  MiniMockServerExample
//
//  Created by Ngoc LE on 2/26/19.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import Foundation
import Moya

protocol ListVolumesBusinessLogic {
    func searchVolumes(request: ListVolumes.SearchVolumes.Request)
}

protocol ListVolumesDataStore {
    var volumes: [Volume]? { get }
}

class ListVolumesInteractor: ListVolumesBusinessLogic, ListVolumesDataStore {
    
    var presenter: ListVolumesPresenter?
    
    var volumesWorker = GBookWorker(googleBook: GoogleBookAPI())
    var volumes: [Volume]?
    
    // MARK: - Fetch volumes
    
    func searchVolumes(request: ListVolumes.SearchVolumes.Request) {
        volumesWorker.searchVolume(query: request.query) { (volumes, _) -> Void in
            self.volumes = volumes
            let response = ListVolumes.SearchVolumes.Response(volumes: volumes)
            self.presenter?.presentFetchedVolumes(response: response)
        }
    }
}
