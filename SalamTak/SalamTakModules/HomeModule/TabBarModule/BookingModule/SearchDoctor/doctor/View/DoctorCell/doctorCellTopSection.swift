//
//  doctorCellTopSection.swift
//  SalamTak
//
//  Created by wecancity on 05/06/2022.
//

import Foundation
import SwiftUI

struct ViewTopSection: View {
    var language = LocalizationService.shared.language

    var Doctor:Doc
    @Binding var ispreviewImage:Bool
    @Binding var previewImageurl:String

    var body: some View {
        HStack{
            AsyncImage(url: URL(string:   URLs.BaseUrl + "\(Doctor.Image ?? "")" )) { image in
                image.resizable()
                
            } placeholder: {
                Image("logo")
                    .resizable()
            }
            .scaledToFill()
            .frame(width:70)
            .background(Color.gray)
            .cornerRadius(9)
            .onTapGesture(perform: {
                ispreviewImage = true
                previewImageurl = URLs.BaseUrl + "\(Doctor.Image ?? "")"
            })
            
            VStack(alignment:.leading){
                //MARK:  --- Name ---
                HStack{
                    Text("Dr/".localized(language))
                        .foregroundColor(.salamtackBlue)

                    Text(Doctor.DoctorName ?? "Mohamed hammam")
                        .font(Font.SalamtechFonts.Bold18)
                        .foregroundColor(.salamtackBlue)
                    
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                //MARK:  --- Seniority  ---
                HStack{
                    Text(Doctor.SeniortyLevelName ?? "seniority Level")
                        .foregroundColor(.salamtackBlue)
                        .font(Font.SalamtechFonts.Reg14)

                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                //MARK:  --- Rate ---
                HStack{
                    StarsView(rating: Float( Doctor.Rate ?? 0))
                    
                    Text("( \(Doctor.NumVisites ?? 0) "+"Patientsـ)".localized(language))
                        .foregroundColor(.black.opacity(0.7))
                        .font(Font.SalamtechFonts.Reg14)
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            }
            Spacer()
            
        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .padding(10)
        .frame(height:115)
    }
}

struct ViewTopSection_Previews: PreviewProvider {
    static var previews: some View {
        ViewTopSection(Doctor: Doc.init(), ispreviewImage: .constant(false), previewImageurl: .constant(""))
    }
}

struct ViewLeftSection_Previews: PreviewProvider {
    static var previews: some View {
        ViewLeftSection(Doctor: Doc.init(WaitingTime:15, FeesFrom:120, Rate:4.6, DoctorName:"Maged morad magdy",SpecialistName: "Dentistry",ClinicAddress: "قويسنا - النوفيه- قويسنا الموفيه امام البنك الاهلى", AvailableFrom: "14-12-2023 12:30"))
            .environmentObject(ViewModelExaminationTypeId())
    }
}


struct ViewLeftSection: View {
    var language = LocalizationService.shared.language
    @EnvironmentObject var medicalType : ViewModelExaminationTypeId

    var Doctor:Doc
//    @Binding var ispreviewImage:Bool
//    @Binding var previewImageurl:String
    var MoreInfoAction: (() -> ())?
    var ImageAction: (() -> ())?
    var BookingAction: (() -> ())?

    var body: some View {
        VStack {
            HStack (spacing:0){
                VStack(alignment:.leading){
                    ZStack(alignment:.leading){
                        Image("Awsome")
                            .resizable()
                            .frame(width:(UIScreen.main.bounds.width / 3) * 2,height:150)
                            .aspectRatio( contentMode: .fit)
                        
                        AsyncImage(url: URL(string:   URLs.BaseUrl + "\(Doctor.Image ?? "")" )) { image in
                            image.resizable()
                                .onTapGesture {
                                    ImageAction?()
                                }
                        } placeholder: {
                            Image("vector")
                                .resizable()
                        }
                        .frame(width:(UIScreen.main.bounds.width / 3),height:130)
                        .clipShape(Circle())
                        .padding(.leading,13)
                        .padding(.bottom,12)
                        VStack(alignment:.leading) {
                            Button(action: {
                                MoreInfoAction?()
                            }, label: {
                                VStack{
                                VStack(alignment:.leading){
                            HStack {
                                Text("Dr.".localized(language))
                                    .bold()
                                Text(Doctor.DoctorName?.firstWord ?? "")
                                    .bold()
                            }
                            Text("\(Doctor.DoctorName ?? "" )".components(separatedBy: " ").dropFirst().joined(separator: " "))
                                    .bold()
                                }
                                Text("More...".localized(language))
                                    .bold()
                                    .font(Font.system(size: 11))
                                .foregroundColor(.salamtackWelcome)
                            }
                            .font(Font.system(size: 18))
                            })
                                .buttonStyle(.plain)
                            
                            
                            Spacer().frame(height:50)
                            
                            Text(Doctor.SpecialistName ?? "")
                                .bold()
                                .font(Font.system(size: 11))
                            
                        }
                        .offset(x:(UIScreen.main.bounds.width / 3) + 20)
                        .foregroundColor(.salamtackBlue)
                    }
                 
                    
                    HStack(alignment:.top){
                            Image(systemName: "circle.fill")
                            .foregroundColor(.salamtackWelcome)
                            .font(.system(size: 12))
                        
                        Text(Doctor.SpecialistName ?? "")
                            .foregroundColor(.black.opacity(0.8))
                            .font(.system(size: 14))

                    }
                    HStack(alignment:.top){
                        Image(systemName: "circle.fill")
                            .foregroundColor(.salamtackWelcome)
                            .font(.system(size: 12))
                        Text("Address:_".localized(language))
                            .foregroundColor(.black.opacity(0.8))
                            .font(.system(size: 14))
                        
                        Text("\(Doctor.ClinicAddress ?? "")")
                            .foregroundColor(.black.opacity(0.8))
                            .font(.system(size: 14))
                    }

                    HStack(alignment:.top){
                        Image(systemName: "circle.fill")
                            .foregroundColor(.salamtackWelcome)
                            .font(.system(size: 12))
                        
                        Text("Waiting_Time:_".localized(language) + " \(Doctor.WaitingTime ?? 0) " + "Minutes_".localized(language))
                            .foregroundColor(.black.opacity(0.8))
                            .font(.system(size: 14))
                    }
                    HStack(alignment:.top){
                        Image(systemName: "circle.fill")
                            .foregroundColor(.salamtackWelcome)
                            .font(.system(size: 12))
                        
                        Text("Fees:_".localized(language) + " \(Doctor.FeesFrom ?? 0) " + "L.E_".localized(language))
                            .foregroundColor(.black.opacity(0.8))
                            .font(.system(size: 14))
                    }
                    
                }
                .frame(width:UIScreen.main.bounds.width/3 * 2)
                
                Spacer()
                VStack{
                    //MARK:  --- Rate ---
                    VStack{
                        Text(String(format: "%.1f", Doctor.Rate ?? 0))
                            .foregroundColor(.salamtackBlue)
                            .font(.salamtakRegular(of: 11))

                        StarsView(rating: Float( Doctor.Rate ?? 0))
                            .frame(width:50)
                        
                        Text(" \(Doctor.NumVisites ?? 0) "+"Viewsـ".localized(language))
                            .foregroundColor(.black.opacity(0.7))
                            .font(.salamtakRegular(of: 11))
                    }
                    Spacer()
                    
                    VStack(spacing:2){
                        ForEach(medicalType.publishedModelExaminationTypeId,id:\.self){ type in

                                    HStack(){
                                        remoteAsyncImage(imageUrl: type.image ?? "",foregroundColor:(Color("lightGray")))
                                            
                                            .frame(width: 20, height: 20, alignment: .center)
                                            .AddBlueBorder(cornerRadius:4,linewidth:0.3)
                                        Text(type.Name ?? "")
                                            .font(Font.system(size: 11))
                                            .bold()
                                    Spacer()
                                    }
                                    .foregroundColor( Color("lightGray"))
                                    .frame(height: 20)
                        }
                    }
                    
                    Spacer()
                    
                    
                    Button(action: {
//                        SelectedDoctor = Doctor
//                        gotodoctorDetails = true
                        BookingAction?()
                    }, label: {
                        HStack{
                            Text("Booking_Calendar".localized(language))
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                                .bold()
                                .multilineTextAlignment(.center)
                        }
                    }
                    )
                        .frame(height:50)
//                        .frame(width:100)
                        .buttonStyle(.plain)
                        .padding(.horizontal,8)
                        .background(Color("blueColor"))
                        .cornerRadius(12)
                }
            }
            .frame(height:250)
            
            HStack{
                Text("Next_Available_Booking")
                    .bold()
                    .foregroundColor(.salamtackBlue)
                Spacer()
                Text(" \(ConvertStringDate(inp: Doctor.AvailableFrom ?? "", FormatFrom: "dd-MM-yyyy HH:mm", FormatTo: "dd/MM/yyyy"))" )
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Text("\(ConvertStringDate(inp: Doctor.AvailableFrom ?? "", FormatFrom: "dd-MM-yyyy HH:mm", FormatTo: "hh:mm a"))")
                    .foregroundColor(.white)
                    .bold()
            }
            .font(.system(size: 14))
            .padding(.horizontal)
            .padding(.vertical,8)
            .background(Color.salamtackWelcome)
            .cornerRadius(24)
        }
//        .padding(.horizontal)
        
    }
}
