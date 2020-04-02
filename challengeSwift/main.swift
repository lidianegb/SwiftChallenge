#!/usr/bin/swift

import Foundation


func exibirMenu(){

print("""
\u{001B}[0;33m
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@  @@@@@@@@@@@@@@@@      @@@@@      @@
@@@@     @@@@@@@@@@@@@      @@@@@      @@
@@@@         @@@@@@@@@      @@@@@      @@
@@@@            @@@@@@      @@@@@      @@
@@@@         @@@@@@@@@      @@@@@      @@
@@@@     @@@@@@@@@@@@@      @@@@@      @@
@@@@  @@@@@@@@@@@@@@@@      @@@@@      @@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
""")
print("""
\u{001B}[0;37m
---------------------------------------------
        Selecione uma opção:

        0 - Sair
        1 - Adicionar filme
        2 - Marcar como visto
        3 - Exibir lista de não assistidos
        4 - Exibir lista de assistidos
        5 - Gerar nova recomendação
        6 - Apagar filme 
---------------------------------------------
""")
}

// O arquivo filmes.json é criado (caso ele não exista), e
// a consntante myUrlFile guarda o caminho do arquivo criado
let myUrlFile = try createFileJson(fileName: "filmes")

// uma instância de Estante é criada e adicionada a constante minhaEstante
let minhaEstante = Estante()

// O arquivo é lido e seu conteúdo é armazenado em myListFilme
// Se não for possível ler o arquivo um erro será gerado
// a funçao decode é utilizada para pegar o conteúdo de myListFilme e transformar em um array de Filmes
// esse array de Filmes é adicionado a vaiável listFilme de minhaEstante
do {
    let myListFilme = try readFile(urlFile: myUrlFile)
    minhaEstante.listFilme = try decode(jsonString: myListFilme)
} catch FileDetailError.failedToReadFile{
    print("Erro ao tentar ler o arquivo: \(myUrlFile)")
} catch JsonDetailError.failedToDecoder{
    print("Erro ao tentar transformar uma String em um Array de Filmes")
    
}


// Primeiramente deve ser exibido a recomendação e em seguida as opções do menu
minhaEstante.exibirRecomendacao()
exibirMenu()



while let input = readLine(){
    // verifica se o valor inserido é um inteiro
    // caso não seja uma mensagem é exibida e o programa vai esperar que outro valor seja inserido
  guard let id = Int(input)else {
    print("Digite um valor inteiro. ")
    continue
  }
    // a opção 0 indica o fim do programa
  if id == 0{
    do{
        /*
         Ao finalizar o programa a função encode é chamada pra transformar a lista
         de filmes de minha estante em uma string em formato json.
         O valor dessa string é armazenado em myListFilme.
         Caso não seja possível essa conversão, um erro é exibido.
         A String myListFilme é escrita no arquivo, guardando todas as alterações feitas
         durante a execução do programa.
        */
        let myListFilme = try encode(listFilme: minhaEstante.listFilme)
        try writeFile(urlFile: myUrlFile, json: myListFilme)
    } catch JsonDetailError.failedToEncoder{
        print("Erro ao tentar transformar uma String em um Array de Filmes")
    } catch FileDetailError.failedToWriteFile{
        print("Erro ao tentar escrever no arquivo: \(myUrlFile)")
    }
    break
  }
  
  switch id {
   
    case 1:
         // opção para inserir um novo filme
      print("Digite o nome do filme:")
      minhaEstante.addFilme()
      exibirMenu()
    case 2:
        // opção para marcar um filme como assistido
      print("Digite o código do filme: ")
      minhaEstante.marcarAssistido()
      // Ao marcar um filme como assistido, uma nova recomendação é gerada
      minhaEstante.exibirRecomendacao()
      exibirMenu()
    case 3:
        // opção para exibir a lista de filmes que não foram assistidos
      minhaEstante.exibirFilmesNaoAssistidos()
      exibirMenu()
    case 4:
        // opção para exibir a lista de filmes já foram assistidos
      minhaEstante.exibirFilmesAssistidos()
      exibirMenu()
    case 5:
        // opção para gerar uma nova recomendação de filme
      minhaEstante.exibirRecomendacao()
      exibirMenu()
    case 6:
        // opção para apagar um filme da lista de filmes
      print("Digite o código do filme: ")
      minhaEstante.apagarFilme()
      // ao ser apagado um filme, uma nova recomendação é gerada
      minhaEstante.exibirRecomendacao()
      exibirMenu()
    default:
      print("Opção inválida.")
  }
}

