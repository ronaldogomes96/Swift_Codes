import Cocoa

//Path do arquivo digitado por min
let completePath = "/Users/ronaldogomes/Desktop/File.playground"

/*
    URL significa Uniform Resource Locator - que também pode apontar para arquivos e
    pastas locais. Em vez de https://, os URLs de arquivo local começam com file://.
 */

let completeUrl = URL(fileURLWithPath: completePath)

//Porem desta forma so funciona no meu mac, pois tem meu usuario

// Retorna a pasta URL inicial do usuário atual
let home = FileManager.default.homeDirectoryForCurrentUser

let playgroundPath = "Desktop/Files.playground"

//Adicionando o caminho path
let playgroundUrl = home.appendingPathComponent(playgroundPath)

//Algumas propiedades da url
playgroundUrl.path
playgroundUrl.absoluteString
playgroundUrl.absoluteURL
playgroundUrl.baseURL
playgroundUrl.pathComponents //Array com as strings do path
playgroundUrl.lastPathComponent
playgroundUrl.pathExtension
playgroundUrl.isFileURL

//Editando o path url

var urlForEditing = home
urlForEditing.path

urlForEditing.appendPathComponent("Desktop")
urlForEditing.path

urlForEditing.appendPathComponent("Test file")
urlForEditing.path

urlForEditing.appendPathExtension("txt")
urlForEditing.path

urlForEditing.deletePathExtension()
urlForEditing.path

urlForEditing.deleteLastPathComponent()
urlForEditing.path


//Alem de editar, podemos criar uma nova url a partir da ja existente
let fileUrl = home
.appendingPathComponent("Desktop")
.appendingPathComponent("Test File")
.appendingPathExtension("txt")
fileUrl.path

let desktopUrl = fileUrl.deletingLastPathComponent()
desktopUrl.path

//Checando se o caminho existe
let fileManager = FileManager.default
fileManager.fileExists(atPath: playgroundUrl.path) //True

let missingFile = URL(fileURLWithPath: "ThisFileNotExist")
fileManager.fileExists(atPath: missingFile.path) //False
