//
//  TabBarViewModel.swift
//  custom_tab_bar
//
//  Created by TE-Member on 08/12/2023.
//

import Foundation



enum Tab: String, CaseIterable {
    case home = "Home"
    case news = "News"
    case settings = "Settings"
}

class TabBarViewModel: ObservableObject {
    @Published var currentTab: Tab = .home
    @Published var detailCard: Card?
    @Published var showDetail:Bool = false
}
