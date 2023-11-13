//
//  BrowseMediatingController.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import UIKit

protocol BrowseDelegate {
    func browseViewDidLoad(_ vc: any BrowseDisplayable, offset: Int)
    func browseCollectionViewCellTapped(dataSet: DataSet, attribution: String?)
}

protocol BrowseDisplayable: BrowseCollectionViewDelegate {
    func updateBrowseCollectionView(browseArray: [DataSet])
    func updateAttributionText(_ text: String?)
    func setupCollectionview()
    func setupTableview(dataSet: DataSet)
}

protocol BrowseCollectionViewDelegate {
    func collectionViewCellTapped(dataSet: DataSet)
}

final class BrowseMediatingController: UIViewController {
    
    @IBOutlet private (set) var searchbar: UISearchBar!
    @IBOutlet private (set) var browseContentView: UIStackView!
    @IBOutlet private (set) var attributionLabel: UILabel!
    
    private var delegate: BrowseDelegate?
    private var screenTitle: String

    init(delegate: BrowseDelegate?, screenTitle: String) {
        self.delegate = delegate
        self.screenTitle = screenTitle
        super.init(nibName: "BrowseMediatingController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkBlue()
        self.searchbar.barTintColor = .darkRed()
        self.searchbar.tintColor = .white
        self.navigationItem.title = self.screenTitle
        self.delegate?.browseViewDidLoad(self, offset: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension BrowseMediatingController: BrowseDisplayable {
    func setupCollectionview() {
        let collectionview = BrowseCollectionView(browseDelegate: self)
        collectionview.backgroundColor = .clear
        self.browseContentView.addArrangedSubview(collectionview)
    }
    
    func setupTableview(dataSet: DataSet) {
        // TODO: setup tableview
    }
    
    func updateBrowseCollectionView(browseArray: [DataSet]) {
        if let collectionview = browseContentView.subviews.first(where: { $0 is BrowseCollectionView }) as? BrowseCollectionView {
            collectionview.browseData = browseArray
            collectionview.reloadData()
        }
    }
    
    func updateAttributionText(_ text: String?) {
        self.attributionLabel.text = text
    }
    
    func collectionViewCellTapped(dataSet: DataSet) {
        self.delegate?.browseCollectionViewCellTapped(dataSet: dataSet, attribution: self.attributionLabel.text)
    }
}

