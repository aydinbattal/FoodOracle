//
//  ContentView.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-11-22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fireDBHelper : DBHelper
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .top){
                GeometryReader{_ in
                    Text("Home")
                }.background(Color("Color").edgesIgnoringSafeArea(.all))
                SearchBar(data: self.fireDBHelper.receiptList)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchBar: View {
    @State var tfSearch = ""
    var data : [dataType]
    
    var body : some View {
        VStack(spacing: 0){
            HStack{
                TextField("Search", text: self.$tfSearch)
                if (self.tfSearch != ""){
                    Button(action: {
                        self.tfSearch = ""
                    }) {
                        Text("Cancel")
                    }
                    .foregroundColor(.black)
                }
            }.padding()
            if (self.tfSearch != ""){
                if (self.data.filter({$0.name.lowercased().contains(self.tfSearch.lowercased())}).count == 0){
                    Text("No Results Found")
                        .foregroundColor(Color.black.opacity(0.5).padding() as! Color)
                } else {
                    List(self.data.filter{$0.name.lowercased().contains(self.tfSearch.lowercased())}){i in
                        NavigationLink(destination: Detail(data: i)){
                            Text(i.name)
                        }
                    }.frame(height: UIScreen.main.bounds.height/5)
                    
                }
            }
        }.background(Color.white)
            .padding()
    }
}

struct Detail : View {
    var data : dataType
    
    var body : some View{
        Text(data.name)
    }
}

struct dataType : Identifiable{
    var id : UUID
    var name : String
}
