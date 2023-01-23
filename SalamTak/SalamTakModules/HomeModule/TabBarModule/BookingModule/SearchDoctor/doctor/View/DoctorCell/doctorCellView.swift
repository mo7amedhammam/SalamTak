//
//  doctorCellView.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import Kingfisher
import SwiftUI

struct ViewDocCell: View {
    var language = LocalizationService.shared.language

     var Doctor : Doc
    @EnvironmentObject var searchDoc : VMSearchDoc
    @Binding var gotodoctorDetails : Bool
    @Binding var SelectedDoctor : Doc
    
    @Binding var ispreviewImage:Bool
    @Binding var previewImageurl:String
    var body: some View {
        VStack(alignment:.leading){
            
            //MARK: ****** Doc Main info ******
            ViewTopSection(Doctor: Doctor,ispreviewImage:$ispreviewImage,previewImageurl:$previewImageurl)

            //MARK: ******* Middel Section ********
            ViewMiddelSection(Doctor: Doctor)
            //MARK: *******       ********
            
            Text("Available".localized(language) + " \(ConvertStringDate(inp: Doctor.AvailableFrom ?? "", FormatFrom: "dd-MM-yyyy HH:mm", FormatTo: "dd MMM. yyyy")) " + "From".localized(language) + " \(ConvertStringDate(inp: Doctor.AvailableFrom ?? "", FormatFrom: "dd-MM-yyyy HH:mm", FormatTo: "hh:mm a"))" )
                .frame(width: UIScreen.main.bounds.width - 40, height: 35, alignment: .center)
                .background(Color.gray.opacity(0.3))
                .foregroundColor(.black.opacity(0.7))
                .font(Font.SalamtechFonts.Reg14)
            
            //MARK: --- TypeImage Name & Book bu ---
            HStack{
                Spacer()
                
                ForEach(Doctor.MedicalExamationTypeImage ?? [], id:\.self ){ imge2 in
                    
                    KFImage(URL(string: URLs.BaseUrl + "\(imge2.Image ?? "")"))
                        .resizable()
                        .frame(width: 25,height: 25 )
                        .scaledToFit()
                        .cornerRadius(5)
                        .shadow(radius: 4)
                }
                Spacer()
                
                Button(action: {
                    SelectedDoctor = Doctor
                    gotodoctorDetails = true
                }, label: {
                    HStack{
                        Text("Book".localized(language))
                            .foregroundColor(.white)
                            .font(Font.SalamtechFonts.Bold14)
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                    .padding(.horizontal, 40)
                }
                )
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal,15)
                    .frame( height: 40 )
                    .background(Color("blueColor"))
                    .cornerRadius(8)
                
                Spacer()
                
            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            .padding(.bottom,10)
            
        }
        .background(Color.white)
        .cornerRadius(9)
        .shadow(color: .black.opacity(0.1), radius: 9)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

struct ViewDocCell_Previews: PreviewProvider {
    static var previews: some View {
        ViewDocCell(Doctor: Doc.init(), gotodoctorDetails: .constant(false), SelectedDoctor:.constant(Doc.init()), ispreviewImage: .constant(false), previewImageurl: .constant("")).environmentObject(VMSearchDoc())
    }
}

struct ViewDoctorCell_Previews: PreviewProvider {
    static var previews: some View {
        ViewDocCell(Doctor: Doc.init(), gotodoctorDetails: .constant(false), SelectedDoctor:.constant(Doc.init()), ispreviewImage: .constant(false), previewImageurl: .constant("")).environmentObject(VMSearchDoc())
    }
}
struct ViewDoctorCell: View {
    var language = LocalizationService.shared.language

     var Doctor : Doc
    @EnvironmentObject var searchDoc : VMSearchDoc
    @Binding var gotodoctorDetails : Bool
    @Binding var SelectedDoctor : Doc
    
    @Binding var ispreviewImage:Bool
    @Binding var previewImageurl:String
    var body: some View {
        VStack(alignment:.leading){
            
            //MARK: ****** Doc Main info ******
            ViewTopSection(Doctor: Doctor,ispreviewImage:$ispreviewImage,previewImageurl:$previewImageurl)

            //MARK: ******* Middel Section ********
            ViewMiddelSection(Doctor: Doctor)
            //MARK: *******       ********
            
            Text("Available".localized(language) + " \(ConvertStringDate(inp: Doctor.AvailableFrom ?? "", FormatFrom: "dd-MM-yyyy HH:mm", FormatTo: "dd MMM. yyyy")) " + "From".localized(language) + " \(ConvertStringDate(inp: Doctor.AvailableFrom ?? "", FormatFrom: "dd-MM-yyyy HH:mm", FormatTo: "hh:mm a"))" )
                .frame(width: UIScreen.main.bounds.width - 40, height: 35, alignment: .center)
                .background(Color.gray.opacity(0.3))
                .foregroundColor(.black.opacity(0.7))
                .font(Font.SalamtechFonts.Reg14)
            
            //MARK: --- TypeImage Name & Book bu ---
            HStack{
                Spacer()
                
                ForEach(Doctor.MedicalExamationTypeImage ?? [], id:\.self ){ imge2 in
                    
                    KFImage(URL(string: URLs.BaseUrl + "\(imge2.Image ?? "")"))
                        .resizable()
                        .frame(width: 25,height: 25 )
                        .scaledToFit()
                        .cornerRadius(5)
                        .shadow(radius: 4)
                }
                Spacer()
                
                Button(action: {
                    SelectedDoctor = Doctor
                    gotodoctorDetails = true
                }, label: {
                    HStack{
                        Text("Book".localized(language))
                            .foregroundColor(.white)
                            .font(Font.SalamtechFonts.Bold14)
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                    .padding(.horizontal, 40)
                }
                )
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal,15)
                    .frame( height: 40 )
                    .background(Color("blueColor"))
                    .cornerRadius(8)
                
                Spacer()
                
            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            .padding(.bottom,10)
            
        }
        .background(Color.white)
        .cornerRadius(9)
        .shadow(color: .black.opacity(0.1), radius: 9)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}
