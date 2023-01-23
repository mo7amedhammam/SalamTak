//
//  ConfirmationPopUp.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 07/06/2022.
//

import Foundation
import SwiftUI
import Combine

struct ConfirmationPopUp: View {
    @EnvironmentObject var CreateAppointment:VMCreateAppointment
    @EnvironmentObject var environments : EnvironmentsVM

    @Binding var BookiDate :Date
    @Binding var BookiTime :String
    @Binding var GotoSchedual :Bool
    var body: some View {
        GeometryReader{ g in
            VStack{
                ZStack {
                    Image("Awsome")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                        .frame( height: 80 , alignment: .center)
                }
//                .frame(width:g.size.width-40)

//                    .padding(.top)
                
                
                    Text("Confirmed!".localized(language))
//                    .frame(width:g.size.width-40)
                        .foregroundColor(.salamtackWelcome)
                        .font(.system(size: 55, weight: .bold))
                    .padding(.bottom)
                
                    Text("Your_appointment_is".localized(language) + "\n \(ChangeFormate(NewFormat: "dd MMM. yyyy").string(from: BookiDate) + " ( \( ConvertStringDate(inp: BookiTime, FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a")) )")")
//                    .frame(width:g.size.width-40)
                    .font(.system(size: 30,weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.salamtackBlue)
                
                    Button(action: {
                        environments.desiredTab = "TabBar_schedual"
                        CreateAppointment.isDone = false
                        GotoSchedual = true
                    }, label: {
                        HStack {
                            Text("Myـschedule".localized(language))
                                .fontWeight(.semibold)
                                .font(.title)
                        }
//                        .frame(width:g.size.width-40)
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .foregroundColor(.salamtackBlue)
                        .AddBlueBorder(linewidth:1.2)
                })
        }
            .frame(width:g.size.width)
            .frame(height:g.size.height)
//            .padding(.horizontal,0)
        }
//        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(.white)
        .cornerRadius(12)
    }
}

struct ConfirmationPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationPopUp( BookiDate: .constant(Date()), BookiTime: .constant(""), GotoSchedual: .constant(false))
            .environmentObject(VMCreateAppointment())
            .environmentObject(EnvironmentsVM())
    }
}
