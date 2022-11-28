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
    func guardarViga(clave_viga:  String, clave_obra: String, peso: String, longitud: String, material: String){
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
    
    func leerViga (clave_viga:String) -> Viga?{
    let fetchRequest : NSFetchRequest<Viga> = Viga.fetchRequest ()
    let predicate = NSPredicate (format: "clave_viga = %@", clave_viga)
    fetchRequest.predicate = predicate
    do {
        let datos = try persistentContainer.viewContext.fetch(fetchRequest)
        return datos.first
    }
    catch{
        print ("Failed to save error en \(error)")
    }
     return nil
    
    }
    
    func actualizarViga(viga: Viga) {
        let fetchRequest : NSFetchRequest<Viga> = Viga.fetchRequest ()
        let predicate = NSPredicate (format: "clave_viga = %@", viga.clave_viga ?? "")
    fetchRequest.predicate = predicate
    do {
    let datos = try persistentContainer.viewContext.fetch(fetchRequest)
    let p = datos.first
        p?.material = viga.material
        p?.longitud = viga.longitud
        p?.peso = viga.peso
        p?.clave_obra = viga.clave_obra
    try persistentContainer.viewContext.save ()
    print ("viga guardada")
    }
    catch{
    print ("Failed to save error en \(error)")
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
