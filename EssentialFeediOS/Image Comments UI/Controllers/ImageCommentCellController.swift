//
//  ImageCommentCellController.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 12/02/2025.
//

import UIKit
import EssentialFeed

public final class ImageCommentCellController: NSObject, CellController {
    private let model: ImageCommentViewModel
    
    public init(model: ImageCommentViewModel) {
        self.model = model
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageCommentCell = tableView.dequeueReusableCell()
        cell.dateLabel.text = model.date
        cell.usernameLabel.text = model.username
        cell.messageLabel.text = model.message
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) { }
    
}
