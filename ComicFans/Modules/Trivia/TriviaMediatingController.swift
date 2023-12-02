//
//  TriviaMediatingController.swift
//  ComicFans
//
//  Created by Andrew Masters on 12/1/23.
//

import UIKit

protocol TriviaDelegate {
    func triviaMediatingControllerViewDidLoad(_ vc: TriviaDisplayable)
}

protocol TriviaDisplayable {
    func updateTriviaData(_ fetchedData: [DataSet], attributionText: String?)
}

final class TriviaMediatingController: UIViewController {
    @IBOutlet private (set) var collectionview: UICollectionView!
    @IBOutlet private (set) var attributionLabel: UILabel!
    
    private let delegate: TriviaDelegate?
    private let cellIdentifier = "TriviaCollectionViewCard"
    private var triviaData: [DataSet] = []
    
    init(delegate: TriviaDelegate?) {
        self.delegate = delegate
        let nibName = String(describing: TriviaMediatingController.self)
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkBlue()
        self.navigationItem.title = "MARVEL TRIVIA"
        self.setupCollectionView()
        self.delegate?.triviaMediatingControllerViewDidLoad(self)
    }
    
    private func setupCollectionView() {
        self.collectionview.collectionViewLayout = UICollectionPageLayout.createLayout()
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        self.collectionview.register(UINib(nibName: self.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: self.cellIdentifier)
    }
}

extension TriviaMediatingController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.triviaData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? TriviaCollectionViewCard else {
            return UICollectionViewCell()
        }
        cell.configureCell(dataset: self.triviaData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TriviaCollectionViewCard else { return }
        cell.cardViewTapped()
    }
}

extension TriviaMediatingController: TriviaDisplayable {
    func updateTriviaData(_ fetchedData: [DataSet], attributionText: String?) {
        self.triviaData = fetchedData
        self.collectionview.reloadData()
        self.attributionLabel.text = attributionText
    }
}
