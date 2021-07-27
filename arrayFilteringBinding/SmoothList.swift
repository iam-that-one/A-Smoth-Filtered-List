//
//  SmothList.swift
//  arrayFilteringBinding
//
//  Created by Abdullah Alnutayfi on 27/07/2021.
//

import SwiftUI

struct SmoothList : View{
    @Binding var list : [String]
    @State var filteredList : [String] = []
    @State var search : String = ""
    var body: some View {
        let searchfilter = Binding<String> (
            get: {search},
            set:{
                search = $0
                if search != ""{
                    filteredList = list.filter{$0.lowercased().contains(search.lowercased())}
                }
                if search == ""{
                    filteredList = list
                }
            }
        )
        VStack{
            Rectangle()
                .frame(width: 300,height: CGFloat(filteredList.count * 70 + 120))
                .foregroundColor(Color(.systemGray5))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                .cornerRadius(10)
                .overlay(
                    VStack{
                        HStack{
                            TextField("name", text: searchfilter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical)
                            // disabled if search == "" OR if list already has the search string
                            Button(action:{
                                if search != "" && !list.contains(search){
                                    list.append(search)
                                    filteredList = list
                                    search = ""
                                }
                            }){
                                Image(systemName: "plus.circle.fill")
                            }.disabled( search == "" || list.contains(search))
                        }
                        List{
                            ForEach(filteredList, id: \.self) { student in
                                Text(student)
                            }.onDelete { indexSet in
                                list.remove(atOffsets: indexSet)
                                filteredList.remove(atOffsets: indexSet)
                            }
                        }.frame(height: !list.contains(search) ? CGFloat(filteredList.count * 70 + 30) : CGFloat(filteredList.count * 70 + 30))
                        .cornerRadius(10)
                        .listStyle(GroupedListStyle())
                        Spacer()
                    }.padding(20)
                )
            Spacer()
        }.onAppear{filteredList = list}
        .shadow(radius: 10)
        .animation(.spring())
        .padding(.top,50)
    }
}
