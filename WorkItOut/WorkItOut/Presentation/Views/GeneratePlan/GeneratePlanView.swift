//
//  GeneratePlanView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct GeneratePlanView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dm: DataManager
    
    @State var finish: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Button(action: {
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.white)
                                    .bold()
                            })
                            .padding(.bottom)
                            Spacer()
                        }
                        Text("Workout Plan for Beginner")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .bold()
                    }
                    .padding(.top, 72)
                    .padding()
                    .background(
                        Image(.assesmentResultHeader)
                            .resizable()
                            .frame(maxWidth: .infinity)
                    )
                    DayPickerView()
                    if dm.profile.plan.isEmpty {
                        Text("No Plan yet")
                    }
                    else {
                        VStack(alignment: .leading) {
                            ForEach(Array(dm.profile.plan[0].yogas.enumerated()), id: \.element) { index, yoga in
                                VStack {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Day \(index + 1) - Upper Body")
                                                .font(.title3)
                                                .bold()
                                            Text("\(yoga.day.getString()), \(dm.profile.timeOfDay.getString())")
                                                .foregroundStyle(Color.neutral3)
                                                .font(.body)
                                        }
                                        Spacer()
                                        Button(action: {
                                            
                                        }, label: {
                                            Image(systemName: "pencil")
                                        })
                                    }
                                    ForEach(yoga.poses, id: \.self) { pose in
                                        YogaCardView(name: pose.name)
                                    }
                                }
                                .padding()
                                .background(.white)
                            }
                        }
                        .background(Color.neutral6)
                    }
                    
                }
                
                VStack {
                    
                    ButtonComponent(title: "Finish") {
                        Task {
//                            var addProfile: AddProfileUseCase = AddProfileUseCase()
//                            
//                            await addProfile.call(profile: dm.profile, context: moc)
//                            
//                            var fetchProfile = FetchProfileUseCase()
//                            
//                            let fetchRes = await fetchProfile.call(context: moc)
//                            
//                            dm.profile = fetchRes.first!
//                            
//                            print(fetchRes.first?.name)
                            
                            finish.toggle()
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
            .navigationDestination(isPresented: $finish, destination: {
                HomeView(vm: HomeViewModel(profile: dm.profile))
                    .environmentObject(dm)
            })
            .ignoresSafeArea()
        }
    }
}

//#Preview {
//    GeneratePlanView(dm: DataManager())
//}
