//
//  CharacterListSceneViewController.swift
//  MarvelTest
//
//  Created by jorgeSV on 13/5/21.
//

import UIKit
import SkeletonView

protocol CharacterListSceneDisplayLogic: AnyObject {
    func displayCharacters(viewModel: [CharacterModel.List.ViewModel], hasMoreResults: Bool?)
    func displayError(error: Error)
}

class CharacterListSceneViewController: MyViewController, CharacterListSceneDisplayLogic {
  
    var interactor: CharacterListSceneBusinessLogic?
    var router: (NSObjectProtocol & CharacterListSceneRoutingLogic & CharacterListSceneDataPassing)?
    
    // MARK: Outlets
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: Constants & Variables
    
    var characters:[CharacterModel.List.ViewModel] = []
    var hasMoreResults: Bool = true
    
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
        let interactor = CharacterListSceneInteractor()
        let presenter = CharacterListScenePresenter()
        let router = CharacterListSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        requestCharacters()
    }
}

// MARK: - Init UI

extension CharacterListSceneViewController {
    
    private func initUI() {
        self.navigationController?.navigationItem.title = "Characters".uppercased()
        
        initTableView()
    }
    
    private func initTableView() {
        self.tableView.register(UINib(nibName: "SimpleTableViewCell", bundle: nil), forCellReuseIdentifier: "SimpleTableViewCell")
        self.tableView.register(UINib(nibName: "SimpleTableViewCell", bundle: nil), forCellReuseIdentifier: "SkeletonSimpleTableViewCell")
        self.tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadingTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = Constants.CELL_SIMPLE_ROW_HEIGHT
    }
}

// MARK: - Requests

extension CharacterListSceneViewController {
    
    func requestCharacters(offset: Int? = 0) {
        
        self.view.isSkeletonable = (offset == 0)
        showProgress()
        
        let request = CharacterModel.List.Request(offset: offset, limit: 100)
        self.interactor?.fetchCharacters(request: request)
    }
}

// MARK: - Displays

extension CharacterListSceneViewController {
    
    func displayCharacters(viewModel: [CharacterModel.List.ViewModel], hasMoreResults: Bool?) {
        
        self.hideProgress()
        
        self.characters = viewModel
        self.hasMoreResults = hasMoreResults ?? true
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayError(error: Error) {
        
        self.view.isSkeletonable = false
        self.hideProgress()
        print("Error in characters endpoint")
    }
}

// MARK: - TableView delegate & datasource

extension CharacterListSceneViewController: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SkeletonSimpleTableViewCell"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.hasMoreResults ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.characters.count
        } else {
            return self.hasMoreResults ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.CELL_SIMPLE_ROW_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath) as! LoadingTableViewCell
            cell.activityIndicator.startAnimating()
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleTableViewCell", for: indexPath) as! SimpleTableViewCell
        
        let characterModel = self.characters[indexPath.row]
        
        cell.setImageView(path: characterModel.path, ext: characterModel.ext, andTitle: characterModel.title, andDescription: characterModel.desc)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            self.view.isSkeletonable = false
            requestCharacters(offset: self.characters.count)
            
            return
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let character = self.characters[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
