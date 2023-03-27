//
//  CourseViewModel.swift
//  Assignment3
//
//  Created by user236029 on 3/26/23.
//

import Foundation
import SwiftUI

class CourseViewModel: ObservableObject{
    @Published var courses: [Course] = []
    
   
    func fetchData() {
        guard let url = URL(string:"https://iosacademy.io/api/v1/courses/index.php") else {
            return
        }
        let task = URLSession
            .shared
            .dataTask(with: url) {[weak self] data, response, error in guard let data = data, error == nil else {
            return
        }
            do{
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async{
                    self?.courses = courses
                }
            }catch{
                print(error)
            }
        }
            task.resume()
            
    }
}
