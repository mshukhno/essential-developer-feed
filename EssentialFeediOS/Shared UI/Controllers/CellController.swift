//
//  CellController.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 13/02/2025.
//

import UIKit

public struct CellController {
    let id: AnyHashable
    let dataSource: UITableViewDataSource
    let delegate: UITableViewDelegate?
    let dataSourceFetching: UITableViewDataSourcePrefetching?
    
    public init(id: AnyHashable, _ dataSource: UITableViewDataSource & UITableViewDelegate & UITableViewDataSourcePrefetching) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = dataSource
        self.dataSourceFetching = dataSource
    }
    
    public init(id: AnyHashable, _ dataSource: UITableViewDataSource) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = nil
        self.dataSourceFetching = nil
    }
}

extension CellController: Equatable {
    public static func == (lhs: CellController, rhs: CellController) -> Bool {
        lhs.id == rhs.id
    }
}

extension CellController: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
