//
//  DetailsMediatingController.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/11/23.
//

import UIKit

protocol DetailsDelegate {
    func detailsMediatingControllerViewDidLoad(_ vc: DetailsDisplayable)
}

protocol DetailsDisplayable {
    func setOutlets(data: DataSet, attribution: String?)
}

final class DetailsMediatingController: UIViewController {
    @IBOutlet private (set) var thumbnailImage: UIImageView!
    @IBOutlet private (set) var tableview: UITableView!
    @IBOutlet private (set) var attributionLabel: UILabel!
    
    private let delegate: DetailsDelegate?
    private let cell: String = "DetailsTableViewCell"
    private var details: [AdditionalItems] = []
    
    init(delegate: DetailsDelegate?) {
        self.delegate = delegate
        super.init(nibName: "DetailsMediatingController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.view.backgroundColor = .darkBlue()
        self.delegate?.detailsMediatingControllerViewDidLoad(self)
    }
    
    func setupTableView() {
        self.tableview.backgroundColor = .cream()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: self.cell)
    }
    
    func validDescription(_ text: String?) -> Bool {
        guard let text, !text.isEmpty else {
            return false
        }
        return true
    }
}

extension DetailsMediatingController: DetailsDisplayable {
    func setOutlets(data: DataSet, attribution: String?) {
        self.navigationItem.title = data.getTitle()
        self.thumbnailImage.image = data.image
        self.attributionLabel.text = attribution
        self.addDescription(data.description)
        self.addToDetails(additionalItems: data.characters, browseType: .characters)
        self.addToDetails(additionalItems: data.comics, browseType: .comics)
        self.addToDetails(additionalItems: data.creators, browseType: .creators)
        self.addToDetails(additionalItems: data.events, browseType: .events)
        self.addToDetails(additionalItems: data.series, browseType: .series)
        self.addToDetails(additionalItems: data.stories, browseType: .stories)
        self.tableview.reloadData()
    }
    
    private func addDescription(_ description: String?) {
        guard let description, !description.isEmpty else {
            return
        }
        let item = AdditionalItems.Item(resourceURI: nil, name: description, type: nil)
        let descriptionItem = AdditionalItems(items: [item], category: "")
        self.addToDetails(additionalItems: descriptionItem, browseType: .none)
    }
    
    private func addToDetails(additionalItems: AdditionalItems?, browseType: BrowseType) {
        if var additionalItems, additionalItems.items.count > 0 {
            additionalItems.category = browseType.rawValue.firstUppercased
            self.details.append(additionalItems)
        }
    }
}

extension DetailsMediatingController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.details.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.details[section].items.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .systemGray
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.details[section].category
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cell, for: indexPath) as? DetailsTableViewCell else {
            return UITableViewCell()
        }
        let item = self.details[indexPath.section].items[indexPath.row]
        cell.configureCell(text: item.name)
        return cell
    }
    
    
}
