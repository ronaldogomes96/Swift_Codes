import UIKit

/*
 Exemplos
 Caminho: /Users/NSHipster/Documents/article.md
 URL do arquivo: file:///Users/NSHipster/Documents/article.md
 URL de referência do arquivo: file:///.file/id=1234567.7654321/
 
 */


//Cria um path
//Eles determinam que tipo de diretório padrão você está procurando, como "Documentos" ou "Caches"

//O segundo parâmetro passa um valor, que determina o escopo de onde você está procurando
let documentsDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil, create: false)

//Verificando se o arquivo existe
let fileExists = FileManager.default.fileExists(atPath: documentsDirectoryURL.path)

//Podemos obter informacoes sobre um arquivo, criando um novo tipo
let atributes = try FileManager.default.attributesOfItem(atPath: documentsDirectoryURL.path)
let createData = atributes[.creationDate]

//Para excluir um arquivo ou diretorio
try! FileManager.default.removeItem(at: documentsDirectoryURL)

