//
//  addWorkouts.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import CoreData

struct AddProfileUseCase {
    var repository : Repository = Repository()
    
    func call(profile : Profile, context : NSManagedObjectContext) async throws{
        
        let prof = profile
        
//        do {
            try await repository.coreData.saveToCoreData( context: context)
            
//        } catch let err{
//            fatalError("Failed to save to coredata: \(err.localizedDescription)")
//        }
    }
}
