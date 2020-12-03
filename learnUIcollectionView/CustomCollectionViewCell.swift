//
//  CustomCollectionViewCell.swift
//  learnUIcollectionView
//
//  Created by flow on 03/12/20.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let myImageView: UIImageView = {
        
        let imageView = UIImageView()
        
//        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        return imageView
        
    }()
    
    
    private let myLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Custom"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
        
    }()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myLabel.frame = CGRect (x: 5,
                                y: contentView.frame.size.height-50,
                                width: contentView.frame.size.width-10,
                                height: 50)
        myImageView.frame = CGRect (x: 5,
                                y: 0,
                                width: contentView.frame.size.width-10,
                                height: contentView.frame.size.height-50)
        
        
    }
    
    public func configure(label: String , image: String) {
        myLabel.text = label
        myImageView.downloaded(from: image)
    }
    
    override func prepareForReuse() {
        myLabel.text = nil
        myImageView.image = nil
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
