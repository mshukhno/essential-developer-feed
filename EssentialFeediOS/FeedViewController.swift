//
//  FeedViewController.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 18/01/2025.
//

import EssentialFeed
import UIKit

public protocol FeedImageDataLoader {
    func loadImageData(from url: URL)
}

final public class FeedViewController: UITableViewController  {
    private var feedLoader: FeedLoader?
    private var tableModel = [FeedImage]()
    private var imageLoader: FeedImageDataLoader?
    
    public init(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) {
        self.feedLoader = feedLoader
        self.imageLoader = imageLoader
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        load()
    }
    
    @objc private func load() {
        refreshControl?.beginRefreshing()
        
        feedLoader?.load { [weak self] result in
            if let feed = try? result.get() {
                self?.tableModel = feed
                self?.tableView.reloadData()
            }
            
            self?.refreshControl?.endRefreshing()
        }
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = tableModel[indexPath.row]
        let cell = FeedImageCell()
        cell.locationContainer.isHidden = cellModel.location == nil
        cell.locationLabel.text = cellModel.location
        cell.descriptionLabel.text = cellModel.description
        
        imageLoader?.loadImageData(from: cellModel.url)
        
        return cell
    }
}
