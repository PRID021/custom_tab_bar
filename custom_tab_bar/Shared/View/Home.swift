//
//  Home.swift
//  custom_tab_bar
//
//  Created by TE-Member on 08/12/2023.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    var animation: Namespace.ID
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 16){
                Text("Best Selling")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity , alignment: .leading)
                
                ForEach(cards){ card in
                    Button {
                        withAnimation(.spring){
                            tabBarViewModel.detailCard  =  card
                            tabBarViewModel.showDetail = true
                        }
                    }label: {
                        CardView(card: card)
                            .padding(.bottom)
                        .background(
                            cardBG(card: card)
                        )
                        .foregroundColor(.pink)
                    }
                    .buttonStyle(HoverScaleButtonStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            
        }
        .padding()
        .padding(.bottom, 80)
    }
    @ViewBuilder
    func cardBG(card: Card) -> some View {
        ZStack {
            if tabBarViewModel.showDetail && tabBarViewModel.detailCard == card  {
                LinearGradient(colors: [
                    Color(hex: card.cardColor).opacity(1),
                    Color(hex: card.cardColor).opacity(0)
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0)
            }else {
                LinearGradient(colors: [
                    Color(hex: card.cardColor).opacity(1),
                    Color(hex: card.cardColor).opacity(0.2)
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .matchedGeometryEffect(id: "\(card.id)BG", in: animation)
            }
        }
    }
    
    @ViewBuilder
    func CardView(card: Card) -> some View {
        VStack(spacing: 15) {
            if tabBarViewModel.showDetail && tabBarViewModel.detailCard == card {
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0)
                Text(card.title)
                    .font(.title2.bold())
                    .opacity(0)
            }else {
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(card.id)IMG", in: animation)
                Text(card.title)
                    .matchedGeometryEffect(id: "\(card.id)TITLE", in: animation)
                    .font(.title2.bold())
            }
        }
    }
}

struct HoverScaleButtonStyle: ButtonStyle {
   
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label.scaleEffect(
            configuration.isPressed ? 0.95 : 1
        )
        .animation(.easeIn, value: configuration.isPressed)
    }
  
}

#Preview {
    @Namespace var animation
    return  Home(animation: animation).environmentObject(TabBarViewModel())
}
