import Foundation

/*Classe que representa um filme
Ao extender o protocolo Codable,
uma instância da classe Filme pode ser codificada em um dado Json usando o JsonEncoder
*/
class Filme: Codable{


   var nome:String
   var visto:Bool
    var cod: String
  
    init(nome: String, codigo:String){
    self.nome = nome
    self.visto = false
    self.cod = codigo
  }
  
// Função para marcar um filme como assistido
  func assistido(){
    self.visto = true
  }
   

}
