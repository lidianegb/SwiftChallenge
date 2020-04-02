import Foundation


class Estante {

    var listFilme:[Filme] = []
  
// Função para receber uma string do terminal, que é o nome do filme a ser adicionado
// Um nova instância de filme é criada e retornada
  private func createFilme() -> Filme? {
    guard let input = readLine() else{
      print("Um erro ocorreu ao tentar adicionar novo filme.\n")
      return nil
    }
    if input == "" {
      print("Nome inválido!\n")
      return nil
    }
    let filme = Filme(nome: input)
    return filme
  }
  
// Função para adicionar o novo filme criado a lista de filmes
  func addFilme() {
    if let novoFilme = createFilme() {
        // Se a lista não tiver vazia, o códido do filme vai ser incrementado
        // com o código do último filme da lista
        // caso contrário o código será 1
      if !listFilme.isEmpty{
        let filme = listFilme.last
        novoFilme.cod += filme!.cod
      }
      self.listFilme.append(novoFilme)
      print("Filme adicionado com sucesso.\n")
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
      print("Lista Vazia.\n")
    } else {
      for i in list {
        print(" \(i.cod) - \(i.nome)")
      }
    }
  }
  
  
    // Gera recomendação aleatória a partir da lista de filmes não assistidos
    // retorna o filme e seu código
  private func gerarRecomendacao()->(Int, String){
    let listFilmes = filmes(false)
    if let filme = listFilmes.randomElement(){
      let nomeFilme = filme.nome
      let cod = filme.cod
      return (cod, nomeFilme)
    }
    return (0, "Lista vazia.\n")
  }
  
    // Exibe recomendação
  func exibirRecomendacao(){
    print("""
        \u{001B}[5;31m
      ****** Recomendação de hoje *******
            \(gerarRecomendacao())
      ***********************************\n
      """)
    }

  // Recebe um código de um filme pelo terminal e marca esse filme como assistido
 // Se o código for inválido uma mensagem de erro é retornada
  func marcarAssistido() {
    if let inputCod = readLine() {
      guard let cod = Int(inputCod) else {
        print("O código deve ser um valor inteiro.\n")
        return
      }
      let filme = listFilme.first(where:{ $0.cod == cod})
      if let filme = filme{
        filme.assistido()
        print("Filme \"\(filme.nome)\" adicionado a lista de assistidos.\n")
      }else{
        print("Código inválido.\n")
      }
    }else{
      print("Um erro ocorreu ao tentar adicionar o filme a lista de assistidos.\n")
    }
  }
  
    
  // Função que apaga um filme pelo número do código
  func apagarFilme() {
    if let inputCod = readLine() {
      guard let cod = Int(inputCod) else {
        print("O código deve ser um valor inteiro.\n")
        return
      }
      let index = listFilme.firstIndex { filme in
        return filme.cod == cod }
      if let index = index {
        listFilme.remove(at: index)
        print("Filme removido com sucesso.\n")
      } else { print("Código inválido.\n") }
    } else { print("Um erro ocorreu ao tentar remover o filme.\n") }
  }
  
  
 
}
