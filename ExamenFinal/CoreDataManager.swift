//
//  CoreDataManager.swift
//  ExamenFinal
//
//  Created by CCDM21 on 23/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name:"Viga")
        persistentContainer.loadPersistentStores(completionHandler :{
            (descripcion, error) in
            if  let error = error{
                fatalError("Core data failed to initizliazee \(error.localizedDescription)")
            }
            
            
        })
        
        
    }
    func guardarViga(clave_viga: Int64, clave_obra: Int64, peso: Double, longitud: Double, material: String){
        let viga = Viga(context: persistentContainer.viewContext)
        viga.clave_viga = clave_viga
        viga.clave_obra = clave_obra
        viga.peso = peso
        viga.longitud = longitud
        viga.material = material
        
        do{
            try persistentContainer.viewContext.save()
            print("viga guardada")
        }
        catch{
            print("Failed to save error en \(error)")
        }
        
        
    }
    func leerTodasLasVigas() -> [Viga]{
        let fetchRequest : NSFetchRequest<Viga> = Viga.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    func borrarViga(viga: Viga){
        persistentContainer.viewContext.delete(viga)
        
        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
    
    
}
