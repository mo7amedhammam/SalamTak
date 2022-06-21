//
//  MainFilterView.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI
import Combine

enum FilterCases{
    case Menu,Title,Speciality,SubSpeciality,City,Area,Fees
}

struct MainDoctorFilterView: View {
    @EnvironmentObject var searchDoc : VMSearchDoc
    @EnvironmentObject var seniorityVM : ViewModelSeniority
    @EnvironmentObject var specialityvm : ViewModelSpecialist
    @EnvironmentObject var SubSpecialityVM : ViewModelSubspeciality
    @EnvironmentObject var CitiesVM : ViewModelGetCities
    @EnvironmentObject var AreasVM : ViewModelGetAreas
    @EnvironmentObject var FeesVM : ViewModelFees
    
    @Binding var FilterTag:FilterCases
    @Binding var showFilter:Bool
    
    @Binding var SpecialistId:Int
    @Binding var CityId:Int
    @Binding var AreaId:Int
    @Binding var selectedSeniorityLvlName :String?
    @Binding var selectedSeniorityLvlId :Int?
    @Binding var SenbuttonSelected: Int?
    
    @Binding var selectedSpecLvlName :String?
    @Binding var selectedSpecLvlId :Int?
    @Binding var SpecbuttonSelected: Int?
    
    @Binding var selectedSubSpecLvlNames : [String]
    @Binding var selectedSubSpecLvlIds : [Int]
    
    @Binding var selectedFee :Float
    
    @Binding var selectedFilterCityName :String?
    @Binding var selectedFilterCityId :Int?
    @Binding var CitybuttonSelected: Int?
    
    @Binding var selectedFilterAreaName :String?
    @Binding var selectedFilterAreaId :Int?
    @Binding var AreabuttonSelected: Int?
    @Binding  var searchTxt : String
    
    var body: some View {
        CustomSheet(IsPresented: $showFilter, TapToDismiss: .constant(false), content: {
            switch FilterTag{
            case .Menu:
                FilterMenu(FilterTag: $FilterTag, showFilter: $showFilter, selectedSeniorityLvlName: $selectedSeniorityLvlName,selectedSeniorityLvlId:$selectedSeniorityLvlId, selectedSpecLvlName: $selectedSpecLvlName, selectedSpecLvlId: $selectedSpecLvlId, selectedSubSpecLvlNames: $selectedSubSpecLvlNames,selectedSubSpecLvlIds:$selectedSubSpecLvlIds, selectedFee: $selectedFee, selectedFilterCityName: $selectedFilterCityName,selectedFilterCityId:$selectedFilterCityId, selectedFilterAreaName: $selectedFilterAreaName,selectedFilterAreaId:$selectedFilterAreaId,searchTxt:$searchTxt)
                    .environmentObject(searchDoc)
                    .environmentObject(FeesVM)
                
                
            case .Speciality:
                SpecialityFilterList( FilterTag: $FilterTag, SpecialistId: $SpecialistId, selectedSpecLvlName: $selectedSpecLvlName, selectedSpecLvlId: $selectedSpecLvlId, SpecbuttonSelected: $SpecbuttonSelected)
                    .environmentObject(specialityvm)
                
            case .Title:
                TitleFilterList(FilterTag: $FilterTag, selectedSeniorityLvlName: $selectedSeniorityLvlName, selectedSeniorityLvlId: $selectedSeniorityLvlId, SenbuttonSelected: $SenbuttonSelected)
                    .environmentObject(seniorityVM)
                
            case .SubSpeciality:
                SubSpecialityFilterList( FilterTag: $FilterTag, SpecialistId: $SpecialistId, selectedSpecLvlId: $selectedSpecLvlId, selectedSubSpecLvlNames: $selectedSubSpecLvlNames, selectedSubSpecLvlIds: $selectedSubSpecLvlIds)
                    .environmentObject(SubSpecialityVM)
            case .City:
                CityFilterList( FilterTag: $FilterTag, selectedFilterCityName: $selectedFilterCityName, selectedFilterCityId: $selectedFilterCityId, CitybuttonSelected: $CitybuttonSelected)
                    .environmentObject(CitiesVM)
            case .Area:
                AreaFilterList( FilterTag: $FilterTag, CityId: $CityId, selectedFilterCityId: $selectedFilterCityId, selectedFilterAreaName: $selectedFilterAreaName, selectedFilterAreaId: $selectedFilterAreaId, AreabuttonSelected: $AreabuttonSelected)
                    .environmentObject(AreasVM)
            case .Fees:
                FeesFilterView( FilterTag: $FilterTag, selectedFee: $selectedFee)
                    .environmentObject(FeesVM)
            }
            
            
        })
        
    }
}





