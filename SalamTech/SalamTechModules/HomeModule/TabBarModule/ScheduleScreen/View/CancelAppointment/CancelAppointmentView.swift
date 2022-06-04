//
//  CancelAppointmentView.swift
//  SalamTak
//
//  Created by wecancity on 04/06/2022.
//

import Foundation
import SwiftUI

struct ViewCancelAppointmentPopUp: View {
    @EnvironmentObject var scheduleVM : ViewModelGetAppointmentInfo

    @Binding var showCancePopUp:Bool
    @Binding var cancelReason:String

    var language = LocalizationService.shared.language
    var body: some View {
        ZStack{
            VStack{
                
                Image("CancelAppointment")
                    .resizable()
                    .frame(width: 120, height: 72, alignment: .center)
                    .padding(.top)
                    
                Text("Popup_Cencel_Appointment".localized(language)).font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .frame( height:60)
                    .foregroundColor(Color("blueColor"))
                
                Text("Popup_Cencel_Appointment_msg".localized(language)).font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .frame( height:60)
                    .foregroundColor(Color("subText"))
                
                EMRInputTextField(text: $scheduleVM.AppointmentCancelReason , title: "Popup_Cencel_Appointment_reason".localized(language) )
                    .padding([.leading,.trailing])
                
                HStack{
                    Spacer()
                        .frame(width:15)
                    Button(action: {
                        self.showCancePopUp.toggle()
                    }, label: {
                        HStack{
                            Spacer().frame(width:2)

                            Text("Popup_Cencel_Appointment_Close".localized(language))
                            .foregroundColor(Color("blueColor"))
                            .bold()
                            .frame( height: 45 )
                            .padding([.leading,.trailing],40)
                            .background(Color(uiColor: .lightGray).opacity(0.3) )
                            .cornerRadius(8)
                            Spacer().frame(width:2)
                    }
                    }
                    )
                    Spacer()
                    Button(action: {
                        scheduleVM.execute(operation: .cancelappointment)
                    }, label: {
                        HStack{
                            Spacer().frame(width:2)

                            Text("Popup_Cencel_Appointment_Confirm".localized(language))
                                .foregroundColor(.white)
                            .bold()
                            .frame( height: 45 )
                            .padding([.leading,.trailing],40)
                            .background(Color("blueColor"))
                            
                            .cornerRadius(8)
                            Spacer().frame(width:2)
                    }
                    }
                    )
                    Spacer().frame(width:5)
                    
                        .onChange(of: scheduleVM.isAlert){newval in
                            scheduleVM.showcncel = !newval
//                            scheduleVM.startFetchAppointmentInfo()
                    }

                }
                .frame( height: 40 )
                    .padding([.leading,.trailing],10)
                    .padding([.top,.bottom])

            }
            
            .frame( height: 350 )
            .background(Color.white)
            .cornerRadius(12)

        }
        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height,alignment: .center )
        .padding([.leading,.trailing],20)
        .edgesIgnoringSafeArea(.all)
        .background(Color.black.opacity(0.2))
        
    }
}



struct ViewCancelAppointmentPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ViewCancelAppointmentPopUp( showCancePopUp: .constant(false), cancelReason: .constant(""))
    }
}
