//
//  UICollectionView+Reusable.swift
//  MiniMockServerExample
//
//  Created by Ngoc LE on 2/28/19.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import UIKit

extension UICollectionView {
    /// A shortcut function allows to dequeue an UICollectionView based on Type
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? where T: Reusable {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
}
