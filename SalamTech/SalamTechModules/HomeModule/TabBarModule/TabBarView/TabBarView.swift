

//
//  TabBarGenericView.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 2/13/22.
//

import SwiftUI
//import ImageViewerRemote

var language = LocalizationService.shared.language

struct TabBarView: View {
//@StateObject var SelTap = selectedtapNum()
    
    @StateObject var Bar = tabbar()
    @State var clinicId:Int? = 130
    @State var index:Int? = 2
    @State var islogout:Bool = false
    @State private var ispreviewImage = false
    @State private var previewImageurl :String = ""
    @State var selectedTab1 = "TabBar_home"
    @StateObject var selectedTab = selectedtapNum()

    @State var filterShowing=false
    @State var ConsultationShowing=false
    @State var DatesShowing=false
    @State var ClinicShowing=false
    @State var offset = CGSize.zero
    
    @State var isCancel = false
    @State var appointmentId = 02121201046

//    @AppStorage("language")
//     var language = LocalizationService.shared.language
    
    var body: some View {
        
        ZStack{
        NavigationView {
            
            GeometryReader{ bounds in
                ZStack{
                    VStack(spacing: 15){
                        if selectedTab1 == Bar.tabs[0] {
                            ServicesView()

                        } else if selectedTab1 == Bar.tabs[1] {
                            ScheduleView()

                        } else if selectedTab1 == Bar.tabs[2] {
                            MoreView()
                        }
                        Spacer()
                        HStack(spacing: 0){
                            Spacer()
                            ForEach(Bar.tabs.indices ){tab in
                                TabButton(title: Bar.tabs[tab] , selectedTab: $selectedTab1).environmentObject(selectedTab)
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
                .blur(radius:filterShowing || ConsultationShowing || ClinicShowing || DatesShowing ? 10 : 0)
                .disabled(filterShowing || ConsultationShowing || ClinicShowing || DatesShowing)
  
            }
    
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())

//            ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true).edgesIgnoringSafeArea(.all)
        }

    }
}

struct TabButton: View{
    @AppStorage("language")

    var language = LocalizationService.shared.language
    @EnvironmentObject var Tap:selectedtapNum
     var title: String
    @Binding var selectedTab: String
    var body: some View {
        Button(action: {
//            withAnimation{
            selectedTab = title
            Tap.tabNum = title
//                .localized(language)
//            }
        }, label: {
            VStack(spacing: 6){
                Image(title.localized(language))
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(selectedTab == title ? Color("blueColor") : Color.black.opacity(0.2))
                    .frame(width: 24, height: 24)
                
                Text(title.localized(language))
                    .font(Font.SalamtechFonts.Reg16)

                    .font(.caption)
                    .foregroundColor(Color.black.opacity(selectedTab == title ? 0.6 : 0.2))
            }
        })
//            .EnvironmentObject(selectedtapNum)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

var tabs = ["TabBar_home",
        "TabBar_schedual",
        "TabBar_more"]

class tabbar:ObservableObject{
//    @Published var tabs : [String]
    
//    init (){
    @Published var tabs = ["TabBar_home",
            "TabBar_schedual",
            "TabBar_more"]
//    }
}





@MainActor class selectedtapNum:ObservableObject{
    @Published var tabNum:String
    init(){
        tabNum = "TabBar_home"
    }
    
}



//MARK: ----- Call hideKeyboard on tap gesture of View To hide -------
//extension View {
//    func hideKeyboard() {
//        let resign = #selector(UIResponder.resignFirstResponder)
//        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
//    }
//}
