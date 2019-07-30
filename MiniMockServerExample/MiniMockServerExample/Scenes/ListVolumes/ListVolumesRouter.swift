//
//  ListVolumesRouter.swift
//  MiniMockServerExample
//
//  Created by Ngoc LE on 2/27/19.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import UIKit

protocol ListVolumesRoutingLogic {
    func routeToShowBookReview(segue: UIStoryboardSegue?)
}

protocol ListVolumesDataPassing {
    var dataStore: ListVolumesDataStore? { get }
}

class ListVolumesRouter: ListVolumesRoutingLogic, ListVolumesDataPassing {
    
    weak var viewController: ListVolumesViewController?
    var dataStore: ListVolumesDataStore?
    
    func routeToShowBookReview(segue: UIStoryboardSegue?) {
        
    }
}
