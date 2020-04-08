import Foundation

// enum representando os possíveis erros que podem ocorrer com a manipulação das funções encode e decode
enum JsonDetailError : Error{
    case failedToEncoder
    case failedToDecoder
}

extension JsonDetailError : LocalizedError{
    public var errorDescription: String?{
        switch self {
        case .failedToDecoder:
            return NSLocalizedString("Erro ao tentar Decodar", comment: "Decoder")
        case .failedToEncoder:
            return NSLocalizedString("Erro ao tentar encodar", comment: "Encoder")
        }
    }
}
//Transforma o array de Filmes em uma string em formato json
/*
 [
    {
        "visto":false,
        "nome":"007",
        "cod":1
    },
    {
        "visto":true,
        "nome":"Um amor pra recordar",
        "cod":2
    }
 ]

 */
func encode(listFilme:[Filme]) throws -> String{
    let jsonData = try JSONEncoder().encode(listFilme)
    guard let jsonString = String(data: jsonData, encoding: .utf8) else {
        throw JsonDetailError.failedToEncoder
    }
    return jsonString
 }
 

//Transforma uma String em formato Json em um Array de Filmes
func decode(jsonString: String) throws -> [Filme]{
   
    guard let jsonData = jsonString.data(using:.utf8) else{
        throw JsonDetailError.failedToDecoder
    }
    let filme = try JSONDecoder().decode([Filme].self,from: jsonData)
    return filme
}

