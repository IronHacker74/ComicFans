//
//  BrowseCollectionView.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/6/23.
//

import UIKit

final class BrowseCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UIViewLoading {
    
    private var browseDelegate: BrowseCollectionViewDelegate?
    var browseData: [DataSet] = []
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
        cell.configureCell(title: dataset.getTitle(), description: dataset.description)
        cell.configureImage(image: dataset.image, imagePath: dataset.thumbnail?.fullPath, completion: { image in
            self.browseData[indexPath.row].image = image
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.browseDelegate?.collectionViewCellTapped(dataSet: self.browseData[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > (self.browseData.count - 10) {
            self.browseDelegate?.collectionViewContinueDownload(offset: self.browseData.count)
        }
    }
}
