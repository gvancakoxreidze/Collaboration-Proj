//
//  TableViewCell.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import UIKit

class ProductListCell: UITableViewCell {
    
    let counterView = CartCounter()
    
    let contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 217/255, green: 219/255, blue: 233/255, alpha: 1.0).cgColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = Typography.labelFont
        titleLabel.textColor = Typography.labelTextColor
        titleLabel.textAlignment = Typography.labelTextAlignment
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.font = Typography.labelFont
        countLabel.textColor = Typography.labelTextColor
        countLabel.textAlignment = Typography.labelTextAlignment
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        return countLabel
    }()
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = Typography.labelFont
        priceLabel.textColor = Typography.labelTextColor
        priceLabel.textAlignment = Typography.labelTextAlignment
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init code error")
    }
    
    private func setupViews() {
        contentView.isUserInteractionEnabled = true
        
        contentView.addSubview(contentContainerView)
        
        contentContainerView.addSubview(titleLabel)
        contentContainerView.addSubview(countLabel)
        contentContainerView.addSubview(priceLabel)
        contentContainerView.addSubview(productImageView)
        contentContainerView.addSubview(counterView)
        counterView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contentContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            contentContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            contentContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            productImageView.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor),
            productImageView.leftAnchor.constraint(equalTo: contentContainerView.leftAnchor, constant: 12),
            productImageView.widthAnchor.constraint(equalToConstant: 116),
            productImageView.heightAnchor.constraint(equalToConstant: 115),
            
            titleLabel.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            countLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            
            priceLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 10),
            priceLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            
            counterView.rightAnchor.constraint(equalTo: contentContainerView.rightAnchor),
            counterView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            counterView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(item: ProductListModel) {
        titleLabel.text = item.product.title
        if item.product.stock > 0 {
            countLabel.text = "Stock: \(item.product.stock)"
            countLabel.textColor = Typography.labelTextColor
        } else {
            countLabel.text = "Out of Stock"
            countLabel.textColor = .red
        }
        priceLabel.text = "Price: \(item.product.price)"
        productImageView.load(from: URL(string: item.product.thumbnail)!)
        counterView.count = item.count
        counterView.product = item
    }
    
    struct Typography {
        static let labelFont: UIFont = {
            if let font = UIFont(name: "Inter", size: 12) {
                return UIFontMetrics.default.scaledFont(for: font)
            }
            return UIFont.systemFont(ofSize: 12, weight: .bold)
        }()
        
        static let labelTextColor: UIColor = .black
        static let labelTextAlignment: NSTextAlignment = .left
    }
}

