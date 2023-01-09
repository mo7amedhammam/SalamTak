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

//    @State var ShowCountry = false
//    @State var ShowCity = false
//    @State var ShowArea = false
//    @State var ShowOccupation = false
//    @State var ShowCalendar = false
    @EnvironmentObject var environments:EnvironmentsVM
    @StateObject var profileVM = PatientInfoViewModel()
    
//    @State var startingDate = Date()
//    @State var endingDate = Date()
    @State var next = false
    @Binding var index : Int // 0:profile 1:medical

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
                            hideKeyboard()
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
                            hideKeyboard()
                            environments.CountryId = profileVM.CountryId
                            environments.countryName = profileVM.countryName
                            environments.ShowCountry = true
                        }
                        .onChange(of: environments.CountryId, perform: {newval in
                            if newval != profileVM.CountryId{
                                profileVM.CountryId = newval
                                profileVM.countryName = environments.countryName
                            }
                        })
                        
                        InputTextField(text: $profileVM.BirthdayStr ,iconName: .DropList(icon: "newCalendaricon"),iconSize: 33 , textplacholder: "dd/mm/yyyy".localized(language),errorMsg: $profileVM.errorBirthday, title: "Date_Of_Birth",isactive: false){
                            environments.startingDate = (Calendar.current.date(byAdding: .year, value: -50, to: Date()) ?? Date())
                            environments.endingDate = (Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date())
                            hideKeyboard()
                            environments.Birthday = profileVM.Birthday
                            environments.ShowCalendar = true
                        }
//                        .onChange(of: environments.Birthday, perform: {newval in
////                            if newval != profileVM.Birthday{
////                                profileVM.Birthday = newval
////                            }
//                        })
                        
                        HStack {
                            Text("Gender_".localized(language))
                                .font(.salamtakBold(of: 15))
                                .foregroundColor(.salamtackBlue)
                            Spacer()
                            GenderView(GenderId: $profileVM.GenderId, GenderName: $profileVM.GenderName )
                        }
                        
                        InputTextField(text: $profileVM.occupationName,iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "Occupation_",isactive: false){
                            hideKeyboard()
                            environments.OccupationId = profileVM.OccupationId
                            environments.occupationName = profileVM.occupationName
                            environments.ShowOccupation = true
                        }
//                        .onChange(of: environments.OccupationId, perform: {newval in
//                            if newval != profileVM.OccupationId{
//                                profileVM.OccupationId = newval
//                                profileVM.occupationName = environments.occupationName
//                            }
//                        })
                        
                        InputTextField(text: $profileVM.cityName,iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "City_",isactive: false){
                            hideKeyboard()
                            environments.CityId = profileVM.CityId
                            environments.cityName = profileVM.cityName
                            environments.ShowCity = true
                        }
//                        .onChange(of: environments.CityId, perform: {newval in
//                            if newval != profileVM.CityId{
//                                profileVM.CityId = newval
//                                profileVM.cityName = environments.cityName
//                            }
//                        })
                        
                        InputTextField(text: $profileVM.areaName,iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "Area_",isactive: false){
                            hideKeyboard()
                            environments.AreaId = profileVM.AreaId
                            environments.areaName = profileVM.areaName
                            environments.ShowArea = true
                        }
//                        .onChange(of: environments.AreaId, perform: {newval in
//                            if newval != profileVM.AreaId{
//                                profileVM.AreaId = newval
//                                profileVM.areaName = environments.areaName
//                            }
//                        })
                    }
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    
                    //MARK: --- Full address ----
                    Group{
                        InputTextField(text: $profileVM.Address,errorMsg: .constant(""), title: "Street".localized(language))
                        
                        InputTextField(text: $profileVM.BlockNo,errorMsg: .constant(""), title: "Building_Number".localized(language))
                        
                        InputTextField(text: $profileVM.FloorNo,errorMsg: .constant(""), title: "Floor_Number".localized(language))
                            .keyboardType(.asciiCapableNumberPad)
                        
                        InputTextField(text: $profileVM.ApartmentNo,errorMsg: .constant(""), title: "Apartment_Number".localized(language))
                        
                        InputTextField(text: $profileVM.EmergencyContact,errorMsg: .constant(""), title: "Emergancy_Contact".localized(language))
                            .keyboardType(.numberPad)
                    }
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)

                    BorderedButton(text: "Next_".localized(language), isActive:
                                        .constant(
                                            profileVM.formIsValid
                        && profileVM.countryName != "" && profileVM.GenderName != "" && profileVM.occupationName != "" && profileVM.cityName != "" && profileVM.areaName != "" && profileVM.Address != "" && profileVM.BlockNo != "" && profileVM.FloorNo != "" && profileVM.ApartmentNo != "" && profileVM.EmergencyContact != ""
                    )){
                        if taskOP == .update{
                            profileVM.execute(Operation: .UpdatePatientProfileInfo)
                        }else{
                            profileVM.execute(Operation: .CreatePatientProfileInfo)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal,60)
                    Spacer()
                }
                .padding(.horizontal,10)
            }
            .padding(.bottom,hasNotch ? (taskOP == .update ? 0:10):50)
            .onAppear(perform: {
                if taskOP == .update {
                    profileVM.execute(Operation: .GetPatientProfileInfo)
//                profileVM.PatientProfileOP = .UpdatePatientProfileInfo
                    
//                    environments.CountryId
                    
                } else {
    //                if taskOP == .create{
                    profileVM.PatientProfileOP = .CreatePatientProfileInfo
    //                }else{
    //                profileVM.PatientProfileOP = .UpdatePatientProfileInfo
    //                }
                }
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
            // Alert with no internet connection
            .alert(isPresented: $profileVM.isAlert, content: {
                Alert(title: Text(profileVM.message.localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    profileVM.isAlert = false
                    if profileVM.UserUpdated{
                            index = 1
                    }
                }))
        })
        
            if taskOP != .update{
            SupportCall()
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarHidden(true)
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        .disabled(environments.ShowCountry||environments.ShowCity||environments.ShowArea||environments.ShowCalendar||environments.ShowOccupation)
        
        .overlay(
            ZStack{
                if taskOP == .create{
                if environments.ShowCountry {
                    ShowNationalityList( ShowNationality: $environments.ShowCountry,SelectedNationalityName:$environments.countryName,SelectedNationalityId:$environments.CountryId)
                } else if environments.ShowCity{
                    ShowCityList(ShowCity: $environments.ShowCity, SelectedCountryId: $environments.CountryId, SelectedCityName: $environments.cityName, SelectedCityId: $environments.CityId)
                }else if environments.ShowArea{
                    ShowAreaList(ShowArea: $environments.ShowArea, SelectedCityId: $environments.CityId, SelectedAreaName: $environments.areaName , SelectedAreaId: $environments.AreaId)
                }else if environments.ShowOccupation{
                    ShowOccupationList(ShowOccupation: $environments.ShowOccupation, SelectedOccupationName: $environments.occupationName, SelectedOccupationId: $environments.OccupationId)
                }else if environments.ShowCalendar{
                    CalendarPopup( selectedDate: $environments.Birthday, isPresented: $environments.ShowCalendar,rangeType:environments.dateRange ,startingDate:environments.startingDate,endingDate:environments.endingDate)
            }
                }
            }
                .onChange(of: environments.CountryId, perform: { newval in
                    if newval != profileVM.CountryId{
                    profileVM.cityName = ""
                    profileVM.CityId = 0
                    }
                })
                .onChange(of: environments.CityId, perform: { newval in
                    if newval != profileVM.CityId{
                    profileVM.areaName = ""
                    profileVM.AreaId = 0
                    }
                })
                .onChange(of: environments.Birthday, perform: {newval in
                    if  newval != profileVM.Birthday{
                        profileVM.Birthday = newval
                    profileVM.BirthdayStr = ChangeFormate(NewFormat: "dd/MM/yyyy").string(from: newval)
                    }
                })

        )
        .overlay(
            ActivityIndicatorView(isPresented: $profileVM.isLoading)
        )

        .background(
            newBackImage(backgroundcolor: .white)
        )

        // go to verify account to resset
        NavigationLink(destination: PatientMedicalInfoView(taskOP:taskOP,index: $index)
                        .environmentObject(environments)
//                        .environmentObject(PatientMedicalInfoViewModel())
                       ,isActive: $profileVM.UserCreated) {
                }
        
        .onTapGesture(perform: {
            hideKeyboard()
        })
//        .onChange(of: profileVM.UserUpdated, perform: {newval in
//            if newval == true{
//                index = 1
//            }
//        })
    }
}

struct PatientInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoView(taskOP: .create, index: .constant(0))
            .environmentObject(PatientInfoViewModel())
//            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))

    }
}
