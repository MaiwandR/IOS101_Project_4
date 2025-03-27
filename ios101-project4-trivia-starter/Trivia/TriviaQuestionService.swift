//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Maiwand Raheem on 3/27/25.
//

import Foundation

class TriviaQuestionService {
    private let apiURL = "https://opentdb.com/api.php?amount=5&type=multiple"
    
    func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]?) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching trivia data:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            
            do {
                let triviaResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)
                completion(triviaResponse.results)
            } catch {
                print("Error decoding JSON:", error)
                completion(nil)
            }
        }.resume()
    }
}
