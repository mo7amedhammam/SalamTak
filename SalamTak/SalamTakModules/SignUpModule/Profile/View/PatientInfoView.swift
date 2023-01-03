//
//  PatientInfoView.swift
//  SalamTak
//
//  Created by wecancity on 29/12/2022.
//

import SwiftUI
enum profiletask{
    case create, update, complete
}
struct PatientInfoView: View {
    
    var language = LocalizationService.shared.language
    var taskOP : profiletask

    @State private var showImageSheet = false
    @State private var startPicking = false
    @State private var imgsource = ""

    @State var ShowCountry = false
    @State var ShowCity = false
    @State var ShowArea = false
    @State var ShowOccupation = false
    @State var ShowCalendar = false

    @StateObject var profileVM = PatientInfoViewModel()
//    @StateObject var locationViewModel = LocationViewModel()
//    @StateObject var NationalityVM = ViewModelCountries()
//    @StateObject var OccupationVM = ViewModelOccupation()
    
    @State var startingDate = Date()
    @State var endingDate = Date()
    @State var next = false
    var body: some View {
        ZStack {
            VStack(spacing:0){
                AppBarView(Title: "Patient_Profile".localized(language), imageName: "1/2", backColor: .clear, withbackButton: false)
                    .frame(height:60)
                ScrollView(showsIndicators: false){
                    
                    //MARK: --- profile Image ----
                    ZStack (alignment:.bottom){
                        ZStack (){
                            Button(action: {
                                
                            }, label: {
                                if profileVM.profileImage.size.width > 0{
                                    Image(uiImage: profileVM.profileImage )
                                        .resizable()
                                        .foregroundColor(Color("blueColor"))
                                        .clipShape(Rectangle())
                                }else{
                                    AsyncImage(url: URL(string: Helper.getUserimage())) { image in
                                        image.resizable()
//                                            .onTapGesture(perform: {
//                                                imageVM.isPresented = true
//                                                imageVM.imageUrl = Constants.baseURL +  profileVM.DriverImageStr.replacingOccurrences(of: "\\",with: "/")
//                                            })
                                    } placeholder: {
                                        Color("lightGray").opacity(0.2)
                                    }
                                }
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
                            InputTextField(text: $profileVM.FirstName, textplacholder: "First_Name".localized(language),errorMsg: $profileVM.errorFirstName, title: "")
                            InputTextField(text: $profileVM.MiddelName, textplacholder: "Middle_Name".localized(language), errorMsg: $profileVM.errorMiddelName, title: "")
                            InputTextField(text: $profileVM.FamilyName, textplacholder: "Last_Name".localized(language),errorMsg: $profileVM.errorFirstName, title: "")
                        }
                        
                        //MARK: --- Arabic Name ----
                        HStack(spacing:2){
                            InputTextField(text: $profileVM.FirstNameAr,  textplacholder: "First_Name_Ar".localized(language),errorMsg: $profileVM.errorFirstNameAr, title: "")
                            InputTextField(text: $profileVM.MiddelNameAr,  textplacholder: "Middle_Name_Ar".localized(language),errorMsg: $profileVM.errorMiddelNameAr, title: "")
                            InputTextField(text: $profileVM.FamilyNameAr,  textplacholder: "Last_Name_Ar".localized(language),errorMsg: $profileVM.errorFirstNameAr, title: "")
                        }
                    }
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    
                    Group{
                        InputTextField(text: $profileVM.countryName,iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: $profileVM.errorFirstName, title: "Nationality_",isactive: false){
                            ShowCountry = true
                        }
                        
                        InputTextField(text: $profileVM.BirthdayStr ,iconName: .DropList(icon: "newCalendaricon"),iconSize: 33 , textplacholder: "dd/mm/yyyy".localized(language),errorMsg: $profileVM.errorBirthday, title: "Date_Of_Birth",isactive: false){
                            startingDate = (Calendar.current.date(byAdding: .year, value: -50, to: Date()) ?? Date())
                            endingDate = (Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date())

                            ShowCalendar = true
                        }
                        
                        HStack {
                            Text("Gender_".localized(language))
                                .font(.salamtakBold(of: 15))
                                .foregroundColor(.salamtackBlue)
                            Spacer()
                            GenderView(GenderId: $profileVM.GenderId, GenderName: $profileVM.GenderName )
                        }
                        
                        InputTextField(text: $profileVM.occupationName,iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "Occupation_",isactive: false){
                            ShowOccupation = true
                        }
                        
                        InputTextField(text: $profileVM.cityName,iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "City_",isactive: false){
                            ShowCity = true
                        }
                        
                        InputTextField(text: $profileVM.areaName,iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "Area_",isactive: false){
                            ShowArea = true
                        }
                    }
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    
                    //MARK: --- Full address ----
                    Group{
                        InputTextField(text: $profileVM.Address,errorMsg: .constant(""), title: "Street".localized(language))
                        
                        InputTextField(text: $profileVM.BlockNo,errorMsg: .constant(""), title: "Building_Number".localized(language))
                        
                        InputTextField(text: $profileVM.FloorNo.string(),errorMsg: .constant(""), title: "Floor_Number".localized(language))
                        
                        InputTextField(text: $profileVM.ApartmentNo,errorMsg: .constant(""), title: "Apartment_Number".localized(language))
                        
                        InputTextField(text: $profileVM.EmergencyContact,errorMsg: .constant(""), title: "Emergancy_Contact".localized(language))
                            .keyboardType(.numberPad)
                    }
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)

                    BorderedButton(text: "Next_".localized(language), isActive:
                                        .constant(
                        profileVM.formIsValid
                        && profileVM.countryName != "" && profileVM.GenderName != "" && profileVM.occupationName != "" && profileVM.cityName != "" && profileVM.areaName != "" && profileVM.Address != "" && profileVM.BlockNo != "" && profileVM.FloorNo != 0 && profileVM.ApartmentNo != "" && profileVM.EmergencyContact != "" || true
                    )){
                        if taskOP == .create{
                            next = true
//                            profileVM.execute(Operation: .CreatePatientProfileInfo)
                        }else{
                        profileVM.execute(Operation: .UpdatePatientProfileInfo)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal,60)
                    Spacer()
                }
                .padding(.horizontal,10)
                .padding(.bottom,-10)
                SupportCall()
                    .frame(height:55)
//                    .edgesIgnoringSafeArea(.bottom)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            .onAppear(perform: {
                if taskOP == .update {
                profileVM.execute(Operation: .GetPatientProfileInfo)
                } else {
                    if taskOP == .create{
                    profileVM.PatientProfileOP = .CreatePatientProfileInfo
                    }else{
                    profileVM.PatientProfileOP = .UpdatePatientProfileInfo
                    }
                }
            })
            
            .onTapGesture(perform: {
                hideKeyboard()
            })
            
            .overlay(
                ActivityIndicatorView(isPresented: $profileVM.isLoading)
            )
            
            .background(
                newBackImage(backgroundcolor: .white)
            )
            
            // Alert with no internet connection
            .alert(isPresented: $profileVM.isAlert, content: {
                Alert(title: Text(profileVM.message.localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    profileVM.isAlert = false
                }))
        })
        
        }
        // go to verify account to resset
        NavigationLink(destination: PatientMedicalInfoView(taskOP:taskOP),isActive: $next) {
                }
        
        .overlay(
            ZStack{
            if ShowCountry {
                ShowNationalityList( ShowNationality: $ShowCountry,SelectedNationalityName:$profileVM.countryName,SelectedNationalityId:$profileVM.CountryId)
            } else if ShowCity{
                ShowCityList(ShowCity: $ShowCity, SelectedCountryId: $profileVM.CountryId, SelectedCityName: $profileVM.cityName, SelectedCityId: $profileVM.CityId)
            }else if ShowArea{
                ShowAreaList(ShowArea: $ShowArea, SelectedCityId: $profileVM.CityId, SelectedAreaName: $profileVM.areaName , SelectedAreaId: $profileVM.AreaId)
            }else if ShowOccupation{
                ShowOccupationList(ShowOccupation: $ShowOccupation, SelectedOccupationName: $profileVM.occupationName, SelectedOccupationId: $profileVM.OccupationId)
            }else if ShowCalendar{
                CalendarPopup( selectedDate: $profileVM.Birthday, isPresented: $ShowCalendar,rangeType:.close ,startingDate:startingDate,endingDate:endingDate)
            }
                
            }
                .onChange(of: profileVM.CountryId, perform: { _ in
                    profileVM.cityName = ""
                    profileVM.CityId = 0
                })
                .onChange(of: profileVM.CityId, perform: { _ in
                    profileVM.areaName = ""
                    profileVM.AreaId = 0
                })
        )
        .onChange(of: profileVM.Birthday, perform: {newval in
            profileVM.BirthdayStr = ChangeFormate(NewFormat: "dd/MM/yyyy").string(from: profileVM.Birthday)
        })
        //MARK: -------- imagePicker From Camera and Library ------
        .confirmationDialog("Choose Image From ?", isPresented: $showImageSheet) {
            Button("photo Library") { self.imgsource = "Library";   self.showImageSheet = false; self.startPicking = true }
            Button("Camera") {self.imgsource = "Cam" ;    self.showImageSheet = false; self.startPicking = true}
            Button("Cancel", role: .cancel) { }
        } message: {Text("Select Image From")}
        
        .sheet(isPresented: $startPicking) {
                // Pick an image from the photo library:
                ImagePicker(sourceType: imgsource == "Library" ? .photoLibrary : .camera, selectedImage: self.$profileVM.profileImage)
        }
        
    }
}

struct PatientInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoView(taskOP: .create)
    }
}
