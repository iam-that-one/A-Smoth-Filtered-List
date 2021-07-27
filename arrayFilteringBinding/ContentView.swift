//
//  ContentView.swift
//  arrayFilteringBinding
//
//  Created by Abdullah Alnutayfi on 26/07/2021.
//

import SwiftUI

struct ContentView: View {
    @State var students = ["Abdullah","Nasser","Fahad","Ali"]
    @State var search = ""
    @State var filteredStudent : [String] = []
    var body: some View {
        let searchfilter = Binding<String> (
            get: {search},
            set:{
                search = $0
                if search != ""{
                    filteredStudent = students.filter{$0.lowercased().contains(search.lowercased())}
                }
                if search == ""{
                    filteredStudent = students
                }
            }
        )
        return NavigationView{
            VStack{
                Rectangle()
                    .frame(width: 300,height: CGFloat(filteredStudent.count * 70 + 120))
                    .foregroundColor(Color(.systemGray5))
                    
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                    
                    .cornerRadius(10)
                    .overlay(
                        VStack{
                            HStack{
                                TextField("name", text: searchfilter)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical)
                                // disabled if search == "" OR if students array already has the name
                                Button(action:{
                                    if search != "" && !students.contains(search){
                                        students.append(search)
                                        filteredStudent = students
                                        search = ""
                                    }
                                }){
                                    Image(systemName: "plus.circle.fill")
                                }.disabled( search == "" || students.contains(search))
                            }
                            
                            List{
                                ForEach(filteredStudent.sorted(), id: \.self) { student in
                                    Text(student)
                                }
                            }.frame(height: !students.contains(search) ? CGFloat(filteredStudent.count * 70 + 30) : CGFloat(filteredStudent.count * 70 + 30))
                            .cornerRadius(10)
                            .listStyle(GroupedListStyle())
                            Spacer()
                        }.padding(20)
                        
                    )
                Spacer()
            }.onAppear{  filteredStudent = students}
            .shadow(radius: 10)
            .animation(.spring())
            .padding(.top,50)
            .toolbar{
                ToolbarItem(placement : .principal){
                    Text("A smoth List")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
