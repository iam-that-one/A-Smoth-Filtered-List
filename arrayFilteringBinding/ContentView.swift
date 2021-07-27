//
//  ContentView.swift
//  arrayFilteringBinding
//
//  Created by Abdullah Alnutayfi on 26/07/2021.
//

import SwiftUI

struct ContentView: View {
    @State var students = ["Abdullah","Nasser","Fahad","Ali"]
    var body: some View{
        return   VStack{
                SmoothList(students: $students)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

