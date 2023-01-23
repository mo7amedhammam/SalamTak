//
//  SpecialityView.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 04/04/2022.
//

import Foundation
import SwiftUI

struct SpecialityView: View {
    @StateObject var specialityvm = ViewModelSpecialist()
    @StateObject var FeesVM = ViewModelFees()

    @EnvironmentObject var searchDoc : VMSearchDoc
    @EnvironmentObject var environments : EnvironmentsVM
    var language = LocalizationService.shared.language
    @State  var isSearch = false

    @State var gotocity = false
    @State var gotoSearchdoctor = false
    @Binding var selectedTypeId : Int
    @State var selectedSpecialityId  = 0
    @State var selectedSpecialityName  = ""
    
    @State private var previousindex = 0
    @State private var currentindex = 0
    @State private var idToScrol = 0
    let gender : [genderModel] = [
        genderModel.init(name: "Male_", id: 1),
        genderModel.init(name: "FeMale_", id: 2),
        genderModel.init(name: "Any", id: 0)
        
    ]
    var body: some View {
        ZStack{
            VStack{
                AppBarView(Title: "Choose_Speciality".localized(language),withbackButton: true)
                    .frame(height:70)
                    .padding(.top,-20)
                ScrollView( showsIndicators: false){
                    AsyncImage(url: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR05Cf6YGBs9SAvvEwW22wHVjeLTm9HmVJEWd0KjyiSySHuLDQCH5VVc0wvxtHCJvVOKSY&usqp=CAU" )){image in
                        image.resizable()
                    } placeholder: {
                        Image("logo")
                            .resizable()
                    }
                    .foregroundColor(.black)
                    .frame( height: 115)
                    .cornerRadius(8)
                    .scaledToFit()
                    Group{
                        SearchBar(PlaceHolder:"Search_a_doctor...".localized(language),text: $searchDoc.DoctorName, isSearch: $isSearch){
//                            getAllDoctors()
                        }
                        .AddBlueBorder(linewidth:1.3)
                        .padding(.horizontal)
                        HStack {
                            Text("SpecialitiesـSubTitle".localized(language))
                                .foregroundColor(.salamtackBlue)
                                .font(.salamtakBold(of: 18))
                            Spacer()
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        HStack {
                            Button(action:{
                                // Scroll to previous item
                                //                                                  if currentPage > 0 {
                                //                                                      currentPage -= 1
                                //                                                  }
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
                                    
                                    LazyHStack(spacing:15) {
                                        ForEach(0..<(specialityvm.publishedSpecialistModel.count), id:\.self){ speciality in
                                            Button(action: {
                                                searchDoc.SpecialistId = specialityvm.publishedSpecialistModel[speciality].id ?? 1212113115
                                                environments.SpecialityId = specialityvm.publishedSpecialistModel[speciality].id ?? 1212113115
                                                searchDoc.SpecialistName = specialityvm.publishedSpecialistModel[speciality].Name ?? ""
                                                selectedSpecialityId = specialityvm.publishedSpecialistModel[speciality].id ?? 1212113115
                                                selectedSpecialityName = specialityvm.publishedSpecialistModel[speciality].Name ?? ""
                                                //                                        gotocity = true
                                            }, label: {
                                                SpecialityBuBody(speciality:specialityvm.publishedSpecialistModel[speciality] ,forgroundColor: searchDoc.SpecialistId == specialityvm.publishedSpecialistModel[speciality].id ?? 1212113115 ? .white:.salamtackBlue ,backgroundColor: searchDoc.SpecialistId == specialityvm.publishedSpecialistModel[speciality].id ?? 1212113115 ? .salamtackBlue : .clear )
                                                    .aspectRatio( contentMode: .fill)
                                                    .frame(width: (UIScreen.main.bounds.width)/4,height:100)
                                            })
                                                .id(speciality)
                                                .cornerRadius(8)
                                                .shadow(color: .black.opacity(0.099), radius: 5)
                                                .onAppear(perform: {
                                                    currentindex = speciality
                                                    print("appear: \(specialityvm.publishedSpecialistModel[speciality].Name ?? "")")
                                                })
                                                .onDisappear(perform: {
                                                    previousindex = speciality
                                                    print("disaprear: \(specialityvm.publishedSpecialistModel[speciality].Name ?? "")")
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
                                // Scroll to next item
                                //                                                 if currentPage < specialityvm.publishedSpecialistModel.count - 1 {
                                //                                                     currentPage += 1
                                //                                                 }
                                if currentindex < specialityvm.publishedSpecialistModel.count {
                                    idToScrol = currentindex +  2
                                }else{
                                    //                                    idToScrol = 0
                                }
                            }){
                                Image(systemName: "arrowtriangle.right.fill")
                            }.buttonStyle(.plain)
                        }
                                                
                        HStack{
                            Text("SubSpeciality_".localized(language))
                            InputTextField(text: .constant(searchDoc.FilterSubSpecialistName.joined(separator: ", ") ),iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "",isactive: false){
                                environments.SubSpecialityId = searchDoc.SubSpecialistId ?? []
                                environments.SubSpecialityName = searchDoc.SubSpecialistName ?? []
                                environments.ShowSubSpeciality = true
                            }
                        }
                        .frame(width:(UIScreen.main.bounds.width/1) - 40)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.top)
                        .font(.salamtakRegular(of: 15))
                        .foregroundColor(.salamtackBlue)
                        
                        HStack{
                            Text("City_".localized(language))
                            InputTextField(text: .constant(searchDoc.FilterCityName ?? ""),iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "",isactive: false){
                                environments.CountryId = 1
                                environments.CityId = searchDoc.CityId ?? 0
                                environments.cityName = searchDoc.CityName ?? ""
                                environments.ShowCity = true
                            }
                            
                            Spacer()
                            Text("Area_".localized(language))
                            InputTextField(text: .constant(searchDoc.FilterAreaName ?? ""),iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "",isactive: false){
                                environments.AreaId = searchDoc.AreaId ?? 0
                                environments.areaName = searchDoc.AreaName ?? ""
                                environments.ShowArea = true
                            }
                        }.padding(.top)
                            .font(.salamtakRegular(of: 15))
                            .foregroundColor(.salamtackBlue)
                        
//                        CustomView(minValue: $searchDoc.FilterMinFees, maxValue: $searchDoc.FilterMinFees, range: Int(FeesVM.publishedMinMaxFee?.MaximumFees ?? 0) - Int(FeesVM.publishedMinMaxFee?.MinimumFees ?? 0), totalwidth: UIScreen.main.bounds.width - 75)
                        
                        FeesFilterView(minValue: $searchDoc.FilterMinFees, maxValue: $searchDoc.FilterMaxFees,range: Int(FeesVM.publishedMinMaxFee?.MaximumFees ?? 0) - Int(FeesVM.publishedMinMaxFee?.MinimumFees ?? 0),totalwidth: UIScreen.main.bounds.width - 75)
                        
//                        RangeSliderView(viewModel: .init(sliderPosition: 20...800,sliderBounds: 0...1000),sliderPositionChanged: { _ in })
//                            .padding(.horizontal)
//                            .frame(width:UIScreen.main.bounds.width-40)
                        HStack(){
                            Text("Gender_".localized(language))
                            ForEach(gender,id:\.self){gender in
                                
                                Button(action: {
                                    searchDoc.GenderId = gender.GenderId
                                }){
                                    HStack(spacing:2) {
                                        Text(gender.GenderName.localized(language))
                                        Image(systemName: searchDoc.GenderId == gender.GenderId ? "circle.fill":"circle")
                                            .foregroundColor(.salamtackWelcome)
                                            .font(Font.system(size: 20))
                                    }
                                }.buttonStyle(.plain)
                                    .padding(.horizontal)
                            }
                        }
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.top)
                        .font(.salamtakRegular(of: 15))
                        .foregroundColor(.salamtackBlue)
                        
                        HStack{
                            Text("seniorityLevel_".localized(language))
                            InputTextField(text: .constant(searchDoc.FilterSeniortyLevelName ?? ""),iconName: .DropList(icon: "newdown") , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "",isactive: false){
                                environments.SeniorityId = searchDoc.SeniortyLevelId ?? 0
                                environments.SeniorityName = searchDoc.FilterSeniortyLevelName ?? ""
                                environments.ShowSeniority = true
                            }
                        }
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.top)
                        .font(.salamtakRegular(of: 15))
                        .foregroundColor(.salamtackBlue)
                        
                        
                        Button(action: {
                            //search
                            searchDoc.FetchDoctors(operation: .fetchDoctors)
                            gotoSearchdoctor = true
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
                    }
                }
                .background(Color.clear)
                .padding([.horizontal])
                .frame(width: UIScreen.main.bounds.width)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $specialityvm.isLoading)
            
            //        //  go to clinic info
            NavigationLink(destination:CityView(CountryId:1, SelectedSpeciality:$selectedSpecialityId, SelectedSpecialityName: $selectedSpecialityName, extypeid: $selectedTypeId)
                            .environmentObject(searchDoc)
                            .environmentObject(environments)
                            .navigationBarHidden(true),isActive: $gotocity) {
            }
            
            //  go to clinic info
            NavigationLink(destination:ViewSearchDoc()
                            .environmentObject(searchDoc)
                            .environmentObject(environments)
                            .navigationBarHidden(true),isActive: $gotoSearchdoctor) {
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(navController.popToRoot, perform: {newval in
            gotocity = newval
        })
        
        .onAppear(perform: {
            currentindex = 0
            previousindex = 0
            idToScrol = 0
            environments.SpecialityId = searchDoc.SpecialistId
            environments.SubSpecialityId = searchDoc.SubSpecialistId ?? []
            environments.CityId = searchDoc.FilterCityId ?? 0
            environments.AreaId = searchDoc.FilterAreaId ?? 0
            environments.SeniorityId = searchDoc.FilterSeniortyLevelId ?? 0
        })
        
        .background(
            newBackImage(backgroundcolor: .white, imageName:.image2)
        )
        
        .alert(isPresented: $specialityvm.isAlert, content: {
            Alert(title: Text(specialityvm.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                specialityvm.isAlert = false
            }))
        })
        
        .onChange(of: environments.SpecialityId, perform: { newval in
            searchDoc.SpecialistId = newval
        })
        .onChange(of: environments.SubSpecialityId, perform: { newval in
            searchDoc.FilterSubSpecialistId = newval
            searchDoc.FilterSubSpecialistName = environments.SubSpecialityName
        })
        .onChange(of: environments.CityId, perform: { newval in
            searchDoc.FilterCityId = newval
            searchDoc.FilterCityName = environments.cityName
        })
        .onChange(of: environments.AreaId, perform: { newval in
            searchDoc.FilterAreaId = newval
            searchDoc.FilterAreaName = environments.areaName
        })
        .onChange(of: environments.SeniorityId, perform: { newval in
            searchDoc.FilterSeniortyLevelId = newval
            searchDoc.FilterSeniortyLevelName = environments.SeniorityName
        })

        
    }
}

struct SpecialityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SpecialityView (selectedTypeId: .constant(54545454), selectedSpecialityId: 1212115)
                .environmentObject(EnvironmentsVM())
                .environmentObject(VMSearchDoc())
        }.navigationBarHidden(true).previewInterfaceOrientation(.portrait)
    }
}


struct genderModel:Hashable{
    var GenderName : String = ""
    var GenderId : Int = 0
    //    let GenderName : String = ""
    
    init(name:String,id:Int){
        self.GenderName = name
        self.GenderId = id
    }
}

