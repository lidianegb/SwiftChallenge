import Foundation


private enum CreateFilmeDetailError:Error{
    case invalidName
    case repeatedName
    case errorCreatingMovie
  }
  extension CreateFilmeDetailError:LocalizedError{
      public var errorDescription: String?{
            switch self {
            case .invalidName:
                return NSLocalizedString("Nome inválido", comment: "Create filme")
            case .repeatedName:
                return NSLocalizedString("Já existe um filme adicionado com esse nome", comment: "Create filme")
            case .errorCreatingMovie:
                 return NSLocalizedString("Erro ao tentar criar o filme", comment: "Create filme")
           
            }
        
       
        
  }
}

class Estante {

    var listFilme:[Filme] = []
  

    private func codigoValido(cod: String) -> Bool{
        var valido = true
        if !listFilme.isEmpty {
            if let _ = self.listFilme.filter({$0.cod==cod}).first{
                valido = false
            }
        }
        return valido
    }
    
    
    private func gerarCod() -> String{
        let alfa = ["A", "B", "C","D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        let nums = ["0","1","2","3","4","5","6","7","8","9"]
        let codigo : String = alfa.randomElement()! + nums.randomElement()! + alfa.randomElement()!
        return codigo
      }
    
  
    private func nomeValido(nome:String) throws{
        if nome == "" {
            throw CreateFilmeDetailError.invalidName
           }
        let filme = listFilme.first(where:{ $0.nome.uppercased() == nome.uppercased()})
        
        if let _ = filme{
            throw CreateFilmeDetailError.repeatedName
        }
        
      
        
    }
    
// Função para receber uma string do terminal, que é o nome do filme a ser adicionado
// Um nova instância de filme é criada e retornada
  private func createFilme() throws -> Filme {
    guard let input = readLine() else{
        throw CreateFilmeDetailError.errorCreatingMovie
    }
   
    try nomeValido(nome: input)
   
    var codigo = gerarCod()
    while !codigoValido(cod: codigo){
        codigo = gerarCod()
    }
    let filme = Filme(nome: input, codigo:codigo)
    return filme
  }
  
// Função para adicionar o novo filme criado a lista de filmes
  func addFilme() {
    do{
        let novoFilme = try createFilme()
        self.listFilme.append(novoFilme)
        print("\nFilme adicionado com sucesso.\n")
    }catch{
        print(error.localizedDescription)
    }
    
  }

    // Retorna uma lista de filmes assistidos, se possuirem o atributo visto como true
    // ou os não assistidos se possuirem o atributo visto como false
    private func filmes(_ assistido:Bool) -> [Filme] {
    let filmes = self.listFilme.filter({$0.visto==assistido})
    return filmes
  }
  
   // exibe o código e o nome dos filmes
    func exibirFilmes(assistido:Bool) {
        let list = filmes(assistido)
    if list.isEmpty {
      print("\nLista Vazia.\n")
    } else {
      for i in list {
        print(" \(i.cod) - \(i.nome)")
      }
    }
  }
  
  
    // Gera recomendação aleatória a partir da lista de filmes não assistidos
    // retorna o filme e seu código
  private func gerarRecomendacao()->(String){
    let listFilmes = filmes(false)
    if let filme = listFilmes.randomElement(){
      let nomeFilme = filme.nome
      return nomeFilme
    }
    return "\nLista vazia.\n"
  }
  
    // Exibe recomendação
  func exibirRecomendacao(){
    print("""
        \u{001B}[5;31m
      \n****** Recomendação de hoje *******\n
              \(gerarRecomendacao())
      \n***********************************\n
      """)
    }

  // Recebe um código de um filme pelo terminal e marca esse filme como assistido
 // Se o código for inválido uma mensagem de erro é retornada
  func marcarAssistido() {
    if let inputCod = readLine() {
      let filme = listFilme.first(where:{ $0.cod == inputCod})
      if let filme = filme{
        filme.assistido()
        print("\nFilme \"\(filme.nome)\" adicionado a lista de assistidos.\n")
      }else{
        print("\nCódigo inválido.\n")
      }
    }else{
      print("\nUm erro ocorreu ao tentar adicionar o filme a lista de assistidos.\n")
    }
  }
  
    
  // Função que apaga um filme pelo número do código
  func apagarFilme() {
    if let inputCod = readLine() {
      let index = listFilme.firstIndex { filme in
        return filme.cod == inputCod }
      if let index = index {
        listFilme.remove(at: index)
        print("\nFilme removido com sucesso.\n")
      } else { print("\nCódigo inválido.\n") }
    } else { print("\nUm erro ocorreu ao tentar remover o filme.\n") }
  }
  
}
