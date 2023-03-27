//
// ContentView.swift : Assignment3
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI

struct ContentView: View {
    @StateObject var coursevm = CourseViewModel()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(coursevm.courses, id:\.self){course in
                    HStack{
                        URLImage(urlString: course.image)
                            
                        Text(course.name)
                    }.padding(3)
                }
            }.navigationTitle("Courses")
                .onAppear{
                    coursevm.fetchData()
                }
        }
    }
}
struct URLImage: View {
    let urlString: String
    @State var data: Data?
    var body:some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:130, height: 70)
                .background(Color.gray)
        }else{
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:130, height: 70)
                .background(Color.gray)
            .onAppear {
                fetchData()
            }
        }
    }
    private func fetchData() {
        guard let url = URL(string: urlString)else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){
            data, _, _ in
            self.data = data
        }
        task.resume()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
