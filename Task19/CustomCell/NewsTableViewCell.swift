//
//  NewsTableViewCell.swift
//  Task19
//
//  Created by ana namgaladze on 19.04.24.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    lazy var frameView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cellBackgroundImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "testImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 14)
        label.textAlignment = .center
        label.text = "დრო"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 14)
        label.textAlignment = .center
        label.text = "აღწერა  მდჯკსნდიბივ ჯჰბციდუნ ჯრჰფიუერნფ ჰბრეიუჰფეჯწნ ჯდწნფ სჯჰხიჯსნ სდიუწქნდჯნუდჰწიუნდ "
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        contentView.addSubview(frameView)
        frameView.addSubview(cellBackgroundImageView)
        cellBackgroundImageView.addSubview(backgroundColorView)
        frameView.addSubview(timeLabel)
        frameView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            frameView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            frameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            frameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            frameView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            cellBackgroundImageView.topAnchor.constraint(equalTo: frameView.topAnchor),
            cellBackgroundImageView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor),
            cellBackgroundImageView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor),
            cellBackgroundImageView.bottomAnchor.constraint(equalTo: frameView.bottomAnchor),
            
            backgroundColorView.topAnchor.constraint(equalTo: cellBackgroundImageView.topAnchor),
            backgroundColorView.leadingAnchor.constraint(equalTo: cellBackgroundImageView.leadingAnchor),
            backgroundColorView.trailingAnchor.constraint(equalTo: cellBackgroundImageView.trailingAnchor),
            backgroundColorView.bottomAnchor.constraint(equalTo: cellBackgroundImageView.bottomAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: cellBackgroundImageView.topAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: cellBackgroundImageView.leadingAnchor, constant: 145),
            
            titleLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: cellBackgroundImageView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: cellBackgroundImageView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: frameView.bottomAnchor, constant: -16),
        ])
    }
    public func configure(title: String, time: String, image: String){
        timeLabel.text = time
        titleLabel.text = title
        if let image = URL(string: image) {
                    loadImage(url: image)
                }
        
    }
    func loadImage(url: URL) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                self.cellBackgroundImageView.image = image
            }
        }.resume()
    }
}
