//
//  CustomTabBar.swift
//  custom_tab_bar
//
//  Created by TE-Member on 08/12/2023.
//

import SwiftUI

struct CustomTabBar: View {
    
    init(){
        UITabBar.appearance().isHidden  = true
    }

    @StateObject var tabBarViewModel = TabBarViewModel()
    @Namespace var animation
    var body: some View {
        TabView(selection: $tabBarViewModel.currentTab){
            Home(animation: animation)
                .tag(Tab.home)
            Text(Tab.news.rawValue)
                .tag(Tab.news)
            Text(Tab.settings.rawValue)
                .tag(Tab.settings)
        }
        .overlay(alignment: .bottom){
            HStack {
                TabBarButton(tab: .home , image: "house", animation: animation)
                TabBarButton(tab: .news , image: "newspaper", animation: animation)
                TabBarButton(tab: .settings , image: "gearshape", animation: animation)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(.ultraThinMaterial, in: Capsule())
            .padding(.horizontal)
            .padding(.bottom, 8)
            .shadow(color: .black.opacity(0.09), radius: 5, x: 5, y: 5)
            .shadow(color: .black.opacity(0.09), radius: 5, x: -5, y: 0)
        }
        .overlay{
            Detail(animation: animation)
        }
        .environmentObject(tabBarViewModel)
    }
    
}

struct TabBarButton : View {
    var tab: Tab
    var image: String
    var animation: Namespace.ID
    
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    
    var body: some View {
        Button{
            withAnimation{
                tabBarViewModel.currentTab = tab
            }
        }label: {
            VStack{
                Image(systemName: image)
                    .font(.title2)
                    .frame(height: 16)
                Text(tab.rawValue)
                    .font(.caption.bold())
            }
            .foregroundColor(tabBarViewModel.currentTab == tab ?
                .green : .gray)
            .frame(maxWidth: .infinity)
            .overlay{
                ZStack {
                    if tabBarViewModel.currentTab == tab {
                        TabBarIndicator()
                            .fill(
                                .linearGradient(.init(
                                    colors: [.pink.opacity(0.2), .pink.opacity(0.1),.clear]
                                ), startPoint: .top, endPoint: .bottom)
                            )
                            .offset(x: 0 , y: -8)
                            .padding(.horizontal, 8)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            
            }
        }
    }
}

struct TabBarIndicator: Shape {
    func path(in rect: CGRect) -> Path {
        return Path {path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width - 10, y: rect.height))
            path.addLine(to: CGPoint(x: 10, y: rect.height))
        };
    }
}


#Preview {
    CustomTabBar()
}
