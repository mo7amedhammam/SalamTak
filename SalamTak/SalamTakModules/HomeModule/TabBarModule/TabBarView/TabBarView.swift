//
//  TabBarGenericView.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 2/13/22.
//

import SwiftUI


struct TabBarView: View {
    @AppStorage("languageKey")
    var language = LocalizationService.shared.language

    @StateObject var TabBarVM = tabbar()
    @State var selectedTab = "TabBar_home"
    @StateObject var scheduleVM = ViewModelGetAppointmentInfo()
    @StateObject  var infoProfileVM = PatientInfoViewModel()
    @StateObject  var medicalProfileVM = PatientMedicalInfoViewModel()
    @StateObject var AdsVM = ViewModelSlidingAds()

    @StateObject var environments = EnvironmentsVM()

    @State var MoreTabIndex = 0
    @State var AppointmentsTabIndex = 0
    @State var promotionTabIndex = 0

    @State var showingList:Bool? = false
    @State var DesiredAppointmentItem = 0

    var body: some View {
        ZStack{
                    VStack(spacing: 0){
                        NavigationView{
                        if selectedTab == TabBarVM.tabs[0] {
                                ServicesView()
                                .environmentObject(AdsVM)
                                .environmentObject(environments)
                        } else if selectedTab == TabBarVM.tabs[1] {
                            ScheduleView()
                                .environmentObject(scheduleVM)
                                .navigationBarHidden(true)
                        } else if selectedTab == TabBarVM.tabs[2] {
//                            ScheduleView()
//                                .environmentObject(scheduleVM)
                            ViewPromotions()
                                .navigationBarHidden(true)
                        } else if selectedTab == TabBarVM.tabs[3] {
                            MoreView(index: $MoreTabIndex,SelectedTab: $selectedTab,DesiredScroll: $DesiredAppointmentItem,showingList:$showingList)
                                .navigationBarHidden(true)
                                .environmentObject(environments)
                        }
                        }.navigationBarHidden(true)
                        Spacer()
                        HStack(spacing: 0){
                            Spacer()
                            ForEach(TabBarVM.tabs.indices ){tab in
                                TabButton(title: TabBarVM.tabs[tab],selectedTab:$selectedTab){
                                    navController.popToRoot.send(false)
                                    if selectedTab == "TabBar_appointments" {
                                        AppointmentsTabIndex = 0
                                    }
                                    else if selectedTab == "TabBar_promotions"{
                                        promotionTabIndex = 0
                                    }
                                    else if selectedTab == "TabBar_more"{
                                        MoreTabIndex = 0
                                    }
                                    selectedTab = TabBarVM.tabs[tab]

                                }
                                Spacer()
                            }
                        }
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .padding([.leading,.trailing],20)
                        .padding(.bottom, 15)
                        .background(
                            RoundedCornersShape(radius: 20, corners: [.topLeft,.topRight])
                                .fill(Color.salamtackWelcome)
                                .padding(.top, -5)
                        )
            }
                    .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .popup(isPresented: $scheduleVM.showcncel){
            BottomPopupView{
                ViewCancelAppointmentPopUp(showCancePopUp: $scheduleVM.showcncel, cancelReason: $scheduleVM.AppointmentCancelReason).environmentObject(scheduleVM)
            }
        }
        .overlay(
            ZStack{
                if environments.ShowBloodType {
                ShowBloodTypeList(ShowBloodType: $environments.ShowBloodType, SelectedBloodName: $environments.SelectedBloodName, SelectedBloodId: $environments.SelectedBloodId)
                
                } else if environments.ShowMedicineAllergy{
                    ShowMedicineAllergyList(ShowMedicineAllergy: $environments.ShowMedicineAllergy, selectedMedicalAlgName: $environments.selectedMedicalAlgName, selectedMedicalAlgId: $environments.selectedMedicalAlgId)
                    
                }else if environments.ShowFoodAllergy{
                    ShowFoodAllergyList(ShowFoodAllergy: $environments.ShowFoodAllergy, selectedFoodAlgName: $environments.selectedFoodAlgName, selectedFoodAlgId: $environments.selectedFoodAlgId)
            }else if environments.ShowCountry {
                ShowNationalityList( ShowNationality: $environments.ShowCountry,SelectedNationalityName:$environments.countryName,SelectedNationalityId:$environments.CountryId)
            } else if environments.ShowCity{
                ShowCityList(ShowCity: $environments.ShowCity, SelectedCountryId: $environments.CountryId, SelectedCityName: $environments.cityName, SelectedCityId: $environments.CityId)
            }else if environments.ShowArea{
                ShowAreaList(ShowArea: $environments.ShowArea, SelectedCityId: $environments.CityId, SelectedAreaName: $environments.areaName , SelectedAreaId: $environments.AreaId)
            }else if environments.ShowOccupation{
                ShowOccupationList(ShowOccupation: $environments.ShowOccupation, SelectedOccupationName: $environments.occupationName, SelectedOccupationId: $environments.OccupationId)
            }else if environments.ShowCalendar{
                CalendarPopup( selectedDate: $environments.Birthday, isPresented: $environments.ShowCalendar,rangeType:environments.dateRange ,startingDate:environments.startingDate,endingDate:environments.endingDate)
            } else if environments.ShowSubSpeciality{
                ShowSubspecialityList(ShowSubspeciality: $environments.ShowSubSpeciality,selectedspecialityId:$environments.SpecialityId, selectedSubspecialityName: $environments.SubSpecialityName, selectedSubspecialityId: $environments.SubSpecialityId)
            } else if environments.ShowSeniority{
                ShowSeniorityList(ShowSeniority: $environments.ShowSeniority, SelectedSeniorityName: $environments.SeniorityName, SelectedSeniorityId: $environments.SeniorityId)
            }
            }
        )
        
        .onChange(of: environments.desiredTab, perform: {newval in
            selectedTab = newval
        })
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

class tabbar:ObservableObject{
    @Published var selectedTab = "TabBar_home"
    @Published var tabs = ["TabBar_home","TabBar_schedual",
                           "TabBar_promotions","TabBar_more"]
}
