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
        VStack(){
//            HStack {
//                Text("Booking_details".localized(language))
//                    .foregroundColor(.white)
//                    .font(.system(size: 20))
//                    .bold()
////                Spacer()
//            }
////            .padding(.leading)
//                .padding(.vertical,8)
//                .padding(.horizontal,30)
//                .background(Color.salamtackWelcome)
//                .cornerRadius(20)
//                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            HStack(){
                Image("TabBar_schedual")
                    .resizable()
                    .foregroundColor(Color("darkGreen"))
                    .frame(width: 25, height: 25)
                    .padding(8)
                    .clipShape(Circle())
                    .AddBlueBorder(cornerRadius: 25,linewidth: 1.2)
                VStack(alignment:.leading){
                    Text("Booking_Date_&_Time_:".localized(language))
                        .foregroundColor(.salamtackWelcome)
                        .font(.system(size: 15))
                        .bold()

                    Text(ChangeFormate(NewFormat: "dd MMM. yyyy").string(from: BookiDate) + " ( \( ConvertStringDate(inp: BookiTime, FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a")) )" )
                        .foregroundColor(.black.opacity(0.7))
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
                    .padding(8)
                    .clipShape(Circle())
                    .AddBlueBorder(cornerRadius: 25,linewidth: 1.2)

                VStack(alignment:.leading){
                    Text("\(getEx(id: ExType).name?.localized(language) ?? "") " + "Appointment".localized(language) + ":")
                        .foregroundColor(.salamtackWelcome)
                        .font(.system(size: 15))
                        .bold()
                    Text(getEx(id: ExType).Comment?.localized(language) ?? "")
                        .foregroundColor(.black.opacity(0.7))
                        .font(Font.SalamtechFonts.Reg14)
                    
                }
                .padding(.trailing)
                
                Spacer()
                
            }.padding(.leading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            
            HStack{
                Image("doc4")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(8)
                    .clipShape(Circle())
                    .AddBlueBorder(cornerRadius: 25,linewidth: 1.2)

                VStack(alignment:.leading){
                    Text("Waiting_Time:".localized(language))
                        .foregroundColor(.salamtackWelcome)
                        .font(.system(size: 15))
                        .bold()
                    Text("\(Doctor.WaitingTime ?? 15) " + "Minutes".localized(language))
                        .foregroundColor(.black.opacity(0.7))
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
