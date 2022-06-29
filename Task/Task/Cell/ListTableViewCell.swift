//
//  ListTableViewCell.swift
//  Task
//
//  Created by apple on 29/06/22.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {

    /// Handling response data for cell and downloading image using third party framework Kingfisher
    var item : Row? {
        didSet {
            productNameLabel.text = item?.title
            productDescriptionLabel.text = item?.rowDescription
            if let  imageUrl = URL(string: item?.imageHref ?? "") {
                productImage.kf.indicatorType = .activity
                productImage.kf.setImage(
                    with: imageUrl,
                    placeholder: UIImage(named: "placeholder"),
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            } else {
                productImage.image = nil
            }
        }
    }
    
    /// Create product name label for cell
    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        if #available(iOS 13.0, *) {
            lbl.textColor = .label
        } else {
            // Fallback on earlier versions
            lbl.textColor = .darkText

        }
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.textAlignment = .left
        return lbl
    }()
    
    /// Create product description label for cell
    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        if #available(iOS 13.0, *) {
            lbl.textColor = .label
        } else {
            // Fallback on earlier versions
            lbl.textColor = .darkText

        }
        lbl.font = UIFont.preferredFont(forTextStyle: .body)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    /// Create product imageView for cell
    private let productImage : ScaleAspectFitImageView = {
        let imgView = ScaleAspectFitImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    ///  Adding all cell elements into stackView and provide auto layouts for stackView programatically
    /// - Parameters:
    ///   - style: style for UITableViewCell
    ///   - reuseIdentifier: passing unique value for cell to reuseIdentifier
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
  
        self.selectionStyle = .none
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            self.backgroundColor = .white
        }
        let stackView = UIStackView(arrangedSubviews: [productImage,productNameLabel,productDescriptionLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
