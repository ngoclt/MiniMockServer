//
//  ViewController.swift
//  GBook
//
//  Created by Ngoc LE on 2/20/19.
//  Copyright © 2019 Ngoc LE. All rights reserved.
//

import UIKit

protocol ListVolumesDisplayLogic: class {
    func displayFetchedVolumes(viewModel: ListVolumes.SearchVolumes.ViewModel)
}

class ListVolumesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    var interactor: ListVolumesBusinessLogic?
    var router: (ListVolumesRoutingLogic & ListVolumesDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ListVolumesInteractor()
        let presenter = ListVolumesPresenter()
        let router = ListVolumesRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setKeyword(_ text: String) {
        textFieldSearch.text = text
        keyword = text
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyword("Harry Potter")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Fetch volumes
    
    var displayedVolumes: [ListVolumes.SearchVolumes.ViewModel.DisplayedVolume] = []
    var keyword: String = "" {
        didSet {
            fetchVolumes(query: keyword)
        }
    }
    
    func fetchVolumes(query: String) {
        let request = ListVolumes.SearchVolumes.Request(query: query)
        interactor?.searchVolumes(request: request)
    }
}

extension ListVolumesViewController: ListVolumesDisplayLogic {
    
    func displayFetchedVolumes(viewModel: ListVolumes.SearchVolumes.ViewModel) {
        displayedVolumes = viewModel.displayedVolumes
        collectionView.reloadData()
    }
}

extension ListVolumesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedVolumes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let volume = displayedVolumes[indexPath.item]
        
        guard let cell: VolumeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.data = volume
        
        return cell
    }
    
}

extension ListVolumesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        textField.resignFirstResponder()
        
        setKeyword(text)
        return true
    }
    
}
