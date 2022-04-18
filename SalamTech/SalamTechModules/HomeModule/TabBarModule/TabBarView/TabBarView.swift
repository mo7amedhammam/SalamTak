

//
//  TabBarGenericView.swift
//  SalamTech-DR
//
//  Created by wecancity agency on 2/13/22.
//

import SwiftUI
//import ImageViewerRemote

var language = LocalizationService.shared.language

struct TabBarView: View {

    @StateObject var Bar = tabbar()
    @State var clinicId:Int? = 130
    @State var index:Int? = 2
    @State var islogout:Bool = false
    @State private var ispreviewImage = false
    @State private var previewImageurl :String = ""
    @State var selectedTab = "TabBar_home"
//    @ObservedObject var GetAppointments = VMGetAppointment()
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
                        if selectedTab == Bar.tabs[0] {
                            ServicesView()
                        } else if selectedTab == Bar.tabs[1] {
                            
//                            ViewGetAppointments(isCancel:$isCancel, GetAppointments:GetAppointments,appointmentId: $appointmentId, filterShowing: $filterShowing, ConsultationShowing: $ConsultationShowing, DatesShowing: $DatesShowing, ClinicShowing:$ClinicShowing )
                            ScheduleView()
                        

                        } else if selectedTab == Bar.tabs[2] {
                            MoreView()
                        }
                        Spacer()
                        HStack(spacing: 0){
                            Spacer()
                            ForEach(Bar.tabs.indices ){tab in
                                TabButton(title: Bar.tabs[tab] , selectedTab: $selectedTab)
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
                    
                    
//                    .popup(isPresented: $isCancel){
//                        BottomPopupView{
//                            ViewCancelAppointmentPopUp(showCancePopUp: $isCancel, cancelReason: $GetAppointments.AppointmentCancelReason, appointmentId: $appointmentId)
//                        }
//                    }
                    
                    
                }
                .blur(radius:filterShowing || ConsultationShowing || ClinicShowing || DatesShowing ? 10 : 0)
                .disabled(filterShowing || ConsultationShowing || ClinicShowing || DatesShowing)
                
                // end main V
//                if filterShowing {
//                    ZStack {
//
//
////                        ChooseFilter(IsPresentedConsultation: $ConsultationShowing, IsPresentedDates: $DatesShowing, IsPresentedClinic: $ClinicShowing, IsPresented: $filterShowing,appointment: GetAppointments, width: bounds.size.width)
//                    }
////                    .animation(.easeInOut)
//                    .transition(.move(edge: .bottom))
//                    .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { gesture in
//                                self.offset.height = gesture.translation.height
//                            }
//                            .onEnded { _ in
//                                if self.offset.height > UIScreen.main.bounds.size.height / 2 {
//                                    withAnimation {
//                                        filterShowing.toggle()
//        //                                        GetAppointments.publishedAppointmentsModel.removeAll()
//        //                                        GetAppointments.startSearchAppointment()
//                                    }
//                                    self.offset = .zero
//                                } else {
//                                    self.offset = .zero
//                                }
//                            }
//                    )
//                }
//                else if ConsultationShowing{
//                    ZStack {
//                        ChooseConsultationType( IsPresentedBack: $filterShowing, IsPresentedConsultation: $ConsultationShowing,appointment: GetAppointments,   width: UIScreen.main.bounds.size.width)
//                    }
////                    .animation(.easeInOut)
//                    .transition(.move(edge: .bottom))
//                    .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { gesture in
//                                self.offset.height = gesture.translation.height
//                            }
//                            .onEnded { _ in
//                                if self.offset.height > UIScreen.main.bounds.size.height / 2 {
//                                    withAnimation {
//                                        ConsultationShowing.toggle()
//                                        print(GetAppointments.filterConsultationTypeId)
//                                    }
//                                    self.offset = .zero
//                                } else {
//                                    self.offset = .zero
//                                }
//                            }
//                    )
//                }
//                else if DatesShowing{
//                    ZStack {
//                        ChooseDate( IsPresentedBack: $filterShowing, IsPresentedDate: $DatesShowing,appointment: GetAppointments,   width: UIScreen.main.bounds.size.width)
//                    }
////                    .animation(.easeInOut)
//                    .transition(.move(edge: .bottom))
//                    .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { gesture in
//                                self.offset.height = gesture.translation.height
//                            }
//                            .onEnded { _ in
//                                if self.offset.height > UIScreen.main.bounds.size.height / 2 {
//                                    withAnimation {
//                                        DatesShowing.toggle()
//        //                                        print( Filterdatef.string(from:  GetAppointments.filterFromDate))
//        //                                        print( Filterdatef.string(from:  GetAppointments.filterToDate))
//
//                                    }
//                                    self.offset = .zero
//                                } else {
//                                    self.offset = .zero
//                                }
//                            }
//                    )
//                }
//                else if ClinicShowing{
//                    ZStack {
//                        ChooseClinic( IsPresentedBack: $filterShowing, IsPresentedClinic: $ClinicShowing,appointment: GetAppointments , width: UIScreen.main.bounds.size.width)
//                    }
////                    .animation(.easeInOut)
//                    .transition(.move(edge: .bottom))
//                    .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { gesture in
//                                self.offset.height = gesture.translation.height
//                            }
//                            .onEnded { _ in
//                                if self.offset.height > UIScreen.main.bounds.size.height / 2 {
//                                    withAnimation {
//                                        ClinicShowing.toggle()
//                                        print(GetAppointments.filterClinicId)
//                                    }
//                                    self.offset = .zero
//                                } else {
//                                    self.offset = .zero
//                                }
//                            }
//                    )
//                }
            }
    
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
            
//            ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true).edgesIgnoringSafeArea(.all)
        }

    }
}

struct TabButton: View{
    @AppStorage("language")
    var language = LocalizationService.shared.language

     var title: String
    @Binding var selectedTab: String
    var body: some View {
        Button(action: {
//            withAnimation{
            selectedTab = title
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






//MARK: ----- Call hideKeyboard on tap gesture of View To hide -------
//extension View {
//    func hideKeyboard() {
//        let resign = #selector(UIResponder.resignFirstResponder)
//        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
//    }
//}
