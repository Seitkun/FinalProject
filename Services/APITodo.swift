import Foundation

struct APITodo: Codable {
    let id: Int
    let title: String
    let completed: Bool
}

final class APIService {
    func fetchTodos(completion: @escaping (Result<[Item], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let todos = try JSONDecoder().decode([APITodo].self, from: data)
                let items = todos.prefix(5).map {
                    Item(
                        id: UUID(),
                        title: $0.title,
                        description: "Loaded from API",
                        date: Date(),
                        deadline: Date(),
                        type: .task,
                        isDone: $0.completed
                    )
                }
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
