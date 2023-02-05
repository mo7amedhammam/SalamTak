//
//  ViewDoctorClinics.swift
//  SalamTak
//
//  Created by wecancity on 23/01/2023.
//

import SwiftUI

struct ViewDoctorClinics: View {
    var language = LocalizationService.shared.language
    var Doctor:Doc
    @Binding var gotoBooking : Bool
    @Binding var BookingClinicId : Int?
    @EnvironmentObject var DocClinics : ViewModelDocClinics

    var body: some View {
        VStack( spacing:0){
            
            HStack {
                Text("Doctor_Clinics".localized(language))
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .bold()
            }
            .padding(.vertical,8)
            .padding(.horizontal,30)
            .background(Color.salamtackWelcome)
            .cornerRadius(20)
            

            ForEach(DocClinics.publishedModelSearchDoc,id:\.self){clinic in
            VStack {
                HStack(alignment:.top){
                        Image("doc2")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(5)
                            .clipShape(Circle())
                            .AddBlueBorder(cornerRadius: 30,linewidth: 1.2)
                        VStack(alignment:.leading,spacing:0){
                            Text("\(Doctor.ClinicName ?? "hosary clinic"): ")
                                .foregroundColor(.salamtackWelcome)
    //                            .font(.salamtakBold(of: 17))
                                .font(.system(size: 16))
                                .bold()
                            Text("\(Doctor.ClinicAddress ?? "6th october - hiosary")")
                                .foregroundColor(.black.opacity(0.7))
                                .font(Font.SalamtechFonts.Reg14)
                            //                Spacer()
                            
                            HStack(alignment:.top){
                                VStack(spacing:3){
                                HStack(){
                                Image("FilterFees")
            //                        .resizable()
                                    .frame(width: 15, height: 15)
                                    .padding(8)
                                    .clipShape(Circle())
                                    .AddBlueBorder(cornerRadius: 25,linewidth: 1.2)
                                HStack(){
                                    Text("Fees:".localized(language))
                                        .foregroundColor(.salamtackWelcome)
                                        .font(.system(size: 16))
                                        .bold()
                                    Text("starting_From".localized(language) + " \( Doctor.FeesFrom ?? 0.0) " + "EGP_".localized(language))
                                        .foregroundColor(.black.opacity(0.7))
                                        .font(.system(size: 11))
                                }
                                Spacer()
                            }
                               
                            HStack(){
                                Image("doc4")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .padding(8)
                                    .clipShape(Circle())
                                    .AddBlueBorder(cornerRadius: 25,linewidth: 1.2)
                                HStack(){
                                    Text("Waiting_Time:".localized(language))
                                        .foregroundColor(.salamtackWelcome)
                                        .font(.system(size: 16))
                                        .bold()
                                    Text("\(Doctor.WaitingTime ?? 0) " + "Minutes".localized(language))
                                        .foregroundColor(.black.opacity(0.7))
                                        .font(.system(size: 11))
                                }
                                Spacer()
                            }
                        }
                                
                                Button(action: {
                                    BookingClinicId = clinic.id ?? 0
                                    gotoBooking = true
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
                                    .frame(height:40)
                                    .frame(maxWidth:80)
                                    .buttonStyle(.plain)
                                    .padding(.horizontal,8)
                                    .background(Color("blueColor"))
                                    .cornerRadius(12)
                        }
                        }
    //                    .padding(.leading)
    //                        .padding()
                        Spacer()
                        
                    }
    //                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                 
//                .frame(width: UIScreen.main.bounds.width-30, height:55)
                
//                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
//                    .background(Color.white)
            }
                
            }
//            .frame(width: UIScreen.main.bounds.width-30, height:55)
//            .cornerRadius(9)
//            .shadow(color: .black.opacity(0.1), radius: 9)
            

//            .cornerRadius(9)
//            .shadow(color: .black.opacity(0.1), radius: 9)
        


        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
//        .onAppear(perform: {
//            DocClinics.DoctorId = Doctor.id ?? 0
//            DocClinics.FetchDoctorClinics()
//        })
    }
}

struct ViewDoctorClinics_Previews: PreviewProvider {
    static var previews: some View {
        ViewDoctorClinics(Doctor: Doc.init(),gotoBooking: .constant(false),BookingClinicId: .constant(0))
            .environmentObject(ViewModelDocClinics())
    }
}
