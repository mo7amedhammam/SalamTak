//
//  OtherMedicalServicesFilter.swift
//  SalamTak
//
//  Created by wecancity on 01/02/2023.
//

import SwiftUI
struct OtherMedicalServicesFilter: View {
    @EnvironmentObject var OtherMedicalServices : ViewModelOtherMedicalServices

//    @StateObject var specialityvm = ViewModelSpecialist()
//    @StateObject var FeesVM = ViewModelFees()
//    @EnvironmentObject var searchDoc : VMSearchDoc
    @EnvironmentObject var AdsVM : ViewModelSlidingAds
    @State private var currentStep = 0
    @State var VideoLink = "https://www.youtube.com/watch?v=tYBZ8AVH0Q0"
    @State private var isActive: Bool = false

    @EnvironmentObject var environments : EnvironmentsVM
    var language = LocalizationService.shared.language
    
//    @State  var isSearch = false
    @State var gotoMedicaServicesList = false
    @Binding var isPresented : Bool

//    @State var gotoSearchdoctor = false
//    
//    @Binding var selectedTypeId : Int
//    
//    @State var selectedSpecialityId  = 0
//    @State var selectedSpecialityName  = ""
    @State private var previousindex = 0
    @State private var currentindex = 0
    @State private var idToScrol = 0
//    let gender : [genderModel] = [
//        genderModel.init(name: "Male_", id: 1),
//        genderModel.init(name: "FeMale_", id: 2),
//        genderModel.init(name: "Any", id: 0)
//    ]
    var body: some View {
        ZStack{
            VStack{
                
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120, alignment: .center)
//                    .edgesIgnoringSafeArea(.top)

//                AppBarView(Title: "Choose_Speciality".localized(language),withbackButton: true)
//                    .frame(height:70)
//                    .padding(.top,-20)
                
                
                ScrollView( showsIndicators: false){
                    //MARK: -- Ads --
                    if AdsVM.publishedAdsModel.count > 0{
                        TabView(selection: $currentStep) {
                            ForEach(0..<AdsVM.publishedAdsModel.count, id:\.self){ ad in
                                ZStack{
                                    if AdsVM.publishedAdsModel[ad].isVideo ?? false{
                                        LinkView(link: "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")")
                                            .disabled(true)
                                            .onAppear(perform: {
                                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                                                    VideoLink = "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")"
                                                })
                                            })
                                        //                                        YoutubeVideoView(youtubeVideoID:AdsVM.publishedAdsModel[ad].Link?.youtubeID ?? "")
                                    }else{
                                        AsyncImage(url: URL(string: "\(URLs.BaseUrl)\(AdsVM.publishedAdsModel[ad].videoLink ?? "")")) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width-40, height: 150)
                                .cornerRadius(12)
                                .overlay(
                                    HStack{
                                        Button(action: {
                                            currentStep = currentStep < AdsVM.publishedAdsModel.count-1 ? currentStep + 1 : 0
                                        }, label: {
                                            Image("newleft")
                                                .resizable()
                                                .frame(width:15, height:20)
                                                .scaledToFit()
                                        })
                                        Spacer()
                                        Button(action: {
                                            if AdsVM.publishedAdsModel[ad].isVideo ?? false {
                                                //                                                VideoLink = "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")"
//                                                isTimerRunning = false
                                                isActive.toggle()
                                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                                                    VideoLink = "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")"
                                                })
                                            }else{
                                                //preview image
                                            }
                                        }, label: {
                                            ZStack{
                                                if AdsVM.publishedAdsModel[ad].isVideo ?? false{
                                                    Image("newyoutubelogo")
                                                        .resizable()
                                                        .frame(width:65, height:55)
                                                }
                                            }.frame(width: 200, height: 150, alignment: .center)
                                        })
                                        Spacer()
                                        Button(action: {
                                            currentStep = currentStep < AdsVM.publishedAdsModel.count-1 ? currentStep + 1 : 0
                                        }, label: {
                                            Image("newright")
                                                .resizable()
                                                .frame(width:15, height:20)
                                                .scaledToFit()
                                        })
                                    }
                                        .frame( height:120)
                                        .padding(.horizontal,10)
                                )
                                .padding(.horizontal)
                                .padding(.top,-20)
                                .tag(ad)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
//                        .padding(.top,-30)
                        .frame( height: 170)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                        .onReceive(timer, perform: { _ in
//                            if isTimerRunning{
//                                DispatchQueue.main.async(execute: {
//                                    print("selection is",currentStep)
//                                    currentStep = currentStep < AdsVM.publishedAdsModel.count-1 ? currentStep + 1 : 0
//                                })
//                            }
//                        })
                        
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
//                                    currentStep = currentStep < (ad.getAdImagesDtos?.count ?? 0)-1 ? currentStep + 1 : 0
                                
                                currentStep = (currentStep + 1) % (AdsVM.publishedAdsModel.count )
                            }
                        }
                    }else{
                        //No ads
                    }
                    Group{
//                        SearchBar(PlaceHolder:"Search_a_doctor...".localized(language),text: $searchDoc.DoctorName, isSearch: $isSearch){
//                        }
//                        .AddBlueBorder(linewidth:1.3)
//                        .padding(.horizontal)
                        HStack {
                            Text("Our_Services_Directory".localized(language))
                                .foregroundColor(.salamtackBlue)
                                .font(.salamtakBold(of: 18))
                            Spacer()
                        }
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        HStack(spacing:3){
                            Button(action:{
                                if previousindex > 0 {
                                    idToScrol = previousindex - 4
                                }else{
                                    idToScrol = 0
                                }
                            }){
                                Image(systemName: "arrowtriangle.left.fill")
                            }.buttonStyle(.plain)
                            
                            ScrollView(.horizontal,showsIndicators:false){
                                ScrollViewReader { Scroll in
                                    LazyHStack(alignment:.top, spacing:8) {
                                        ForEach(0..<(OtherMedicalServices.medicalServises.count), id:\.self){ speciality in
                                            Button(action: {
                                                
                                                OtherMedicalServices.medicalServiseName = OtherMedicalServices.medicalServises[speciality].Name ?? ""

                                                OtherMedicalServices.medicalServiseId = OtherMedicalServices.medicalServises[speciality].id ?? 1212113115
//                                                environments.SpecialityId = OtherMedicalServices.medicalServises[speciality].id ?? 1212113115
//                                                searchDoc.SpecialistName = specialityvm.publishedSpecialistModel[speciality].Name ?? ""
//                                                selectedSpecialityId = specialityvm.publishedSpecialistModel[speciality].id ?? 1212113115
//                                                selectedSpecialityName = specialityvm.publishedSpecialistModel[speciality].Name ?? ""
                                            }, label: {
                                                OtherMedicalServicesButton(MedicalType: OtherMedicalServices.medicalServises[speciality] ,forgroundColor: OtherMedicalServices.medicalServiseId == OtherMedicalServices.medicalServises[speciality].id ?? 1212113115 ? .white:.salamtackBlue ,backgroundColor: OtherMedicalServices.medicalServiseId == OtherMedicalServices.medicalServises[speciality].id ?? 1212113115 ? .salamtackBlue : .clear )
                                                    .aspectRatio( contentMode: .fill)
                                                    .frame(width: (UIScreen.main.bounds.width)/4,height:140)
                                            })
                                                .id(speciality)
                                                .cornerRadius(8)
                                                .shadow(color: .black.opacity(0.099), radius: 5)
                                                .onAppear(perform: {
                                                    currentindex = speciality
                                                    print("appear: \(OtherMedicalServices.medicalServises[speciality].Name ?? "")")
                                                })
                                                .onDisappear(perform: {
                                                    previousindex = speciality
                                                    print("disaprear: \(OtherMedicalServices.medicalServises[speciality].Name ?? "")")
                                                })
                                        }
                                    }
                                    .onChange(of: idToScrol, perform: {newval in
                                        withAnimation{
                                            Scroll.scrollTo(newval , anchor: .center)
                                        }
                                    })
                                }
                            }
                            Button(action:{
                                if currentindex < OtherMedicalServices.medicalServises.count {
                                    idToScrol = currentindex +  2
                                }else{
                                }
                            }){
                                Image(systemName: "arrowtriangle.right.fill")
                            }.buttonStyle(.plain)
                        }
                                                
//                        HStack{
//                            Text("SubSpeciality_".localized(language))
//                            InputTextField(text: .constant(searchDoc.FilterSubSpecialistName.joined(separator: ", ") ),iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "",isactive: false){
//                                environments.SubSpecialityId = searchDoc.SubSpecialistId ?? []
//                                environments.SubSpecialityName = searchDoc.SubSpecialistName ?? []
//                                environments.ShowSubSpeciality = true
//                            }
//                        }
//                        .frame(width:(UIScreen.main.bounds.width/1) - 40)
//                        .fixedSize(horizontal: true, vertical: false)
//                        .padding(.top)
//                        .font(.salamtakRegular(of: 15))
//                        .foregroundColor(.salamtackBlue)
                        
                        HStack{
                            Text("City_".localized(language))
                            InputTextField(text: .constant(OtherMedicalServices.CityName ),iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "",isactive: false){
                                environments.CountryId = 1
                                environments.CityId = OtherMedicalServices.CityId
                                environments.cityName = OtherMedicalServices.CityName
                                environments.ShowCity = true
                            }
                            
                            Spacer()
                            Text("Area_".localized(language))
                            InputTextField(text: .constant(OtherMedicalServices.AreaName ),iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "",isactive: false){
                                environments.AreaId = OtherMedicalServices.AreaId
                                environments.areaName = OtherMedicalServices.AreaName
                                environments.ShowArea = true
                            }
                        }
                        .padding(.top,20)
                        .font(.salamtakRegular(of: 15))
                        .foregroundColor(.salamtackBlue)
                        
                        Button(action: {
                            //search
                            OtherMedicalServices.GetOtherMedicalServices()
                            if isPresented {
                                isPresented.toggle()
                            }else{
                                gotoMedicaServicesList = true
                            }
                        }, label: {
                            HStack{
                                Text("Search_".localized(language))
                                    .font(.salamtakBold(of: 20))
                                Image("newsearchlogo")
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color.salamtackBlue)
                            }
                            .foregroundColor(Color.salamtackBlue)

                        })
                            .frame(width: 150, height: 40)
                            .AddBlueBorder()
                            .padding(.top,80)
                            
                    }
                }
                .background(Color.clear)
                .padding([.horizontal])
                .frame(width: UIScreen.main.bounds.width)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $OtherMedicalServices .isLoading)
            
            //  go to clinic info
            NavigationLink(destination:OtherMedicalServicesList()
                            .environmentObject(OtherMedicalServices)
                            .environmentObject(environments)
                            .environmentObject(AdsVM)
                            .navigationBarHidden(true),isActive: $gotoMedicaServicesList) {
            }
        }
        .sheet(isPresented: $isActive, content: {
            LinkView(link: VideoLink)
                .frame(height:200)
                .onDisappear(perform: {
//                    isTimerRunning.toggle()
                })
        })
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(navController.popToRoot, perform: {newval in
            gotoMedicaServicesList = newval
        })
        
        .onAppear(perform: {
            currentindex = 0
            previousindex = 0
            idToScrol = 0
            environments.SpecialityId = OtherMedicalServices.medicalServiseId
            environments.CityId = OtherMedicalServices.CityId
            environments.AreaId = OtherMedicalServices.AreaId
            AdsVM.PageID = 2
            AdsVM.GetDashboardAds()
        })
        
        .background(
            newBackImage(backgroundcolor: .white, imageName:.image2)
        )
        
        .alert(isPresented: $OtherMedicalServices.isAlert, content: {
            Alert(title: Text(OtherMedicalServices.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                OtherMedicalServices.isAlert = false
            }))
        })
        
//        .onChange(of: environments.SpecialityId, perform: { newval in
//            searchDoc.SpecialistId = newval
//        })
//        .onChange(of: environments.SubSpecialityId, perform: { newval in
//            searchDoc.FilterSubSpecialistId = newval
//            searchDoc.FilterSubSpecialistName = environments.SubSpecialityName
//        })
        .onChange(of: environments.CityId, perform: { newval in
            OtherMedicalServices.CityId = newval
            OtherMedicalServices.CityName = environments.cityName
        })
        .onChange(of: environments.AreaId, perform: { newval in
            OtherMedicalServices.AreaId = newval
            OtherMedicalServices.AreaName = environments.areaName
        })
//        .onChange(of: environments.SeniorityId, perform: { newval in
//            searchDoc.FilterSeniortyLevelId = newval
//            searchDoc.FilterSeniortyLevelName = environments.SeniorityName
//        })

        
    }
}

struct OtherMedicalServicesFilter_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            OtherMedicalServicesFilter( isPresented: .constant(false))
                .environmentObject(EnvironmentsVM())
                .environmentObject( ViewModelOtherMedicalServices())
        }
        .navigationBarHidden(true).previewInterfaceOrientation(.portrait)
    }
}
