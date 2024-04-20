//
//  NewsController.swift
//  Task19
//
//  Created by ana namgaladze on 19.04.24.
//  ["FiraGO-Medium"] ["SpaceGrotesk-Bold"]

import UIKit
class NewsController: UIViewController {
    //MARK: ---Properties
    var newsLabel: UILabel = {
        var label = UILabel()
        label.text = "Panicka News"
        label.font = UIFont(name: "SpaceGrotesk-Bold", size: 24)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    var newsArray: [NewsItem] = []
    //MARK: ---Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewsLabel()
        addTableView()
        getNewsData()
    }
    
    //MARK: ---Methods
    func addNewsLabel() {
        view.addSubview(newsLabel)
        NSLayoutConstraint.activate([
            newsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            newsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            newsLabel.widthAnchor.constraint(equalToConstant: 158),
            newsLabel.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
    
    func addTableView() {
        self.view.addSubview(newsTableView)
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 111),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
        ])
        newsTableView.rowHeight = 128
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
    }
    //    var newsArray: [NewsItem] = []
    func getNewsData() {
        let urlString = "https://imedinews.ge/api/categorysidebarnews/get"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data:", error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                DispatchQueue.main.async {
                    self.newsArray = responseData.list
                    self.newsTableView.reloadData()
                }
                
            } catch {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    
    
}


extension NewsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("error")
        }
        let currentCell = newsArray[indexPath.row]
        cell.configure(title: currentCell.title, time: currentCell.time, image: currentCell.photoUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newsDetailVC = DetailsController()
        newsDetailVC.selectedNewsItem = newsArray[indexPath.row]
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }
}








#Preview {
    NewsController()
}

