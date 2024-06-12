//
//  Download.swift
//  DashboardUIMacOS
//
//  Created by Volodymyr Pysarenko on 12.06.2024.
//

import Foundation

struct Download: Identifiable {
    var id = UUID().uuidString
    var downloads: CGFloat
    var weekday: String
}

var downloads: [Download] = [
    Download(downloads: 500, weekday: "Mon"),
    Download(downloads: 600, weekday: "Tue"),
    Download(downloads: 100, weekday: "Wed"),
    Download(downloads: 900, weekday: "Thu"),
    Download(downloads: 400, weekday: "Fri"),
    Download(downloads: 700, weekday: "Sat"),
    Download(downloads: 200, weekday: "Sun"),
]
