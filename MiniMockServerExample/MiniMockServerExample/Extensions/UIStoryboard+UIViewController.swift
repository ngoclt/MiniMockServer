//
//  UIStoryboard+UIViewController.swift
//  MiniMockServerExample
//
//  Created by Ngoc LE on 2/28/19.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import UIKit

extension UIStoryboard {
    /// A shortcut function allows to open an UIViewController from storyboard
    func instantiate<T: UIViewController>() -> T? where T: Reusable {
        return instantiateViewController(withIdentifier: T.reuseIdentifier) as? T
    }
}
