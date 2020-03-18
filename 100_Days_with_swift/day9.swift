//Initializers
//Toda struct tem um inicializador default
//Porem podemos especificar o inicializador
struct User {
    var username: String
    //Inicializador
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}
//Dessa forma nao precisamos passar a variavel na criação da struct
var user = User()
user.username = "twostraws"

//Self é usado para diferenciar as variaveis de propiedades em structs
//Podemos armazenar uma struct dentro da outra omo propiedade
//Lazy properties informa que a propriedade so sera executada se for chamada
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}
struct Person {
    var name: String
    lazy var familyTree = FamilyTree()
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}
var ed = Person(name: "Ed")
print(ed.familyTree) //Somente assim ela é acessada
//Metodos static sao da propia struct e nao somente das instancias
struct Student {
    //Muda a cada instancia criada
    static var classSize = 0
    var name: String
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}
var edi = Student(name: "Ed")
let taylor = Student(name: "Taylor")
print(Student.classSize) //Precisamos chama-las atraves de student
//pois pertence a struct
//Metodos private ocultam variaveis
//So podem ser usadas dentro da struct
struct Pessoa {
    private var id: String
    init(id: String) {
        self.id = id
    }
    func identify() -> String {
        return "My social security number is \(id)"
    }
}
let jo = Pessoa(id: "12345")
print(jo.identify())