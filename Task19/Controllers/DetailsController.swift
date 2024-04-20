//
//  DetailsController.swift
//  Task19
//
//  Created by ana namgaladze on 19.04.24.
//

import UIKit

class DetailsController: UIViewController {
    //MARK: ---Properties
    var detailsLabel: UILabel = {
        var label = UILabel()
        label.text = "Details"
        label.font = UIFont(name: "SpaceGrotesk-Bold", size: 24)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detailsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "testImage")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        return image
    }()
    
    var detailsTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "FiraGO-Medium", size: 14)
        label.textAlignment = .center
        label.text = "18:54"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var infoTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat, turpis ut laoreet ullamcorper, lectus est posuere libero, ac varius sem felis nec libero. Fusce a risus at risus tincidunt hendrerit. Ut ut libero in magna venenatis ultricies. Aliquam in justo enim. Morbi et eros ut justo ultrices dapibus id at nunc. Curabitur sed ipsum nec nulla vehicula rhoncus. Integer ultricies consequat est, a accumsan risus consequat id. Suspendisse potenti. Donec id nisl luctus, tincidunt est sed, rutrum risus. Nulla facilisi. Sed eget felis volutpat, bibendum tortor id, volutpat est. Vivamus ac tortor varius, fringilla neque in, cursus eros. Mauris pretium eleifend nunc id lobortis. Curabitur dignissim nunc eros, vel pharetra ex commodo eu. Nam nec ex enim. Quisque nec enim dictum, venenatis tortor sed, dapibus magna. Nullam eleifend libero nec nisl lacinia, sed tempor sapien feugiat. Aliquam erat volutpat. Integer id purus ac justo lacinia consectetur non sit amet ex. Sed dignissim sapien a nisi suscipit, in laoreet arcu dapibus. Pellentesque luctus orci enim, sed cursus velit suscipit sed. Ut efficitur tincidunt odio, nec lacinia est vehicula id. Aenean suscipit ante nec rutrum fermentum. Vivamus eget lorem nec mauris consectetur ullamcorper. Nulla eget enim quam. Morbi porttitor magna nec dui scelerisque, sit amet consectetur orci iaculis. Aliquam nec aliquet nisl. Sed ullamcorper, ex at vehicula vehicula, enim lectus ultrices odio, id vehicula elit libero ut mauris. Ut eu diam eget arcu dapibus semper nec et dui. "
        textView.font = UIFont(name: "FiraGO-Medium", size: 14)
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    var selectedNewsItem: NewsItem?
    //MARK: ---Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        addDetailsLabel()
        addDetailsImage()
        addTimeLabel()
        addInfoTextView()
        changedData()
        
    }
    
    //MARK: ---Methods
    func addDetailsLabel() {
        view.addSubview(detailsLabel)
        NSLayoutConstraint.activate([
            //            newsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            detailsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            detailsLabel.widthAnchor.constraint(equalToConstant: 80),
            detailsLabel.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
    
    
    func addDetailsImage() {
        view.addSubview(detailsImage)
        NSLayoutConstraint.activate([
            detailsImage.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 10),
            detailsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsImage.heightAnchor.constraint(equalToConstant: 190),
            detailsImage.widthAnchor.constraint(equalToConstant: 327),
        ])
    }
    
    func addTimeLabel() {
        view.addSubview(detailsTimeLabel)
        NSLayoutConstraint.activate([
            detailsTimeLabel.topAnchor.constraint(equalTo: detailsImage.bottomAnchor, constant: 13),
            detailsTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24),
        ])
    }
    
    func addInfoTextView() {
        view.addSubview(infoTextView)
        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: detailsTimeLabel.bottomAnchor, constant: 26),
            infoTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoTextView.heightAnchor.constraint(equalToConstant: 287),
            infoTextView.widthAnchor.constraint(equalToConstant: 303),
        ])
    }
    
    private func changedData() {
        guard let selectedNewsItem = selectedNewsItem else { return }
        if let imageUrl = URL(string: selectedNewsItem.photoUrl) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.detailsImage.image = image
                    }
                }
            }.resume()
        }
        
        infoTextView.text = selectedNewsItem.title
        detailsTimeLabel.text = selectedNewsItem.time
    }
}


#Preview {
    DetailsController()
}
