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
    
    @IBOutlet private (set) var descriptionBackground: ShadowView!
    @IBOutlet private (set) var descriptionLabel: UILabel!
    @IBOutlet private (set) var thumbnailImage: UIImageView!
    @IBOutlet private (set) var attributionLabel: UILabel!
    
    private let delegate: DetailsDelegate?
    
    init(delegate: DetailsDelegate?) {
        self.delegate = delegate
        super.init(nibName: "DetailsMediatingController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate?.detailsMediatingControllerViewDidLoad(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsMediatingController: DetailsDisplayable {
    func setOutlets(data: DataSet, attribution: String?) {
        self.navigationItem.title = data.getTitle()
        self.descriptionLabel.text = data.description
        self.thumbnailImage.image = data.image
        self.attributionLabel.text = attribution
    }
}
