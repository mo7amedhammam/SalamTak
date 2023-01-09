//
//  NotificationsList.swift
//  SalamTak
//
//  Created by wecancity on 05/01/2023.
//

import SwiftUI

struct NotificationsList: View {
    @EnvironmentObject var notificationVM : NotificationsViewModel
    @Binding var SelectedTab : String
    @Binding var secondViewId : Int
    
    @Binding var DesiredScroll : Int
    var language = LocalizationService.shared.language
    
    var body: some View {
        ZStack{
            
            if secondViewId == 0{ // notifications
                VStack{
                    Text("Notifications_Title".localized(language))
                        .foregroundColor(Color("blueColor"))
                        .font(Font.system(size: 25))
                        .bold()
                    //                .padding(.top,hasNotch ? 40:20)
                        .multilineTextAlignment(.center)
                    
                    
                    ScrollView{
                        ForEach(notificationVM.publishedNotificationsArray , id:\.self){ notification in
                            VStack(spacing:2) {
                                HStack{
                                    AsyncImage(url: URL(string:  URLs.BaseUrl + "\(notification.doctorImage ?? "")")){image in
                                        image.resizable()
                                    } placeholder: {
                                        Color("lightGray").opacity(0.2)
                                    }
                                    //                            .resizable()
                                    .frame(width: 60, height: 60, alignment: .leading)
                                    .clipShape(Circle())
                                    .padding( .leading)
                                    
                                    VStack(alignment: .leading,spacing: 0 ){
                                        Text(notification.doctorName ?? "")
                                            .font(.salamtakBold(of: 18))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        HStack{
                                            Image(LogoType(MedicalExaminationTypeId: notification.medicalExaminationTypeID ?? 1))
                                                .resizable()
                                                .frame(width: 20, height: 20, alignment: .leading)
                                                .padding([.top,.bottom],5)
                                                .clipShape(Circle())
                                            
                                            Text(notification.medicalExaminationTypeName ?? "Clinic Appointment")
                                                .font(.salamtakRegular(of: 14))
                                                .foregroundColor(Color("blueColor"))
                                            Spacer()
                                        }
                                        
                                        HStack{
                                            Image("newCalendaricon")
                                                .resizable()
                                                .renderingMode(.template)
                                                .frame(width: 20, height: 20, alignment: .leading)
                                                .foregroundColor(Color("newWelcome"))
                                            
                                            Text(ConvertStringDate(inp: notification.appointmentDate ?? "Today", FormatFrom: "yyyy-MM-dd'T'HH:mm:ss", FormatTo: "dd/MM/yyyy"))
                                                .font(.salamtakRegular(of: 14))
                                                .padding(.trailing )
                                                .foregroundColor(Color("blueColor"))
                                            
                                            Image(systemName: "clock")
                                                .resizable()
                                                .renderingMode(.template)
                                                .frame(width: 20, height: 20, alignment: .leading)
                                                .foregroundColor(Color("newWelcome"))
                                            
                                            
                                            Text(ConvertStringDate(inp: notification.appointmentDate ?? "10:10 AM", FormatFrom: "yyyy-MM-dd'T'HH:mm:ss", FormatTo: "hh:MM a")
                                            )
                                                .font(.salamtakRegular(of: 14))
                                                .foregroundColor(Color("blueColor"))
                                        }
                                    }
                                    .onTapGesture(perform: {
                                        SelectedTab = "TabBar_appointments"
                                        DesiredScroll = notification.id ?? 0
                                    })
                                    Spacer()
                                }
                                
                                Color(.gray)
                                    .frame(height:2)
                                    .opacity(0.5)
                                    .padding(.horizontal)
                                    .padding(.top,0)
                            }
                        }
                        Spacer()
                            .frame(height:70)
                    }
                    Spacer()
                }
                .navigationBarHidden(true)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                .onAppear(perform: {
                    notificationVM.execute(operation: .getnotifications)
                })
                
                .overlay(
                    ZStack{
                        // showing loading indicator
                        ActivityIndicatorView(isPresented: $notificationVM.isLoading)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                        
                        if notificationVM.publishedNotificationsArray.count==0{
                            Text("You_don't_have_notifications".localized(language))
                        }
                    }
                )
//                .background(
//                    newBackImage(backgroundcolor: .white, imageName: .image2)
//                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
//                )
            }
            else if secondViewId == 1{ // password
                ChangePasswordView(isChangingInside: true)
                    .navigationBarHidden(true)
            }
        }
        .frame(width:UIScreen.main.bounds.width)
    }
}

struct NotificationsList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NotificationsList( SelectedTab: .constant(""), secondViewId: .constant(0), DesiredScroll: .constant(0))
        }
        .environmentObject(NotificationsViewModel())
        
    }
}
