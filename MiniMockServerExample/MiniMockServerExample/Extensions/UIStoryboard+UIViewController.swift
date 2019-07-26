//
//  UIStoryboard+UIViewController.swift
//  GBook
//
//  Created by Ngoc LE on 2/28/19.
//  Copyright © 2019 Ngoc LE. All rights reserved.
//

import UIKit

extension UIStoryboard {
    /// A shortcut function allows to open an UIViewController from storyboard
    func instantiate<T: UIViewController>() -> T? where T: Reusable {
        return instantiateViewController(withIdentifier: T.reuseIdentifier) as? T
    }
}
