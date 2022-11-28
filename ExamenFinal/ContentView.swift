//
//  ContentView.swift
//  ExamenFinal
//
//  Created by CCDM21 on 23/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDM: CoreDataManager
    @State var clave_viga = " "
    @State var clave_obra = " "
    @State var peso = ""
    @State var longitud = ""
    @State var material = " "
    @State var seleccionado: Viga?
    @State var vigArray = [Viga]()

    var body: some View {
        VStack{
            TextField("Clave de viga", text: $peso)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Clave de Obra", text: $peso)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Peso de viga", text: $peso)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Longitud de viga", text: $longitud)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Longitud de viga", text: $peso)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save"){
                if (seleccionado != nil){
                    seleccionado?.clave_viga = clave_viga
                    seleccionado?.clave_obra = clave_obra
                    seleccionado?.material = material
                    seleccionado?.peso = peso
                    seleccionado?.longitud = longitud
                    coreDM.actualizarViga(viga: seleccionado!)
                }else{
                coreDM.guardarViga(clave_viga: clave_viga, clave_obra: clave_obra, peso: peso, longitud: longitud, material: material)
                }
                mostrarVigas()
                clave_viga = " "
                clave_obra = " "
                peso = ""
                longitud = ""
                material = " "
               
                
            }
            List{
                ForEach(vigArray, id: \.self){
                    vig in
                    VStack{
                        Text(vig.clave_viga ?? "")
                        Text(vig.clave_obra ?? "")
                        Text(vig.peso ?? "")
                        Text(vig.longitud ?? "")
                        Text(vig.material ?? "")
                        
                    }
                    .onTapGesture{
                        seleccionado = vig
                        clave_viga = vig.clave_viga ?? ""
                        clave_obra = vig.clave_obra ?? ""
                        peso = vig.peso ?? ""
                        longitud = vig.longitud ?? ""
                        material = vig.material ?? ""
                    }
                }
                .onDelete(perform: {
                    IndexSet in
                    IndexSet.forEach({ index in
                        let viga = vigArray[index]
                        coreDM.borrarViga(viga: viga)
                        mostrarVigas()
                        
                    })
                })
            }
            Spacer()
        }.padding()
            .onAppear(perform: {
                mostrarVigas()
            })
    }
    func mostrarVigas(){
        vigArray = coreDM.leerTodasLasVigas()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
