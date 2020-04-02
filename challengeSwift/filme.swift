import Foundation

/*Classe que representa um filme
Ao extender o protocolo Codable,
uma instância da classe Filme pode ser codificada em um dado Json usando o JsonEncoder
*/
class Filme: Codable{

   var nome:String
   var visto:Bool
    var cod: Int = 0
  
  init(nome: String){
    self.nome = nome
    self.visto = false
    self.cod += 1
  }
  
// Função para marcar um filme como assistido
  func assistido(){
    self.visto = true
  }

}
