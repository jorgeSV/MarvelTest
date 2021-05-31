//
//  CharacterDetailViewController.swift
//  MarvelTest
//
//  Created by jorgeSV on 29/5/21.
//

import UIKit

protocol CharacterDetailDisplayLogic: AnyObject {
    func displayCharacterDetail(viewModel: CharacterModel.Detail.ViewModel)
    func displayError(error: Error)
}

class CharacterDetailViewController: MyViewController, CharacterDetailDisplayLogic {
    
    var interactor: CharacterDetailBusinessLogic?
    var router: (NSObjectProtocol & CharacterDetailRoutingLogic & CharacterDetailDataPassing)?

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var optionalLabel: UILabel!
    
    var character: CharacterModel.Detail.ViewModel?
    
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
        let interactor = CharacterDetailInteractor()
        let presenter = CharacterDetailPresenter()
        let router = CharacterDetailRouter()
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
        
        requestCharacter()
    }
}

// MARK: - Requests

extension CharacterDetailViewController {
    
    func requestCharacter() {
        
        self.view.isSkeletonable = false
        showProgress()
        
        self.interactor?.fetchCharacterDetail()
    }
}

// MARK: - Displays

extension CharacterDetailViewController {
    
    func displayCharacterDetail(viewModel: CharacterModel.Detail.ViewModel) {
        
        self.hideProgress()
        
        self.character = viewModel
        
        DispatchQueue.main.async {
            
            if !viewModel.path.isEmpty && !viewModel.ext.isEmpty {
                self.imageView.contentMode = .scaleToFill
                self.imageView.af.setImage(withURL: URL.init(string: viewModel.path + Constants.API_LANDSCAPE_TYPE + viewModel.ext)!)
            }
            
            self.nameLabel.text = viewModel.title
            
            if let desc = viewModel.desc, !desc.isEmpty {
                self.descriptionLabel.text = desc
            } else {
                self.descriptionLabel.isHidden = true
            }
            
            if let opt = viewModel.opt {
                self.optionalLabel.text = opt
            } else {
                self.optionalLabel.isHidden = true
            }
        }
    }
    
    func displayError(error: Error) {
        
        self.hideProgress()
        
        self.showError(error: error)
    }
}
