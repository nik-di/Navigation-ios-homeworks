//
//  Post.swift
//  Navigation
//
//  Created by D.Nikishin on 23.03.2022.
//

import Foundation

struct UserPost {
	let author: String
	let description: String
	let image: String
	var likes: Int
	var views: Int
}

let posts = [
	UserPost(author: "Apple", description: "Apple представляет M1 Pro и M1 Max — самые мощные...", image: "m1-max", likes: 5, views: 5),
	UserPost(author: "Майкл Бэй", description: "Напарники охотятся за бандитами, которые выкрали героин из полицейского участка. Хулиганский боевик Майкла Бэя", image: "bad-boys-1", likes: 61, views: 113_398),
	UserPost(author: "IXBt", description: "Возможный iPhone 14 без чёлки показали за год до...", image: "iphone-14", likes: 2, views: 2),
	UserPost(author: "porsche.com", description: "В 1994 модельном году 964 модельная линейка была заменена линейкой 993 модели. Это было значительным шагом вперед не только с технической, но также и с визуальной точки зрения", image: "p911-993", likes: 5, views: 5)
]
