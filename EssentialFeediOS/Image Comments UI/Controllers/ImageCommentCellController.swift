//
//  ImageCommentCellController.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 12/02/2025.
//

import UIKit
import EssentialFeed

public final class ImageCommentCellController: CellController {
    private let model: ImageCommentViewModel
    
    public init(model: ImageCommentViewModel) {
        self.model = model
    }
    
    public func view(in tableView: UITableView) -> UITableViewCell {
        let cell: ImageCommentCell = tableView.dequeueReusableCell()
        cell.dateLabel.text = model.date
        cell.usernameLabel.text = model.username
        cell.messageLabel.text = model.message
        
        return cell
    }
}
