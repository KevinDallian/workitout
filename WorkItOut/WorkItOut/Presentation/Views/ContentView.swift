//
//  ContentView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 20/10/23.
//

import SwiftUI

//FirestoreDummy

struct ContentView: View {
    @EnvironmentObject var dm: DataManager
    @Environment(\.managedObjectContext) var moc
    @State private var isLoading = true
    @State var alert = false
    
    var fetchlocalizedInstruction = LocalizePoseInstructionUseCase()
    
    var langId = Locale.current.language.languageCode!.identifier
    
    var body: some View {
        ZStack{
            if dm.hasNoProfile {
                OnboardingView()
            }
            if isLoading {
                EmptyView()
            }else{
                if !dm.hasNoProfile{
                    
                    HomeView()
                        .environmentObject(dm);
                }
            }
        }
        .environment(\.colorScheme, .light)
        .onChange(of: dm.savedToCoreData, { _, valueIsTrue in
            if valueIsTrue {
                dm.hasNoProfile = false
            }
        })
        .onAppear {
            Task{
                do {
                    dm.hasNoProfile = try await !dm.loadProfile(moc: moc)
                    
                    
                    
                } catch {
                    dm.hasNoProfile = false
                }
                isLoading = false
            }
        }
    }
}

#Preview {
    ContentView()
}
