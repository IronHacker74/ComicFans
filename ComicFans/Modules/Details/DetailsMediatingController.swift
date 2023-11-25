//
//  DetailsMediatingController.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/11/23.
//

import UIKit

protocol DetailsDelegate {
    func detailsMediatingControllerViewDidLoad(_ vc: DetailsDisplayable)
    func detailsMediatingControllerDidSelectRow(detailsPath: String)
    func shareInfoLink()
}

protocol DetailsDisplayable: UIViewLoading, ProcessingView, ErrorAlert {
    func setOutlets(data: DataSet, attribution: String?)
}

final class DetailsMediatingController: UIViewController {
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
    
    func setupMoreInfoNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up.fill"), style: .plain, target: self, action: #selector(self.didTouchShareLink))
        self.navigationItem.rightBarButtonItem?.tintColor = .mediumBlue()
    }
    
    func setupTableView() {
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
    
    @objc func didTouchShareLink() {
        self.delegate?.shareInfoLink()
    }
}

extension DetailsMediatingController: DetailsDisplayable {
    func beginProcessing() {
        self.beginProcessing(self.view)
    }
    
    func finishProcessing() {
        self.finishProcessing(self.view)
    }
    
    func setOutlets(data: DataSet, attribution: String?) {
        if let urls = data.urls, urls.isEmpty == false {
            self.setupMoreInfoNavigationItem()
        }
        self.navigationItem.title = data.getTitle()
        self.setupImage(data.image, imagePath: data.thumbnail?.fullPath)
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
    
    private func setupImage(_ image: UIImage?, imagePath: String?) {
        guard let image else {
            self.downloadImage(imagePath: imagePath)
            return
        }
        self.setupTableViewImageHeader(image)
    }
    
    private func downloadImage(imagePath: String?) {
        guard let imagePath else { return }
        let imageView = UIImageView()
        imageView.downloaded(from: imagePath, contentMode: .scaleAspectFill, completion: { image in
            guard let image else { return }
            self.setupImage(image, imagePath: nil)
        })
    }
    
    private func setupTableViewImageHeader(_ image: UIImage) {
        let heightMultiple = self.view.frame.size.width / image.size.width
        let height = image.size.height * heightMultiple
        
        let frame = CGRectMake(0, 0, self.view.frame.size.width, height)
        let headerImageView = UIImageView(frame: frame)
        headerImageView.image = image
        self.tableview.tableHeaderView = headerImageView
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
        header.textLabel?.textColor = .label
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemURI = self.details[indexPath.section].items[indexPath.row].resourceURI else {
            self.tableview.deselectRow(at: indexPath, animated: false)
            return
        }
        self.delegate?.detailsMediatingControllerDidSelectRow(detailsPath: itemURI)
        self.tableview.deselectRow(at: indexPath, animated: false)
    }
}
