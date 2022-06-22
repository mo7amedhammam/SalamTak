//
//  BookingDetails.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 07/06/2022.
//

import Foundation
import SwiftUI
import Combine
struct BookingDetails: View {
    var Doctor:Doc
    @Binding var ExType :Int
    @Binding var BookiDate :Date
    @Binding var BookiTime :String
    
    var body: some View {
        VStack(spacing:5){
            HStack {
                Text("Booking_details".localized(language))
                Spacer()
            }.padding(.leading)
                .padding(.vertical,10)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            HStack(){
                Image("TabBar_schedual")
                    .resizable()
                    .foregroundColor(Color("darkGreen"))
                    .frame(width: 25, height: 25)
                    .padding(.leading)
                VStack(alignment:.leading){
                    Text("Booking_Date_&_Time_:".localized(language))
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                    
                    Text(ChangeFormate(NewFormat: "dd MMM. yyyy").string(from: BookiDate) + " ( \( ConvertStringDate(inp: BookiTime, FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a")) )" )
                        .foregroundColor(.secondary)
                        .font(Font.SalamtechFonts.Reg14)
                    
                }
                .padding(.trailing)
                Spacer()
            }.padding(.leading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            HStack{
                Image(systemName: getEx(id: ExType).image ?? "")
                    .resizable()
                    .foregroundColor(Color("darkGreen"))
                    .frame(width: 25, height: 25)
                    .aspectRatio( contentMode: .fit)
                    .padding(.leading)
                
                VStack(alignment:.leading){
                    Text("\(getEx(id: ExType).name?.localized(language) ?? "") " + "Appointment".localized(language) + ":")
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                    Text(getEx(id: ExType).Comment?.localized(language) ?? "")
                        .foregroundColor(.secondary)
                        .font(Font.SalamtechFonts.Reg14)
                    
                }
                .padding(.trailing)
                
                Spacer()
                
            }.padding(.leading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            
            HStack{
                Image("doc4")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading)
                
                VStack(alignment:.leading){
                    Text("Waiting_Time:".localized(language))
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                    Text("\(Doctor.WaitingTime ?? 15) " + "Minutes".localized(language))
                        .foregroundColor(.secondary)
                        .font(Font.SalamtechFonts.Reg14)
                    
                }
                .padding(.trailing)
                
                Spacer()
                
            }.padding(.leading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
                .cornerRadius(9)
        }
    }
}

struct BookingDetails_Previews: PreviewProvider {
    static var previews: some View {
        BookingDetails(Doctor: Doc.init(), ExType: .constant(1), BookiDate: .constant(Date()), BookiTime: .constant("2:25"))
    }
}
