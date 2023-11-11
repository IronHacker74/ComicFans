//
//  BrowseMediatingController.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import UIKit

protocol BrowseDelegate {
    func browseViewDidLoad(_ vc: any BrowseDisplayable, offset: Int)
}

protocol BrowseDisplayable: BrowseCollectionViewDelegate {
    func updateBrowseCollectionView(browseArray: [DataSetProtocol])
    func setupCollectionview()
    func setupTableview()
}

protocol BrowseCollectionViewDelegate {
}

final class BrowseMediatingController: UIViewController {
    
    @IBOutlet private (set) var searchbar: UISearchBar!
    @IBOutlet private (set) var browseContentView: UIStackView!
    @IBOutlet private (set) var copyrightLabel: UILabel!
    
    private var delegate: BrowseDelegate?

    init(delegate: BrowseDelegate?) {
        self.delegate = delegate
        super.init(nibName: "BrowseMediatingController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate?.browseViewDidLoad(self, offset: 0)
    }
}

extension BrowseMediatingController: BrowseDisplayable {
    func setupCollectionview() {
        let collectionview = BrowseCollectionView(browseDelegate: self)
        self.browseContentView.addArrangedSubview(collectionview)
    }
    
    func setupTableview() {
        // TODO: setup tableview
    }
    
    func updateBrowseCollectionView(browseArray: [DataSetProtocol]) {
        if let collectionview = browseContentView.subviews.first(where: { $0 is BrowseCollectionView }) as? BrowseCollectionView {
            collectionview.browseData = browseArray
            collectionview.reloadData()
        }
    }
}

