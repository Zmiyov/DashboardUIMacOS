//
//  History.swift
//  DashboardUIMacOS
//
//  Created by Volodymyr Pysarenko on 12.06.2024.
//

import Foundation

struct History: Identifiable {
    var id = UUID().uuidString
    var image: String
    var description: String
    var time: String
    var amount: String
}

var histories: [History] = [
    History(image: "pic1", description: "Loan", time: "10:39 PM", amount: "$320"),
    History(image: "pic2", description: "Macbook Pro", time: "11:39 PM", amount: "$2200"),
    History(image: "pic3", description: "Google", time: "08:39 PM", amount: "$120")
]
