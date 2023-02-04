//
//  OtherMedicalServicesCell.swift
//  SalamTak
//
//  Created by wecancity on 04/02/2023.
//

import SwiftUI

    struct OtherMedicalServicesCell: View {
        var language = LocalizationService.shared.language

        var MedicalService:ModelOtherMedicalServices
        var MoreInfoAction: (() -> ())?
        var ImageAction: (() -> ())?
        var ButtonAction: (() -> ())?

        var body: some View {
            VStack {
                HStack (spacing:0){
                    VStack(alignment:.leading){
                        ZStack(alignment:.leading){
                            Image("Awsome")
                                .resizable()
                                .frame(width:(UIScreen.main.bounds.width / 3) * 2,height:150)
                                .aspectRatio( contentMode: .fit)
                            
                            AsyncImage(url: URL(string:   URLs.BaseUrl + "\(MedicalService.logo ?? "")" )) { image in
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
//                                    Text("Dr.".localized(language))
//                                        .bold()
                                    Text(MedicalService.name?.firstWord ?? "")
                                        .bold()
                                }
                                Text("\(MedicalService.name ?? "" )".components(separatedBy: " ").dropFirst().joined(separator: " "))
                                        .bold()
                                    }
//                                    Text("More...".localized(language))
//                                        .bold()
//                                        .font(Font.system(size: 11))
//                                    .foregroundColor(.salamtackWelcome)
                                }
                                .font(Font.system(size: 18))
                                })
                                
                                
                                Spacer().frame(height:50)
                                
//                                Text(Doctor.SpecialistName ?? "")
//                                    .bold()
//                                    .font(Font.system(size: 11))
                                
                            }
                            .offset(x:(UIScreen.main.bounds.width / 3) + 20)
                            .foregroundColor(.salamtackBlue)
                        }
                     
                        

                        HStack(alignment:.top){
                            Image(systemName: "circle.fill")
                                .foregroundColor(.salamtackWelcome)
                                .font(.system(size: 12))
                            Text("Phone:_".localized(language))
                                .foregroundColor(.black.opacity(0.8))
                                .font(.system(size: 14))
                            
                            Text("\(MedicalService.healthEntityPhoneDtos?.joined(separator: ", ") ?? "")")
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
                            
                            Text("\(MedicalService.address ?? "")")
                                .foregroundColor(.black.opacity(0.8))
                                .font(.system(size: 14))
                        }

//                        HStack(alignment:.top){
//                            Image(systemName: "circle.fill")
//                                .foregroundColor(.salamtackWelcome)
//                                .font(.system(size: 12))
//
//                            Text("Waiting_Time:_".localized(language) + " \(Doctor.WaitingTime ?? 0) " + "Minutes_".localized(language))
//                                .foregroundColor(.black.opacity(0.8))
//                                .font(.system(size: 14))
//                        }
//                        HStack(alignment:.top){
//                            Image(systemName: "circle.fill")
//                                .foregroundColor(.salamtackWelcome)
//                                .font(.system(size: 12))
//
//                            Text("Fees:_".localized(language) + " \(Doctor.FeesFrom ?? 0) " + "L.E_".localized(language))
//                                .foregroundColor(.black.opacity(0.8))
//                                .font(.system(size: 14))
//                        }
                        
                    }
                    .frame(width:UIScreen.main.bounds.width/3 * 2)
                    
                    Spacer()
                    VStack{
                        //MARK:  --- Rate ---
//                        VStack{
//                            Text(String(format: "%.1f", MedicalService.Rate ?? 0))
//                                .foregroundColor(.salamtackBlue)
//                                .font(.salamtakRegular(of: 11))
//
//                            StarsView(rating: Float( Doctor.Rate ?? 0))
//                                .frame(width:50)
//
//                            Text(" \(Doctor.NumVisites ?? 0) "+"Viewsـ".localized(language))
//                                .foregroundColor(.black.opacity(0.7))
//                                .font(.salamtakRegular(of: 11))
//                        }
                        Spacer()
                        
                        VStack(spacing:2){

                            
                        }
                        
                        Spacer()
                        
                        
                        Button(action: {
                            ButtonAction?()
                        }, label: {
                            HStack{
                                Text("Call_".localized(language))
                                    .foregroundColor(.white)
                                    .font(.system(size: 15))
                                    .fontWeight(.heavy)                                    .multilineTextAlignment(.center)
                            }
                        }
                        )
                            .frame(height:50)
                            .frame(minWidth:80)
                            .buttonStyle(.plain)
                            .padding(.horizontal,8)
                            .background(Color("blueColor"))
                            .cornerRadius(12)
                    }
                }
                .frame(height:220)
                
//                HStack{
//                    Text("Next_Available_Booking")
//                        .bold()
//                        .foregroundColor(.salamtackBlue)
//                    Spacer()
//                    Text(" \(ConvertStringDate(inp: Doctor.AvailableFrom ?? "", FormatFrom: "dd-MM-yyyy HH:mm", FormatTo: "dd/MM/yyyy"))" )
//                        .foregroundColor(.white)
//                        .bold()
//                    Spacer()
//                    Text("\(ConvertStringDate(inp: Doctor.AvailableFrom ?? "", FormatFrom: "dd-MM-yyyy HH:mm", FormatTo: "hh:mm a"))")
//                        .foregroundColor(.white)
//                        .bold()
//                }
//                .font(.system(size: 14))
//                .padding(.horizontal)
//                .padding(.vertical,8)
//                .background(Color.salamtackWelcome)
//                .cornerRadius(24)
            }
        }
    }

struct OtherMedicalServicesCell_Previews: PreviewProvider {
        static var previews: some View {
            OtherMedicalServicesCell( MedicalService: ModelOtherMedicalServices.init(id: 0, logo: "", healthEntityPhoneDtos: ["011","012"], cityName: "", areaName: "", healthEntityServices: [0], healthEntityServiceName: [""], name: "mokhtabr", nameAr: "مختبر", email: "mail", countryID: 1, cityID: 1, areaID: 1, address: "address address1 address2", latitude: "", longitude: "", blockNo: "", floorNo: 12, apartmentNo: "", fixedFee: 120, inactive: false, medicalExaminationTypeID: 1, street: ""))
//                .environmentObject(ViewModelExaminationTypeId())
        }
    }
