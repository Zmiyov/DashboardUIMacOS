//
//  Home.swift
//  DashboardUIMacOS
//
//  Created by Volodymyr Pysarenko on 12.06.2024.
//

import SwiftUI

struct Home: View {
    
    @State var currentTab = "home"
    
    @Namespace var animation
    
    @State var currentHoverID: String = ""
    
    var body: some View {
        
        HStack(spacing: 0){
            
            //SideBar
            VStack(spacing: 10){
                
                //Menu buttons
                ForEach(["home", "monitor", "bag", "card", "trophy", "list"], id: \.self) {image in
                    MenuButton(image: image)
                }
            }
            .padding(.top, 60)
            .frame(width: 85)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(
            //Corner radius only on right side
                ZStack{
                    
                    Color.white
                        .padding(.trailing, 30)
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black.opacity(0.04), radius: 5, x: 5, y: 0)
                }
                    .ignoresSafeArea()
            )
            
            //Home view
            VStack(spacing: 15){
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 2, content: {
                        
                        Text("Dashboard")
                            .font(.title.bold())
                            .foregroundStyle(.black)
                        Text("Payment updates")
                            .font(.callout)
                            .foregroundStyle(.gray)
                    })
                    
                    Spacer()
                    
                    //Search Bar
                    HStack{
                        
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                            .foregroundStyle(.black)
                        
                        TextField("Search", text: .constant(""))
                            .frame(width: 150)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(Capsule())
                }
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    RecentView()
                    
                    //Graph view
                    GraphView()
                        .padding(.vertical, 20)
                    
                    HistoryView()
                })
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .frame(width: getRect().width / 1.75, height: getRect().height - 130, alignment: .leading)
        .background(Color.BG.ignoresSafeArea())
        .buttonStyle(BorderlessButtonStyle())
        .textFieldStyle(PlainTextFieldStyle())
    }
    
    @ViewBuilder
    func MenuButton(image: String) -> some View {
        
        Image(image)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(currentTab == image ? .black : .gray)
            .frame(width: 22, height: 22)
            .frame(width: 80, height: 50)
            .overlay(
                
                HStack{
                    
                    if currentTab == image {
                        Capsule()
                            .fill(.black)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                            .frame(width: 2, height: 40)
                            .offset(x: 2)
                    }
                }
                
                ,alignment: .trailing
            )
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring()) {
                    currentTab = image
                }
            }
    }
    
    @ViewBuilder
    func RecentView() -> some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            
            HStack(spacing: 15){
                
                ForEach(recents) { recent in
                    
                    VStack(alignment: .leading, spacing: 15, content: {
                        
                        HStack{
                            
                            Image(systemName: recent.image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 26, height: 26)
                                .foregroundStyle(.black)
                            
                            Spacer()
                            
                            Image("menu")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundStyle(.gray)
                        }
                        
                        Text(recent.title)
                            .foregroundStyle(.gray)
                        
                        Text(recent.price)
                            .font(.title2.bold())
                            .foregroundStyle(.black)
                    })
                    .padding()
                    .frame(width: 150)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .black.opacity(0.03), radius: 5, x: 5, y: 5)
                    .shadow(color: .black.opacity(0.03), radius: 5, x: -5, y: -5)
                }
            }
            .padding(.vertical)
            .padding(.trailing)
        })
    }
    
    @ViewBuilder
    func GraphView() -> some View {
        VStack(alignment: .leading, spacing: 2, content: {
            
            Text("Balance")
                .font(.callout)
                .foregroundStyle(.gray)
            
            Text("$1500")
                .font(.title.bold())
                .foregroundStyle(.black)
            
            BarGraph(downloads: downloads)
        })
    }
    
    @ViewBuilder
    func HistoryView() -> some View {
        
        VStack(alignment: .leading, spacing: 2, content: {
            Text("History")
                .font(.title.bold())
                .foregroundStyle(.black)
            
            Text("Transaction of last 3 month")
                .font(.callout)
                .foregroundStyle(.gray)
            
            VStack(spacing: 8){
                
                ForEach(histories) { history in
                    
                    HStack(spacing: 15){
                        
                        Image(history.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .padding(6)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.03), radius: 5, x: 5, y: 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(history.description)
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(history.time)
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(history.amount)
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Completed")
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(x: 20)
                    }
                    .padding(.vertical, 5 )
                    .padding(.horizontal)
                    .background(.white.opacity(currentHoverID == history.id ? 1 : 0))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onHover(perform: { hovering in
                        withAnimation {
                            if hovering {
                                currentHoverID = history.id
                            } else {
                                currentHoverID = ""
                            }
                        }
                    })
                }
            }
            .padding(.vertical, 25)
        })
    }
}

#Preview {
    ContentView()
}

extension View {
    func getRect() -> CGRect {
        return NSScreen.main!.visibleFrame
    }
}
