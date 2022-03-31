//
//  Images.swift
//  Navigation
//
//  Created by D.Nikishin on 31.03.2022.
//

import UIKit

fileprivate let photoNames: [Int] = Array.init(1...20)

let photos: [UIImage] = photoNames.compactMap { name in
	let image = UIImage(named: String(name))
	return image
}
