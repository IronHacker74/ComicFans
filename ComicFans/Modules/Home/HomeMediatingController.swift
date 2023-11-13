//
//  HomeMediatingController.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import UIKit

protocol HomeDelegate {
    func homeMediatingControllerViewDidLoad(_ vc: HomeDisplayable, offset: Int)
    func homeMediatingControllerCategoryCellTapped(browseType: BrowseType)
    func homeMediatingControllerEventTapped(event: DataSet, attribution: String?)
}

protocol HomeDisplayable {
    func updateEvents(_ newEvents: [DataSet])
    func updateCategories(_ newCategories: [BrowseType])
    func updateAttributionText(_ text: String?)
}

class HomeMediatingController: UIViewController, UIViewLoading {

    @IBOutlet private (set) var collectionview: UICollectionView!
    @IBOutlet private (set) var tableview: UITableView!
    @IBOutlet private (set) var attributionLabel: UILabel!
    
    private var delegate: HomeDelegate?
    private var events: [DataSet] = []
    private var categories: [BrowseType] = []
    private let tableviewIdentifier: String = "CurrentEventCell"
    private let collectionviewIdentifier: String = "CategoryCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .dark
        self.delegate = HomeCoordinator(request: CurrentEventRequest(), navigator: self.navigationController)
        self.navigationItem.title = "ComicFans"
        self.view.backgroundColor = .darkBlue()
        self.setupTableView()
        self.setupCollectionView()
        self.delegate?.homeMediatingControllerViewDidLoad(self, offset: 0)
    }

    private func setupTableView() {
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.register(UINib(nibName: self.tableviewIdentifier, bundle: nil), forCellReuseIdentifier: self.tableviewIdentifier)
    }

    private func setupCollectionView() {
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
    }
}

extension HomeMediatingController: HomeDisplayable {
    func updateEvents(_ newEvents: [DataSet]) {
        self.events.append(contentsOf: newEvents)
        self.tableview.reloadData()
    }
    
    func updateCategories(_ newCategories: [BrowseType]) {
        self.categories.append(contentsOf: newCategories)
        self.collectionview.reloadData()
    }
    
    func updateAttributionText(_ text: String?) {
        self.attributionLabel.text = text
    }
}

extension HomeMediatingController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.tableviewIdentifier, for: indexPath) as? CurrentEventCell else {
            return UITableViewCell()
        }
        let event = self.events[indexPath.row]
        cell.configureCell(event: event)
        cell.configureImage(image: event.image, imagePath: event.thumbnail?.fullPath, completion: { image in
            self.events[indexPath.row].image = image
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.homeMediatingControllerEventTapped(event: self.events[indexPath.row], attribution: self.attributionLabel.text)
    }
}

extension HomeMediatingController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionviewIdentifier, for: indexPath) as? CategoryCollectionCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(title: self.categories[indexPath.row].rawValue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.homeMediatingControllerCategoryCellTapped(browseType: self.categories[indexPath.row])
    }
}
