//
//  NetworkBaseClass.swift
//  MovieAppIOS
//
//  Created by hungdt on 23/02/2023.
//

import Foundation

let accessToken = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNmRiZGYxMmZkNTc1NGM2YjhlMjhhYTJiNzE2NzFjZSIsImp0aSI6IjU2Mjc2NDEiLCJzY29wZXMiOlsiYXBpX3JlYWQiLCJhcGlfd3JpdGUiXSwidmVyc2lvbiI6MSwic3ViIjoiNjNmNDM4YjU0YTRiZmMwMGIyZmFlM2IzIiwibmJmIjoxNjc3MTM3NjEzfQ.n-U1uyFdDPIVnFfAQE2Q8xfpDONOi8ljVJg2jPlQ8dA"

let accountId = "63f438b54a4bfc00b2fae3b3"

let baseUrl = "https://api.themoviedb.org"

func getListMovie(){
    //Khởi tạo HTTP Request với URLSession
    let url = URL(string: "\(baseUrl)/4/account/\(accountId)/movie/recommendations?page=1")!
    var requestHttps =  URLRequest(url: url)
    requestHttps.httpMethod = "GET"
    requestHttps.setValue(accessToken, forHTTPHeaderField: "Authorization")
    let session = URLSession.shared
    //Dùng URLSessionDataTask gửi yêu cầu lấy dữ liệu
    let task = session.dataTask(with: requestHttps, completionHandler: { data, response, error in
        if (error != nil) {
            print(error!)
        } else {
            print(response ?? "")
            do {
                let model = try JSONDecoder().decode(ArrayResponeEntity<MovieEntity>.self, from: data!)
                print(model.results?.count ?? 0)
            } catch {
                print("getListMovie Error")
            }
        }
    })
    task.resume()
}
