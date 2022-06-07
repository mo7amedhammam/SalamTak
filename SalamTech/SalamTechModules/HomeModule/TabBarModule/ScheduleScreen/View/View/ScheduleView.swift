//
//  ScheduleView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import SwiftUI

struct ScheduleView: View {
    var language = LocalizationService.shared.language
    @StateObject var scheduleVM = ViewModelGetAppointmentInfo()
    @StateObject var medicalType = ViewModelExaminationTypeId()
    @State var goToLogin = false

    @State var index = 1
    var body: some View {
        ZStack{
            VStack{
                ZStack {
                    ZStack {
                        Image("underappbar")
                            .resizable()
                            .frame(height: 150)
                            .padding(.bottom, -40)
                        
                       
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack( spacing: 20){
                                ForEach(medicalType.publishedModelExaminationTypeId){ type in
                                    Button(action: {
                                    
                                    withAnimation{
                                        self.index = type.id ?? 1
                                    }
                                    }, label: {
                                    HStack(alignment: .center){
                                        Text(type.Name ?? "")
                                            .font(.system(size: 15))
                                            .foregroundColor(self.index == type.id ? Color("blueColor") : Color("lightGray"))
                                        
                                    }
                                    .padding(10)
                                    .padding(.bottom,1)
                                    .frame(width: 110, height: 30)
                                    .background( Color(self.index == type.id ? "tabText" : "lightGray").opacity(self.index == type.id  ? 1 : 0.3)
                                                    .cornerRadius(3))
                                    .clipShape(Rectangle())
                                    })
                                }
                            }.frame( height: 80, alignment: .center)
                                .padding()
                                .offset(y: 25)
                        }
                    
                    }.offset(y: 80)
                    AppBarView(Title:"Schedule".localized(language))
                        .offset(y:-10)
                }
                Spacer().frame(height: 90)
                    ZStack{
                        Spacer().frame(height: 40)

                        ScheduleCellView( )
                    }
                }
            .edgesIgnoringSafeArea(.bottom)
            .ignoresSafeArea()
            .background(Color("CLVBG"))
         
            // showing loading indicator
            ActivityIndicatorView(isPresented: $scheduleVM.isLoading)
        
            NavigationLink(destination: WelcomeScreenView().navigationBarBackButtonHidden(true),isActive:$goToLogin , label: {
            })
            
        }.environmentObject(scheduleVM)
            .navigationViewStyle(StackNavigationViewStyle())

        .onAppear(perform: {
            medicalType.GetExaminationTypeId()
            scheduleVM.exmodelId = index
            scheduleVM.execute(operation: .getappointments)
        
        })
            .onChange(of: index){newval in
                scheduleVM.exmodelId = newval
                scheduleVM.AppointmentsArr.removeAll()
                scheduleVM.execute(operation: .getappointments)
            }
        
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .popup(isPresented: $scheduleVM.showcncel){
            BottomPopupView{
                ViewCancelAppointmentPopUp(showCancePopUp: $scheduleVM.showcncel, cancelReason: $scheduleVM.AppointmentCancelReason)
                
            }.environmentObject(scheduleVM)

        }
        // Alert with no internet connection
            .alert(isPresented: $scheduleVM.isAlert, content: {
                Alert(title: Text(scheduleVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                        scheduleVM.isAlert = false

                    }))
            })
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

enum ActiveAlert {
    case NetworkError, serverError, success, unauthorized
}
