//
//  TabBarGenericView.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 2/13/22.
//

import SwiftUI

var language = LocalizationService.shared.language

struct TabBarView: View {
    @StateObject var TabBarVM = tabbar()
    @State var selectedTab = "TabBar_home"

    var body: some View {
        ZStack{
        NavigationView {
            GeometryReader{ bounds in
                ZStack{
                    VStack(spacing: 0){
                        if selectedTab == TabBarVM.tabs[0] {
                            ServicesView()

                        } else if selectedTab == TabBarVM.tabs[1] {
                            ScheduleView()

                        } else if selectedTab == TabBarVM.tabs[2] {
                            MoreView()
                        }
                        HStack(spacing: 0){
                            Spacer()
                            ForEach(TabBarVM.tabs.indices ){tab in
                                TabButton(title: TabBarVM.tabs[tab] , selectedTab: $selectedTab)
                                Spacer()
                            }
                        }
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .padding([.leading,.trailing],20)
                        .padding(.bottom, 15)
                        .background(
                            Image("tabBar")
                                .resizable()
                                .offset(y: -40)
                        )
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

class tabbar:ObservableObject{
    @Published var selectedTab = "TabBar_home"
    @Published var tabs = ["TabBar_home",
            "TabBar_schedual",
            "TabBar_more"]
}
