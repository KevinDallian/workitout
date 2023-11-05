//
//  HistorySheet.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 02/11/23.
//

import SwiftUI

struct HistorySheet: View {
    var history : History
    @Binding var showSheet : Bool
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10){
            Text("\(history.executionDate.formatted(date: .long, time: .omitted))")
            LazyVStack(alignment: .leading, spacing: 5){
                // MARK: menghapus first supaya tidak error.
                Text("\(history.yogaDone.name ?? "Unknown Yoga")")
                    .font(.largeTitle.bold())
                Text("\(history.yogaDone.poses.count ?? -1) Exercise (\(history.duration) Min)")
                    .padding(.horizontal, 5)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                    .lineLimit(1)
                    .foregroundStyle(.gray)
            }
            .padding(.bottom, 10)
            ScrollView{
                LazyVStack{
//                    if let poses = history.yogaDone.first?.poses {
                    ForEach(history.yogaDone.poses, id: \.id){ pose in
                            PoseCard(pose: pose)
                        }
//                    }else {
//                        Text("No Poses to Show")
//                    }
                    
                }
                Spacer(minLength: 100)
            }
            
        }
        .padding(.horizontal, 14)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showSheet = false
                } label: {
                    ZStack{
                        Circle()
                            .foregroundStyle(.grayBorder.opacity(0.25))
                            .frame(width: 24, height: 24)
                        Image(systemName: "multiply")
                            .foregroundStyle(.black.opacity(0.6))
                            .bold()
                            .font(.system(size: 10))
                    }
                }

                
            }
        }
    }
}

#Preview {
    let poses = [
        Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .completed, position: .supine, spineMovement: .lateralBend, bodyPartTrained: [.back, .chest, .core]),
        Pose(id: UUID(), name: "Bound Angle", difficulty: .beginner, recommendedTrimester: .second, relieve: [.hip, .back, .pelvic], image: nil, description: "Bound Angle", seconds: 60, state: .completed, position: .seated, spineMovement: .neutral, bodyPartTrained: [.shoulders, .legs]),
        Pose(id: UUID(), name: "Cat", difficulty: .beginner, recommendedTrimester: .first, relieve: [.back, .pelvic], image: nil, description: "Cat", seconds: 60, state: .skipped, position: .armLegSupport, spineMovement: .forwardBend, bodyPartTrained: [.back, .neck])
    
    ]
    return NavigationStack{ 
        HistorySheet(history: History(id: UUID(), yogaDone: Yoga(id: UUID(), name: "Day 1 Upper Body", poses: poses, day: .monday, estimationDuration: 30, image: ""), executionDate: Date.now, duration: 30, rating: 5), showSheet: .constant(true))
    }
        
}
