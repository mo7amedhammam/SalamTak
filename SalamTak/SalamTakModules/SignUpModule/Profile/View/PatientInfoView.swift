//
//  PatientInfoView.swift
//  SalamTak
//
//  Created by wecancity on 29/12/2022.
//

import SwiftUI

struct PatientInfoView: View {
    
//    @State private var keyboardHeight: CGFloat = 0
    
    var language = LocalizationService.shared.language
    
//    @State private var image = UIImage()
    @State private var showImageSheet = false
    @State private var startPicking = false
    @State private var imgsource = ""
//    @State var bounds = UIScreen.main.bounds
//    @State var offset = CGSize.zero
//    @FocusState private var focusedInput: Field?
//    let screenWidth = UIScreen.main.bounds.size.width - 55
//    @State var isValid = false
//    @State var ShowingMap = false
//    @State var ShowNationality = false
//    @State var  buttonSelected = 0
    
    @State var ShowCity = false
    @State var ShowArea = false
    @State var ShowOccupation = false
    
    @StateObject var profileVM = PatientInfoViewModel()
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var NationalityVM = ViewModelCountries()
    @StateObject var OccupationVM = ViewModelOccupation()

    var body: some View {
        VStack(spacing:0){
            AppBarView(Title: "Patient_Profile".localized(language), imageName: "1/2", backColor: .clear, withbackButton: false)
                .frame(height:60)
            ScrollView(showsIndicators: false){
                
                //MARK: --- profile Image ----
                ZStack (alignment:.bottom){
                    ZStack (){
                        Button(action: {
                            
                        }, label: {
                            Image(uiImage: profileVM.profileImage )
                                .resizable()
                                .foregroundColor(Color("blueColor"))
                                .clipShape(Rectangle())
                        })
                    }
                    .frame(width: 70, height: 70, alignment: .center)
                    .background(Image(systemName: "camera")
                                    .resizable()
                                    .foregroundColor(Color("blueColor").opacity(0.4))
                                    .frame(width: 25, height: 25)
                                    .background(Rectangle()
                                                    .frame(width:70,height:70)
                                                    .foregroundColor(Color("lightGray")).opacity(0.3)
                                                    .cornerRadius(4))
                    )
                    .cornerRadius(10)
                    CircularButton(ButtonImage:Image(systemName: "pencil" ) , forgroundColor: Color.gray, backgroundColor: Color.white.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
                        self.showImageSheet = true
                        
                    }.padding(.bottom,-20)
//                    .padding(.top,70)
                } .frame(width: 90, height: 90, alignment: .center)
                    .background(Color.clear)

                //MARK: --- Name ----
                Group{
                HStack(){
                    Text("Full_Name:".localized(language))
                        .font(.salamtakBold(of: 14))
                        .foregroundColor(.salamtackBlue)
                    Spacer()
                }
                .padding(.horizontal,5)
                .padding(.bottom,-5)
                
                //MARK: --- English Name ----
                HStack(spacing:2){
                    InputTextField(text: $profileVM.FirstName, textplacholder: "First_Name".localized(language),errorMsg: profileVM.errorFirstName, title: "")
                    InputTextField(text: $profileVM.MiddelName, textplacholder: "Middle_Name".localized(language), errorMsg: profileVM.errorFirstName, title: "")
                    InputTextField(text: $profileVM.FamilyName, textplacholder: "Last_Name".localized(language),errorMsg: profileVM.errorFirstName, title: "")
                }

                //MARK: --- Arabic Name ----
                HStack(spacing:2){
                    InputTextField(text: $profileVM.FirstName,  textplacholder: "First_Name_Ar".localized(language),errorMsg: profileVM.errorFirstName, title: "")
                    InputTextField(text: $profileVM.MiddelName,  textplacholder: "Middle_Name_Ar".localized(language),errorMsg: profileVM.errorFirstName, title: "")
                    InputTextField(text: $profileVM.FamilyName,  textplacholder: "Last_Name_Ar".localized(language),errorMsg: profileVM.errorFirstName, title: "")
                }
                }
                
                InputTextField(text: $profileVM.countryName,  textplacholder: "".localized(language),errorMsg: profileVM.errorFirstName, title: "Nationality_")

              
                //MARK: --- Full address ----
                Group{
                InputTextField(text: $profileVM.Address,errorMsg: "", title: "Street".localized(language))

                InputTextField(text: $profileVM.BlockNo,errorMsg: "", title: "Building_Number".localized(language))

                InputTextField(text: $profileVM.FloorNo.string(),errorMsg: "", title: "Floor_Number".localized(language))

                InputTextField(text: $profileVM.ApartmentNo,errorMsg: "", title: "Apartment_Number".localized(language))

                InputTextField(text: $profileVM.EmergencyContact,errorMsg: "", title: "Emergancy_Contact".localized(language))
            }
                
                Spacer()
            }
            .padding(.horizontal,10)
            .padding(.bottom,-10)
            SupportCall()
                .frame(height:55)
        }
    }
}

struct PatientInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoView()
    }
}
