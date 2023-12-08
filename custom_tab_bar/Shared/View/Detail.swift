//
//  Detail.swift
//  custom_tab_bar
//
//  Created by TE-Member on 08/12/2023.
//

import SwiftUI

struct Detail: View {
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    var animation: Namespace.ID
    var body: some View {
        if let card = tabBarViewModel.detailCard, tabBarViewModel.showDetail {
            VStack(alignment: .leading){
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(card.id)IMG", in: animation)
                    .background(
                        LinearGradient(colors: [
                            Color(hex: card.cardColor).opacity(1),
                            Color(hex: card.cardColor).opacity(0)
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .matchedGeometryEffect(id: "\(card.id)BG", in: animation)
                    )
                    .overlay(alignment: .bottomTrailing){
                        Button {
                            withAnimation{
                                tabBarViewModel.showDetail = false
                                tabBarViewModel.detailCard = nil
                            }
                        }label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(8)
                                .background(.white, in: Circle())
                                .padding()
                        }
                    }
                Text(card.title)
                    .font(.title2.bold())
                    .matchedGeometryEffect(id: "\(card.id)TITLE", in: animation)
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.bottom,16)
                    .foregroundColor(.red.opacity(0.9))
                    
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(1...20, id: \.self){ index in
                            Button {
                                
                            }label: {
                                HStack{
                                    Image(systemName: "swift")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24)
                                        .padding(.vertical)
                                        .padding(.horizontal,24)
                                    
                                    Text("Lesson \(index)")
                                        .padding(.trailing, 16)
                                    Spacer()
                                    Image(systemName: "play.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24)
                                        .padding(.vertical)
                                        .padding(.horizontal,24)
                                        
                                }
                                .frame(maxWidth: .infinity)
                                .background(
                                    .ultraThinMaterial, in: Capsule()
                                )
                        
                            }
                           
                            .foregroundColor(.black)
                          
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .ignoresSafeArea()
            .padding(.bottom)
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    @Namespace var animation
    let tabBarViewModel: TabBarViewModel = TabBarViewModel()
    tabBarViewModel.showDetail = true
    tabBarViewModel.detailCard = cards.first
   return  Detail( animation: animation)
        .environmentObject(tabBarViewModel)
}
