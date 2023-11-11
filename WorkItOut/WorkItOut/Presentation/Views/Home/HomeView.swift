//
//  HomeView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import CoreData
import SwiftUI

struct HomeView: View {
    @StateObject var vm: HomeViewModel = HomeViewModel()
    @State private var path : NavigationPath = NavigationPath()
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dm : DataManager
    @State var alert : Bool = false
    var body: some View {
        NavigationStack(path: $path){
            VStack {
                VStack {
                    ZStack {
                        if vm.showHeader {
                            Image("AssesmentResultHeaderBackground")
                                .resizable()
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .ignoresSafeArea()
                        }
                        VStack {
                            HStack {
                                Button {
                                    vm.showProfile = true
                                } label: {
                                    HomeButtonView(icon: "person")
                                }
                                Spacer()
                                HomeWeekIndicatorView()
                                    .onAppear {
                                        self.vm.initMonth()
                                    }
                                    .environmentObject(vm)
                                Spacer()
                                NavigationLink{
                                    HistoryView(vm: HistoryViewModel(histories: vm.profile.histories))
                                } label: {
                                    HomeButtonView(icon: "clock.arrow.circlepath")
                                }
                            }
                            .padding(.bottom)
                            
                            if vm.showHeader {
                                HStack {
                                    if let profile = dm.profile {
                                        ForEach(Day.allCases, id: \.self) { day in
                                            DayButtonView(selectedDay: $vm.day, workoutDay: vm.days, day: day, weekXpreg: profile.currentPregnancyWeek, checkedWeek: vm.week)
                                        } 
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .animation(.default, value: vm.showHeader)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                
                ScrollListenerViewBuilder(showContent: $vm.showHeader) {
                    HomeCurrentYogaView()
                        .environmentObject(vm)
                    
                    VStack(alignment: .leading) {
                        Text("Exercise that might help you")
                            .font(.title2)
                            .bold()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(Relieve.allCases, id: \.self) { relieve in
                                    HomeYogaCategoryView(relieve: relieve)
                                }
                            }
                        }
                        ForEach(dm.handMadeYogaPlan[vm.selectedRelieve] ?? vm.yogaPlans, id: \.id) { yogaPlan in
                            HomeOtherPlansView(yogaPlan: yogaPlan)
                                .animation(.default, value: vm.selectedRelieve)
                        }
                    }
                    .padding()
                }
            }
            .onChange(of: vm.week) { _ in
                vm.initMonth()
            }
            .onChange(of: vm.day) { _ in
                vm.initMonth()
            }
            .sheet(isPresented: $vm.showProfile, onDismiss: {
                Task{
                    do {
                        print("Load Profile from dm.profile")
                        try await vm.loadProfile(profile: dm.profile!)
                    } catch {
                        print("masuk ke alert")
                        self.alert = true
                    }
                }
                
                dm.objectWillChange.send()
            },  content: {
                NavigationStack{
                    ProfileView(vm: ProfileViewModel(profile: vm.profile))
                }
            })
            .sheet(isPresented: $vm.sheetToggle, content: {
                YogaDetailView(sheetToggle: $vm.sheetToggle, path: $path, yoga: vm.currentYoga)
                    .padding(.top)
            })
            .onAppear{
                Task{
                    do {
                        print("Load Profile from dm.profile")
                        try await vm.loadProfile(profile: dm.profile!)
                    } catch {
                        print("masuk ke alert")
                        self.alert = true
                    }
                }
                

            }
            .background(Color.background)
            .navigationDestination(for: String.self) { string in
                ExecutionView(vm: ExecutionViewModel(yoga: vm.currentYoga), path: $path)
                    .navigationBarBackButtonHidden()
            }
        }
        .environmentObject(vm)
        .navigationBarBackButtonHidden()
    }
    
    
}

//#Preview {
//    HomeView()
//}
