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
        ZStack{
            VStack{
                Image("Awsome")
                    .resizable()
                    .frame(width: 100, height: 55 , alignment: .center)
                    .padding(.top)
                
                Text("Confirmed!".localized(language))
                    .foregroundColor(Color("blueColor"))
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                
                
                Text("Your_appointment_is".localized(language) + "\n \(ChangeFormate(NewFormat: "dd MMM. yyyy").string(from: BookiDate) + " ( \( ConvertStringDate(inp: BookiTime, FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a")) )")")
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("subText"))
                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                Button(action: {
                    environments.desiredTab = "TabBar_schedual"
                    CreateAppointment.isDone = false
                    GotoSchedual = true
                }, label: {
                    HStack {
                        Text("Myـschedule".localized(language))
                            .fontWeight(.semibold)
                            .font(.title2)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("blueColor"))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                })
            }
        }
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
