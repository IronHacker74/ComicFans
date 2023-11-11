//
//  BrowseCollectionView.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import UIKit

final class BrowseCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UIViewLoading {
    
    private var browseDelegate: BrowseCollectionViewDelegate?
    var browseData: [DataSetProtocol] = []
    private let cellIdentifier = "BrowseCollectionViewCell"
    
    init(browseDelegate: BrowseCollectionViewDelegate?) {
        self.browseDelegate = browseDelegate
        super.init(frame: .zero, collectionViewLayout: UICollectionPageLayout.createLayout())
        self.dataSource = self
        self.delegate = self
        self.register(UINib(nibName: self.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: self.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.browseData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? BrowseCollectionViewCell else {
            return UICollectionViewCell()
        }
        let dataset = self.browseData[indexPath.row]
        cell.configureCell(imageURL: dataset.thumbnail?.fullPath, title: dataset.getTitle(), description: dataset.description)
        return cell
    }
}
