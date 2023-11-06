//
//  HomeMediatingController.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import UIKit

protocol HomeDelegate {
    func homeMediatingControllerViewDidLoad(_ vc: HomeDisplayable, offset: Int)
}

protocol HomeDisplayable {
    func updateEvents(_ newEvents: [Event])
    func updateCategories(_ newCategories: [HomeComicFansCategory])
}

class HomeMediatingController: UIViewController {

    @IBOutlet private (set) var collectionview: UICollectionView!
    @IBOutlet private (set) var tableview: UITableView!
    @IBOutlet private (set) var copyrightLabel: UILabel!
    
    private var delegate: HomeDelegate?
    private var events: [Event] = []
    private var categories: [HomeComicFansCategory] = []
    private let tableviewIdentifier: String = "CurrentEventCell"
    private let collectionviewIdentifier: String = "CategoryCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = HomeCoordinator(request: CurrentEventRequest())
        self.navigationItem.title = "ComicFans"
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
    func updateEvents(_ newEvents: [Event]) {
        self.events.append(contentsOf: newEvents)
        self.tableview.reloadData()
    }
    
    func updateCategories(_ newCategories: [HomeComicFansCategory]) {
        self.categories.append(contentsOf: newCategories)
        self.collectionview.reloadData()
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
        cell.configureCell(event: self.events[indexPath.row])
        return cell
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
        cell.configureCell(title: self.categories[indexPath.row].title.rawValue)
        return cell
    }
    
    
}