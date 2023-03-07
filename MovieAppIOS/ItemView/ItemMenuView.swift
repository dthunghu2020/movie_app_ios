//
//  ItemMenuView.swift
//  MovieAppIOS
//
//  Created by hungdt on 07/03/2023.
//

import UIKit

class ItemMenuView: UIView {

    let iconCategory: UIImageView = {
        let iconCategory = UIImageView()
        iconCategory.translatesAutoresizingMaskIntoConstraints = false
        iconCategory.contentMode = .scaleAspectFit
        return iconCategory
    } ()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 10)
        title.numberOfLines = 0
        return title
        
    }()
    
    var gradient = CAGradientLayer()
    
    @IBInspectable
    var image: UIImage = UIImage(systemName: "tv")! {
        didSet{
            self.iconCategory.image = image
        }
    }
    @IBInspectable
    var desc: String = "" {
        didSet{
            self.title.text = desc
        }
    }
    
    var onPress: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
    
    func setupView(){
        let leftColor = UIColor(red: 0.65, green: 0.63, blue: 0.88, alpha: 0.3).cgColor
        let rightColor = UIColor(red: 0.63, green: 0.95, blue: 1.00, alpha: 0.3).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [leftColor, rightColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .clear
        
        self.addSubview(iconCategory)
        self.addSubview(title)
        
        // AUTO LAYOUT
        
        iconCategory.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconCategory.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        iconCategory.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        iconCategory.heightAnchor.constraint(equalTo: iconCategory.widthAnchor, multiplier: 1).isActive = true
        
        title.centerXAnchor.constraint(equalTo: iconCategory.centerXAnchor).isActive = true
        title.topAnchor.constraint(equalTo: iconCategory.bottomAnchor, constant: 10).isActive = true
        title.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapImage() {
        onPress?(desc)
    }
}
