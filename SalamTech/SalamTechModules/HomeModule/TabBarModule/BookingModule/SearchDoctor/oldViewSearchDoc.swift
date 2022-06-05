////
////  ViewSearchDoc.swift
////  SalamTech
////
////  Created by wecancity on 05/04/2022.
////
//
//import SwiftUI
//import ImageViewerRemote
//
//
//struct ViewSearchDoc: View {
//    @StateObject var medicalType = ViewModelExaminationTypeId()
//    @StateObject var searchDoc = VMSearchDoc()
//    @Binding var ExTpe:Int
//    @Binding var SpecialistId:Int
//    @Binding var CityId:Int
//    @Binding var AreaId:Int
//
//    @State  var isSearch = false
//    @State  var searchTxt = ""
//
//    @State private var image = UIImage()
//    @State var loginAgain = false
//    var language = LocalizationService.shared.language
//    //    var CountryId : Int
//    @State var index = 1
//
//    @State var gotodoctorDetails = false
//    @State var selectedCityId = 0
//    @State var imgs : [Img] = []
//    @State var SelectedDoctor = Doc()
//
//
//    init(ExTpe: Binding<Int>,SpecialistId: Binding<Int> ,CityId: Binding<Int>,AreaId: Binding<Int> ) {
//        UITableView.appearance().showsVerticalScrollIndicator = false
//        self._ExTpe = ExTpe
//        self._SpecialistId = SpecialistId
//        self._CityId = CityId
//        self._AreaId = AreaId
//    }
//
//    @State var showFilter = false
//    @State var FilterTag = "Filter"
//    @StateObject var seniorityVM = ViewModelSeniorityLevel()
//    @StateObject var specialityvm = ViewModelSpecialist()
//    @StateObject var SubSpecialityVM = ViewModelSubSpecialist()
//    @StateObject var CitiesVM = ViewModelGetCities()
//    @StateObject var AreasVM = ViewModelGetAreas()
//
//    @State var selectedSeniorityLvlName :String?
//    @State var selectedSeniorityLvlId :Int?
//    @State var SenbuttonSelected: Int?
//
//    @State var selectedSpecLvlName :String?
//    @State var selectedSpecLvlId :Int?
//    @State var SpecbuttonSelected: Int?
//
//    @State var selectedSubSpecLvlNames : [String] = []
//    @State var selectedSubSpecLvlIds : [Int] = []
//
//    @State var minFee:CGFloat  = 0
//    @State var maxFee:CGFloat  = 0
//
////    @State var selectedFee :Double?
//    @State var selectedFee :Float = 0
//
//    @State var selectedFilterCityName :String?
//    @State var selectedFilterCityId :Int?
//    @State var CitybuttonSelected: Int?
//
//    @State var selectedFilterAreaName :String?
//    @State var selectedFilterAreaId :Int?
//    @State var AreabuttonSelected: Int?
//    @State var ispreviewImage=false
//    @State var previewImageurl=""
//
//
//    var body: some View {
//        ZStack{
//            VStack{
//
//                Spacer().frame(height:100)
//                ZStack {
//                    Image("WhiteCurve")
//                        .resizable()
//                        .frame(width: UIScreen.main.bounds.width, height: 120)
//                        .padding(.top,-20)
//
//                    SearchBar(PlaceHolder:"Search_a_doctor...".localized(language),text: $searchTxt, isSearch: $isSearch){
//                        getAllDoctors()
//                    }
//                    .shadow(color: .black.opacity(0.2), radius: 15)
//                }
//
//
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack( spacing: 10) {
//                        // Swipe TabView
//                        ForEach(medicalType.publishedModelExaminationTypeId, id:\.self){ type in
//
//                            if type.id==0{ }else{
//
//                                Button(action: {
//                                    withAnimation(.default) {
//                                        self.index = type.id ?? 1
//
//                                    }
//
//                                }, label: {
//                                    HStack(alignment: .center){
//                                        Text(type.Name ?? "")
//                                            .font(Font.SalamtechFonts.Reg14)
//                                            .foregroundColor(self.index == type.id ? Color("blueColor") : Color("lightGray"))
//
//                                    }
//                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                    .frame(minWidth: 100, maxWidth: 350)
//                                        .padding(10)
//                                        .padding(.bottom,1)
//                                        .background( Color(self.index == type.id ? "tabText" : "lightGray").opacity(self.index == type.id ? 1 : 0.3)
//                                                        .cornerRadius(5))
//                                        .clipShape(Rectangle())
//
//
//                                })
//
//
//
//                            }
//                        }
//                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                    //                        .padding(.top,5)
//                        .padding(.horizontal)
//                }
//
//
//                List( ){
//
//                    if searchDoc.noDoctors == true{
//                        Text("Sorry,\nNo_Doctors_Found_🤷‍♂️".localized(language))
//                            .multilineTextAlignment(.center)
//                        .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
//
//                    }
//
//                    ForEach(searchDoc.publishedModelSearchDoc , id:\.self){ Doctor in
//                        ViewDocCell(Doctor: Doctor,searchDoc: searchDoc,gotodoctorDetails:$gotodoctorDetails,SelectedDoctor:$SelectedDoctor , ispreviewImage:$ispreviewImage, previewImageurl:$previewImageurl)
//                    }
//                        ZStack{}
//                        .frame( maxHeight: 2)
//                        .foregroundColor(.black)
//                        .onAppear(perform: {
//                            if searchDoc.publishedModelSearchDoc.count > searchDoc.SkipCount{
//                            searchDoc.SkipCount += searchDoc.MaxResultCount
//                            searchDoc.FetchMoreDoctors()
//                            }
//                        })
//
//
//                }.refreshable(action: {
//                    getAllDoctors()
//                })
//                    .listStyle(.plain)
//                    .padding(.vertical,0)
//
//                    .edgesIgnoringSafeArea(.bottom)
//            }
//
//
//                .blur(radius: showFilter==true ? 9:0)
//
//            .frame(width: UIScreen.main.bounds.width)
//            .edgesIgnoringSafeArea(.vertical)
//            .background(Color("CLVBG"))
//
//            VStack{
//                AppBarView(Title: "Search_a_Doctor".localized(language))
//                //                    .navigationBarItems(leading: BackButtonView())
//                    .navigationBarBackButtonHidden(true)
//                Spacer()
//            }
//            .edgesIgnoringSafeArea(.vertical)
//
//
//
//            if showFilter == true {
//                switch FilterTag{
//
//                case "Title":
//                    CustomSheet(IsPresented: $showFilter, content: {
//                        //                    HStack {
//                        Text("Title".localized(language))
//                            .font(.system(size: 18))
//                            .fontWeight(.bold)
//                        //                    }
//                        ScrollView {
//                            ForEach(0..<seniorityVM.publishedSeniorityLevelModel.count, id:\.self) { button in
//                                HStack {
//                                    Spacer().frame(width:30)
//                                    Button(action: {
//                                        self.SenbuttonSelected = button
//                                        print("SelectedID is \(self.seniorityVM.publishedSeniorityLevelModel[button].id ?? 0)")
//
//                                        self.selectedSeniorityLvlId = self.seniorityVM.publishedSeniorityLevelModel[button].id ?? 0
//                                        self.selectedSeniorityLvlName = self.seniorityVM.publishedSeniorityLevelModel[button].Name ?? ""
////                                        doctorCreatedVM.SeniorityLevelId = selectedSeniorityId
////                                        doctorCreatedVM.SeniorityName = selectedSeniorityName
//                                    }, label: {
//                                        HStack{
//                                            Image(systemName:  self.SenbuttonSelected == button ? "checkmark.circle.fill" :"circle" )
//                                                .font(.system(size: 20))
//                                                .foregroundColor(self.SenbuttonSelected == button ? Color("blueColor") : Color("lightGray"))
//                                            Text(self.seniorityVM.publishedSeniorityLevelModel[button].Name ?? "")  .padding()
//                                                .foregroundColor(self.SenbuttonSelected == button ? Color("blueColor") : Color("lightGray"))
//                                            Spacer()
//
//
//                                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                                    })
//
////                                    SeniorityBtn(seniorityLvl: seniorityVM.publishedSeniorityLevelModel[button], selectedSenLvlName: $selectedSenLvlName, selectedSenLvlId: $selectedSenLvlId)
//                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                            }
//                        }
//
//
//                            Button(action: {
//                                // add review
//                                print("Confirm Title")
//                                FilterTag = "Filter"
////                                showFilter.toggle()
//                            }, label: {
//                                HStack {
//                                    Text("Confirm".localized(language))
//                                        .fontWeight(.semibold)
//                                        .font(.title3)
//                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color("blueColor"))
//                                .cornerRadius(12)
//                                .padding(.horizontal, 12)
//                            })
//
//                        .frame( height: 60)
//                        .padding(.horizontal)
//                        .padding(.bottom,10)
//
//                    })
//                        .onAppear(perform: {
//                        seniorityVM.startFetchSenioritylevel()
//                    })
//
//                case "Speciality":
//                    CustomSheet(IsPresented: $showFilter, content: {
//                        //                    HStack {
//                        Text("Speciality".localized(language))
//                            .font(.system(size: 18))
//                            .fontWeight(.bold)
//                        //                    }
//                        ScrollView {
//                            ForEach(0..<(specialityvm.publishedSpecialistModel?.count ?? 0), id:\.self) { button in
//                                HStack {
//                                    Spacer().frame(width:30)
//                                    Button(action: {
//                                        self.SpecbuttonSelected = button
//                                        print("SelectedID is \(self.specialityvm.publishedSpecialistModel?[button].id ?? 0)")
//
//                                        self.selectedSpecLvlId = self.specialityvm.publishedSpecialistModel?[button].id ?? 0
//                                        self.selectedSpecLvlName = self.specialityvm.publishedSpecialistModel?[button].Name ?? ""
//
//                                    }, label: {
//                                        HStack{
//                                            Image(systemName:  self.SpecbuttonSelected == button ? "checkmark.circle.fill" :"circle" )
//                                                .font(.system(size: 20))
//                                                .foregroundColor(self.SpecbuttonSelected == button ? Color("blueColor") : Color("lightGray"))
//                                            Text(self.specialityvm.publishedSpecialistModel?[button].Name ?? "")  .padding()
//                                                .foregroundColor(self.SpecbuttonSelected == button ? Color("blueColor") : Color("lightGray"))
//                                            Spacer()
//
//
//                                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                                    })
//
//                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                            }
//                        }
//
//
//                            Button(action: {
//                                // add review
//                                print("Confirm Title")
//                                FilterTag = "Filter"
////                                showFilter.toggle()
//                            }, label: {
//                                HStack {
//                                    Text("Confirm".localized(language))
//                                        .fontWeight(.semibold)
//                                        .font(.title3)
//                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color("blueColor"))
//                                .cornerRadius(12)
//                                .padding(.horizontal, 12)
//                            })
//
//                        .frame( height: 60)
//                        .padding(.horizontal)
//                        .padding(.bottom,10)
//
//                    })
//                        .onAppear(perform: {
//                        specialityvm.startFetchSpecialist()
//                    })
//
//                case "SubSpeciality":
//                    CustomSheet(IsPresented: $showFilter, content: {
//                        //                    HStack {
//                        Text("Sub_Specialities".localized(language))
//                            .font(.system(size: 18))
//                            .fontWeight(.bold)
//                        //                    }
//                        ScrollView {
//                            ForEach(0..<SubSpecialityVM.publishedSubSpecialistModel.count, id:\.self) { button in
//                                HStack {
//                                    Spacer().frame(width:30)
////
//
//                        SeniorityBtn(seniorityLvl: SubSpecialityVM.publishedSubSpecialistModel[button], selectedSenLvlName: $selectedSubSpecLvlNames, selectedSenLvlId: $selectedSubSpecLvlIds)
//
//
//                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                            }
//                        }
//
//
//                            Button(action: {
//                                // add review
//                                print("Confirm Title")
//                                FilterTag = "Filter"
////                                showFilter.toggle()
//                            }, label: {
//                                HStack {
//                                    Text("Confirm".localized(language))
//                                        .fontWeight(.semibold)
//                                        .font(.title3)
//                                }
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color("blueColor"))
//                                .cornerRadius(12)
//                                .padding(.horizontal, 12)
//                            })
//
//                        .frame( height: 60)
//                        .padding(.horizontal)
//                        .padding(.bottom,10)
//
//                    })
//                        .onAppear(perform: {
//                            SubSpecialityVM.startFetchSubSpecialist(id: selectedSpecLvlId ?? SpecialistId)
//                    })
//
//                case "City":
//                    CustomSheet(IsPresented: $showFilter, content: {
//                        //                    HStack {
//                        Text("City".localized(language))
//                            .font(.system(size: 18))
//                            .fontWeight(.bold)
//                        //                    }
//                        ScrollView {
//                            ForEach(0..<CitiesVM.publishedCityModel.count, id:\.self) { button in
//                                HStack {
//                                    Spacer().frame(width:30)
//                                    Button(action: {
//                                        self.CitybuttonSelected = button
//                                        print("SelectedID is \(self.CitiesVM.publishedCityModel[button].Id ?? 0)")
//
//                                        self.selectedFilterCityId = self.CitiesVM.publishedCityModel[button].Id ?? 0
//                                        self.selectedFilterCityName = self.CitiesVM.publishedCityModel[button].Name ?? ""
//
//                                    }, label: {
//                                        HStack{
//                                            Image(systemName:  self.CitybuttonSelected == button ? "checkmark.circle.fill" :"circle" )
//                                                .font(.system(size: 20))
//                                                .foregroundColor(self.CitybuttonSelected == button ? Color("blueColor") : Color("lightGray"))
//                                            Text(self.CitiesVM.publishedCityModel[button].Name ?? "")  .padding()
//                                                .foregroundColor(self.CitybuttonSelected == button ? Color("blueColor") : Color("lightGray"))
//                                            Spacer()
//
//
//                                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                    })
//
//                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                            }
//                        }
//
//
//                            Button(action: {
//                                // add review
//                                print("Confirm Title")
//                                FilterTag = "Filter"
////                                showFilter.toggle()
//                            }, label: {
//                                HStack {
//                                    Text("Confirm".localized(language))
//                                        .fontWeight(.semibold)
//                                        .font(.title3)
//                                }
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color("blueColor"))
//                                .cornerRadius(12)
//                                .padding(.horizontal, 12)
//                            })
//
//                        .frame( height: 60)
//                        .padding(.horizontal)
//                        .padding(.bottom,10)
//
//                    })
//                        .onAppear(perform: {
//                            CitiesVM.CountryId = 1
//                            CitiesVM.startFetchCities()
//                        })
//
//                case "Area":
//                    CustomSheet(IsPresented: $showFilter, content: {
//                        //                    HStack {
//                        Text("Area".localized(language))
//                            .font(.system(size: 18))
//                            .fontWeight(.bold)
//                        //                    }
//                        ScrollView {
//                            ForEach(0..<AreasVM.publishedAreaModel.count, id:\.self) { button in
//                                HStack {
//                                    Spacer().frame(width:30)
//                                    Button(action: {
//                                        self.AreabuttonSelected = button
//                                        print("SelectedID is \(self.AreasVM.publishedAreaModel[button].id ?? 0)")
//
//                                        self.selectedFilterAreaId = self.AreasVM.publishedAreaModel[button].id ?? 0
//                                        self.selectedFilterAreaName = self.AreasVM.publishedAreaModel[button].Name ?? ""
//
//                                    }, label: {
//                                        HStack{
//                                            Image(systemName:  self.AreabuttonSelected == button ? "checkmark.circle.fill" :"circle" )
//                                                .font(.system(size: 20))
//                                                .foregroundColor(self.AreabuttonSelected == button ? Color("blueColor") : Color("lightGray"))
//                                            Text(self.AreasVM.publishedAreaModel[button].Name ?? "")  .padding()
//                                                .foregroundColor(self.AreabuttonSelected == button ? Color("blueColor") : Color("lightGray"))
//                                            Spacer()
//
//
//                                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                    })
//
//                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                            }
//                        }
//
//
//                            Button(action: {
//                                // add review
//                                print("Confirm Title")
//                                FilterTag = "Filter"
////                                showFilter.toggle()
//                            }, label: {
//                                HStack {
//                                    Text("Confirm".localized(language))
//                                        .fontWeight(.semibold)
//                                        .font(.title3)
//                                }
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color("blueColor"))
//                                .cornerRadius(12)
//                                .padding(.horizontal, 12)
//                            })
//
//                        .frame( height: 60)
//                        .padding(.horizontal)
//                        .padding(.bottom,10)
//
//                    })
//                        .onAppear(perform: {
//                            AreasVM.cityId = selectedFilterCityId ?? CityId
//                            AreasVM.startFetchAreas()
//                        })
//
//                case "Fees":
//                    CustomSheet(IsPresented: $showFilter, content: {
//                        Text("Examination_Fee".localized(language))
//                            .font(.system(size: 18))
//                            .fontWeight(.bold)
//
//                        VStack{
//                        HStack{
//                            FeesFilterTextField1(text: String( searchDoc.publishedModelMinMaxFee?.MinimumFees ?? 0), title: "Minimum".localized(language))
//                                .frame(width:(UIScreen.main.bounds.width - 50)/2)
//                                .disabled(true)
//                            FeesFilterTextField1(text:  String(Int( Float(searchDoc.publishedModelMinMaxFee?.MinimumFees ?? 0) + selectedFee)) , title: "Maximum".localized(language))
//                                .frame(width:(UIScreen.main.bounds.width - 50)/2)
//                                .disabled(true)
//                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
////                            SliderView(minFee: $minFee, maxFee: $maxFee, range: Int(maxFee-minFee), percentage: $floselectedFee)
//                            CustomView(percentage: $selectedFee, range: Int( searchDoc.publishedModelMinMaxFee?.MaximumFees ?? 0) - Int(  0) )
//
//                        }.padding()
//
//                            Button(action: {
//                                // add review
//                                print("Confirm Title")
//                                FilterTag = "Filter"
//                            }, label: {
//                                HStack {
//                                    Text("Confirm".localized(language))
//                                        .fontWeight(.semibold)
//                                        .font(.title3)
//                                }
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color("blueColor"))
//                                .cornerRadius(12)
//                                .padding(.horizontal, 12)
//                            })
//
//                        .frame( height: 60)
//                        .padding(.horizontal)
//                        .padding(.bottom,10)
//
//                    })
//
//                default:
//                    CustomSheet(IsPresented: $showFilter, content: {
//                        Text("Search_Filter".localized(language))
//                            .font(.system(size: 18))
//                            .fontWeight(.bold)
//                        ScrollView(){
//
//
//                            Button(action: {
//                                print("sel Title")
//                                FilterTag = "Title"
//
//                            }, label: {
//                                HStack{
//
//                                    Image("FilterTitle")
//                                    VStack(alignment:.leading){
//                                        Text("Title".localized(language))
//                                            .font(.system(size: 16))
//                                            .fontWeight(.semibold)
//                                            .foregroundColor(.black)
//
//                                        Text(selectedSeniorityLvlName ?? "")
//                                            .font(.system(size: 12))
//                                            .fontWeight(.medium)
//                                            .foregroundColor(.gray)
//                                    }
//
//                                    Spacer()
//
//                                    CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
//
//                                }.padding()
//                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                            })
//                                .listRowSeparator(.hidden)
//
//                            Button(action: {
//                                print("sel spec")
//                                FilterTag = "Speciality"
//
//                            }, label: {
//                                HStack{
//
//                                    Image("FilterSpec")
//                                    VStack(alignment:.leading){
//                                        Text("Speciality".localized(language))
//                                            .font(.system(size: 16))
//                                            .fontWeight(.semibold)
//                                            .foregroundColor(.black)
//                                        Text(selectedSpecLvlName ?? "")
//                                            .font(.system(size: 12))
//                                            .fontWeight(.medium)
//                                            .foregroundColor(.gray)
//                                    }
//
//                                    Spacer()
//
//                                    CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
//
//                                }.padding()
//                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                            })
//
//
//                            Button(action: {
//                                FilterTag = "SubSpeciality"
//                            }, label: {
//                                HStack{
//
//                                    Image("FilterSpec")
//                                    VStack(alignment:.leading){
//                                        Text("Sub_Specialities".localized(language))
//                                            .font(.system(size: 16))
//                                            .fontWeight(.semibold)
//                                            .foregroundColor(.black)
//                                        Text(selectedSubSpecLvlNames.joined(separator: ", "))
//                                            .font(.system(size: 12))
//                                            .fontWeight(.medium)
//                                            .foregroundColor(.gray)
//                                    }
//
//                                    Spacer()
//
//                                    CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
//
//                                }.padding()
//                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                            })
////                                .buttonStyle(.plain)
//
//
////                            Button(action: {
////                                FilterTag = "Gender"
////                            }, label: {
////                                HStack{
////
////                                    Image("FilterPerson")
////                                    VStack(alignment:.leading){
////                                        Text("Gender".localized(language))
////                                            .font(.system(size: 16))
////                                            .fontWeight(.semibold)
////                                            .foregroundColor(.black)
////                                        Text("Select Gender")
////                                            .font(.system(size: 12))
////                                            .fontWeight(.medium)
////                                            .foregroundColor(.gray)
////                                    }
////
////                                    Spacer()
////
////                                    CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
////
////                                }.padding()
////                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
////
////                            })
////                                .buttonStyle(.plain)
//
//
//                            Button(action: {
//                                FilterTag = "City"
//                            }, label: {
//                                HStack{
//
//                                    Image("FilterLocation")
//                                    VStack(alignment:.leading){
//                                        Text("City".localized(language))
//                                            .font(.system(size: 16))
//                                            .fontWeight(.semibold)
//                                            .foregroundColor(.black)
//                                        Text(selectedFilterCityName ?? "")
//                                            .font(.system(size: 12))
//                                            .fontWeight(.medium)
//                                            .foregroundColor(.gray)
//                                    }
//
//                                    Spacer()
//
//                                    CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
//
//                                }.padding()
//                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                            })
//                            Button(action: {
//                                FilterTag = "Area"
//                            }, label: {
//                                HStack{
//
//                                    Image("FilterLocation")
//                                    VStack(alignment:.leading){
//                                        Text("Area".localized(language))
//                                            .font(.system(size: 16))
//                                            .fontWeight(.semibold)
//                                            .foregroundColor(.black)
//                                        Text(selectedFilterAreaName ?? "")
//                                            .font(.system(size: 12))
//                                            .fontWeight(.medium)
//                                            .foregroundColor(.gray)
//                                    }
//
//                                    Spacer()
//
//                                    CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
//
//                                }.padding()
//                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                            })
//
//                            Button(action: {
//                                FilterTag = "Fees"
//                            }, label: {
//                                HStack{
//
//                                    Image("FilterFees")
//                                    VStack(alignment:.leading){
//                                        Text("Examination_Fee".localized(language))
//                                            .font(.system(size: 16))
//                                            .fontWeight(.semibold)
//                                            .foregroundColor(.black)
//                                        Text("From".localized(language) + " \(String( searchDoc.publishedModelMinMaxFee?.MinimumFees ?? 0))" + "to".localized(language) + " \(String( searchDoc.publishedModelMinMaxFee?.MaximumFees ?? 0))"+"EGP".localized(language))
//                                            .font(.system(size: 12))
//                                            .fontWeight(.medium)
//                                            .foregroundColor(.gray)
//                                    }
//
//                                    Spacer()
//
//                                    CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
//
//                                }.padding()
//                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                            })
//
//
//                        }
//                        .listStyle(.plain)
//
//                        HStack{
//
//                            Button( action: {
//
//                                print("Reset and Hide")
//                                resetFilter()
//                                showFilter.toggle()
//                            }, label: {
//                                Text("Reset".localized(language))
//                                    .font(.system(size: 15))
//                                    .foregroundColor(.black.opacity(0.5))
//                                //            .padding(.bottom,-20)
//
//                            })
//
//                                .padding(.leading)
//                            Button(action: {
//                                // add review
//                                print("Apply Filter and Hide")
//
//                               applyFilter()
//                                showFilter.toggle()
//                            }, label: {
//                                HStack {
//                                    Text("Apply_Filter".localized(language))
//                                        .fontWeight(.semibold)
//                                        .font(.title3)
//                                }
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color("blueColor"))
//                                .cornerRadius(12)
//                                .padding(.horizontal, 30)
//                            })
//                        }
//                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//                        .frame( height: 60)
//                        .padding(.horizontal)
//                        .padding(.bottom,10)
//
//
//
//                    })
//
//                }
//            }
//
//
//            // showing loading indicator
//            ActivityIndicatorView(isPresented: $searchDoc.isLoading)
//
//
//
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//
//        .navigationBarHidden(ispreviewImage)
//
//        .onAppear(perform: {
//            medicalType.GetExaminationTypeId()
//
//            searchDoc.MaxResultCount = 10
//            index =  ExTpe
//            searchDoc.MedicalExaminationTypeId = ExTpe
//            searchDoc.SpecialistId = SpecialistId
//            searchDoc.CityId = CityId
//            searchDoc.AreaId = AreaId
//            getAllDoctors()
//
//            self.minFee = CGFloat(searchDoc.publishedModelMinMaxFee?.MinimumFees ?? 0)
//            self.maxFee = CGFloat(searchDoc.publishedModelMinMaxFee?.MaximumFees ?? 0)
//        })
//        .onChange(of: index){newval in
//            self.ExTpe = newval
//            searchDoc.isLoading = true
//
//            searchDoc.MedicalExaminationTypeId = newval
//            searchDoc.publishedModelSearchDoc.removeAll()
//            getAllDoctors()
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                if !showFilter && !ispreviewImage{
//                    BackButtonView()
//                }
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                if  !ispreviewImage{
//                FilterButtonView(imagename: "filter"){
//                    showFilter.toggle()
//                }
//                }
//            }
//        }
//        .overlay(content: {
//            ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true)
//        })
//
//
//        //        }
//        //  go to clinic info
//        NavigationLink(destination:ViewDocDetails(Doctor:SelectedDoctor, ExType: $ExTpe),isActive: $gotodoctorDetails) {
//        }
//
//
//        // Alert with no internet connection
//            .alert(isPresented: $searchDoc.isNetworkError, content: {
//                Alert(title: Text("Check_Your_Internet_Connection".localized(language)), message: nil, dismissButton: .cancel())
//        })
//
//
//    }
//
//
//
//    //MARK: --- Functions ----
//    func getAllDoctors(){
//        searchDoc.isLoading = true
//
//        searchDoc.DoctorName = searchTxt
//        searchDoc.SkipCount = 0
//        searchDoc.FetchDoctors()
//    }
//
//    func applyFilter(){
//
//        searchDoc.FilterSeniortyLevelId = selectedSeniorityLvlId
//        searchDoc.FilterSpecialistId = selectedSpecLvlId ?? 115151
//        searchDoc.FilterSubSpecialistId = selectedSubSpecLvlIds
//        searchDoc.FilterCityId = selectedFilterCityId
//        searchDoc.FilterAreaId = selectedFilterAreaId
//        searchDoc.FilterFees = selectedFee > 0 ?  Int(searchDoc.publishedModelMinMaxFee?.MinimumFees ?? 0) + Int(selectedFee):0
//        getAllDoctors()
//    }
//
//    func resetFilter(){
//        selectedSeniorityLvlId = 0
//        selectedSpecLvlId = 0
//        selectedSubSpecLvlIds = []
//        selectedFilterCityId = 0
//        selectedFilterAreaId = 0
//        selectedFee  = 0
//        selectedSeniorityLvlId = 0
//        selectedSpecLvlId = 0
//        selectedSubSpecLvlIds = []
//        selectedFilterCityId = 0
//        selectedFilterAreaId = 0
//        getAllDoctors()
//    }
//
//}
//
//struct ViewSearchDoc_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            ViewSearchDoc(ExTpe: .constant(2), SpecialistId: .constant(2), CityId: .constant(2), AreaId: .constant(2))
//        }.navigationBarHidden(true)
//    }
//}
//
//
//extension UIApplication {
//    func dismissKeyboard() {
//        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//
//
//extension String: Identifiable {
//    public typealias ID = Int
//    public var id: Int {
//        return hash
//    }
//}
//
//
//
//
//
//
//
//
//
//
