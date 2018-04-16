//
//  CoreDataObject.swift
//  CoreDataSample
//
//  Created by DRISHTI-IT on 13/04/18.
//  Copyright © 2018 Srijan. All rights reserved.
//

import UIKit
import CoreData

class CoreDataObject: NSObject {
    
    static let context : NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tempContext = appDelegate.persistentContainer.viewContext
        return tempContext
    }()
    
    let studentEntity : NSEntityDescription = {
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)
        return entity!
    }()
    
    func saveData (name: String, roll: Int, photo: UIImage) {
        
        guard let newStudent = NSManagedObject(entity: studentEntity, insertInto: CoreDataObject.context) as? NSManagedObject else {
            return
        }
      
        newStudent.setValue(name, forKey: "name")
        newStudent.setValue(roll, forKey: "roll")
        guard let imageData = self.getDataFromImage(image: photo) as? Data  else {
            return
        }
        newStudent.setValue(imageData, forKey: "photo")
      
        do {
            try CoreDataObject.context.save()
        }catch {
            print("unable to save context")
        }
        
    }
    
    func fetchFromCoreData() -> [Student]{
        var student: [Student]? = nil
        do  {
            student = try CoreDataObject.context.fetch(Student.fetchRequest())
            return student!
        }
        catch {
            return student!
        }
    }
    
    func deleteAllObject() {
        do {
            let allObject = try CoreDataObject.context.fetch(Student.fetchRequest())
            for ob in allObject {
                CoreDataObject.context.delete(ob as! NSManagedObject)
                do {
                    try CoreDataObject.context.save()
                }catch {
                    print("unable to save context")
                }
            }
        }catch{
            
        }
    }

    private func getDataFromImage(image: UIImage) -> Data {
          let data = UIImagePNGRepresentation(image)
          return data!
    }
    
}
