//
//  Card.swift
//  custom_tab_bar
//
//  Created by TE-Member on 08/12/2023.
//

import Foundation
import SwiftUI

struct Card :Identifiable, Equatable {
    var id = UUID().uuidString
    var title: String
    var image: String
    var cardColor: String
}

var cards: [Card] = [
    Card(title: "Swift Course For Beginner", image: "img1", cardColor: "edcece"),
    Card(title: "Java Course For Beginner", image: "img2", cardColor: "edcece"),
    Card(title: "Python Course For Beginner", image: "img3", cardColor: "d2fcf8"),
]

