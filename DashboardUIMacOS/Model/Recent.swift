//
//  Recent.swift
//  DashboardUIMacOS
//
//  Created by Volodymyr Pysarenko on 12.06.2024.
//

import Foundation

struct Recent: Identifiable {
    var id = UUID().uuidString
    var title: String
    var price: String
    var image: String
}

var recents: [Recent] = [
    Recent(title: "Transfer via card number.", price: "$1200", image: "creditcard"),
    Recent(title: "Transfer other banks", price: "$1500", image: "arrow.left.arrow.right"),
    Recent(title: "Transfer same bank", price: "$1700", image: "building.columns"),
    Recent(title: "Transfer via \npaypal", price: "$9200", image: "building.2.fill")
]
