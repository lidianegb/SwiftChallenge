import Foundation

// enum representando os possíveis erros que podem ocorrer com a manipulação de arquivos
enum FileDetailError: Error{
    case failedToWriteFile
    case failedToReadFile
    case failedToCreateFile
}

extension FileDetailError: LocalizedError{
    public var errorDescription: String?{
           switch self {
           case .failedToWriteFile:
               return NSLocalizedString("Erro ao tentar escrever no arquivo", comment: "Decoder")
           case .failedToReadFile:
               return NSLocalizedString("Erro ao tentar ler o arquivo", comment: "Encoder")
           case .failedToCreateFile:
            return NSLocalizedString("Erro ao tentar criar o arquivo", comment: "CreateFile")
        }
       }
}

/*
Retorna o caminho do diretório documentos
file:///Users/lidiane/Documents/
*/
private func getDocumentsDiretory() -> URL{
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return path
}

// Função que recebe uma string e um caminho de um arquivo e escreve nesse arquivo a string recebida
func writeFile(urlFile:URL, json:String) throws{
    do{
        try json.write(to: urlFile, atomically: true, encoding: String.Encoding.utf8)
    }catch{
        throw FileDetailError.failedToWriteFile
    }
}

// Recebe um caminho de um arquivo, ler o conteúdo do arquivo, salva em uma String e retorna a mesma
func readFile(urlFile:URL) throws -> String{
    do{
        let readString = try String(contentsOf: urlFile)
        return readString
    }catch{
        throw FileDetailError.failedToReadFile
    }
}

// Função para criar um arquivo
func createFileJson(fileName:String) throws -> URL{
    
    let urlFile = getDocumentsDiretory().appendingPathComponent(fileName+".json")
    
    // verifica se o arquivo já existe
    let exists = FileManager.default.fileExists(atPath: urlFile.path)
    
    // caso o arquivo não exista, a função writeFile vai criar o arquivo e escrever nele "[]"
    if (!exists){
        do{
            try writeFile(urlFile: urlFile, json: "[]")
        }catch{
            throw FileDetailError.failedToCreateFile
        }
    }
    return urlFile
}
