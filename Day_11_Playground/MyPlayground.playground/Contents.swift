import Cocoa

/// Protocols
///
/// Protocols are a way of describing what properties and methods something must have.
/// You then tell Swift which types use that protocol – a process known as
/// adopting or conforming to a protocol.
///
/// For example, we can write a function that accepts something with an id property,
/// but we don’t care precisely what type of data is used. We’ll start by creating
/// an Identifiable protocol, which will require all conforming types to have
/// an id string that can be read (“get”) or written (“set”):
///
protocol Identifiable {
    var id: String { get set }
}

/// We can’t create instances of that protocol - it’s a description of what we want,
/// rather than something we can create and use directly. But we can create a struct
/// that conforms to it:
///
struct User: Identifiable {
    var id: String
}

/// Finally, we’ll write a displayID() function that accepts any Identifiable object:
///
func displayID(thing: Identifiable) {
    print("My ID is: \(thing.id)")
}





/// Why does Swift need protocols?
///
/// Protocols let us define how structs, classes, and enums ought to work: what methods
/// they should have, and what properties they should have. Swift will enforce
/// these rules for us, so that when we say a type conforms to a protocol
/// Swift will make sure it has all the methods and properties required by that protocol.
///
/// In practice, what protocols allow us to do is treat our data in more general terms.
/// So, rather than saying “this buy() method must accept a Book object,” we can say
/// “this method can accept anything that conforms to the Purchaseable protocol.
/// That might be a book, but it might also be a movie, a car, some coffee, and so on
/// – it makes our simple method more flexible, while ensuring that
/// Swift enforces the rules for us.
///
/// In code terms, our simple buy() method that works only with books would look like this:
///
struct Book {
    var name: String
}

func buy(_ book: Book) {
    print("I'm buying \(book.name)")
}

/// To create a more flexible, protocol-based approach we would first create a protocol
/// that declares the basic functionality we need. This might be many methods and properties,
/// but here we’re just going to say that we need a name string:
///
protocol Purchaseable {
    var name: String { get set }
}

/// Now we can go ahead and define as many structs as we need, with each one
/// conforming to that protocol by having a name string:
///
/// You’ll notice each one of those types has a different property that wasn’t declared
/// in the protocol, and that’s okay – protocols determine the minimum required functionality,
/// but we can always add more.
///
struct Book2: Purchaseable {
    var name: String
    var author: String
}

struct Movie: Purchaseable {
    var name: String
    var actors: [String]
}

struct Car: Purchaseable {
    var name: String
    var manufacturer: String
}

struct Coffee: Purchaseable {
    var name: String
    var strength: Int
}

/// Finally, we can rewrite the buy() function so that it accepts any kind
/// of Purchaseable item:
///
func buy2(_ item: Purchaseable) {
    print("I'm buying: \(item.name)")
}

/// Inside that method we can use the name property of our item safely, because Swift will
/// guarantee that each Purchaseable item has a name property. It doesn’t guarantee that
/// any of the other properties we defined will exist, only the ones that are specifically
/// declared in the protocol.
///
/// So, protocols let us create blueprints of how our types share functionality, then use
/// those blueprints in our functions to let them work on a wider variety of data.
///





/// Protocol inheritance
///
/// One protocol can inherit from another in a process known as protocol inheritance.
/// Unlike with classes, you can inherit from multiple protocols at the same time
/// before you add your own customizations on top.
///
/// We’re going to define three protocols: Payable requires conforming types
/// to implement a calculateWages() method, NeedsTraining requires conforming types
/// to implement a study() method, and HasVacation requires conforming types
/// to implement a takeVacation() method:
///
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

/// We can now create a single Employee protocol that brings them together
/// in one protocol. We don’t need to add anything on top, so we’ll just
/// write open and close braces:
///
/// Now we can make new types conform to that single protocol rather than
/// each of the three individual ones.
///
protocol Employee: Payable, NeedsTraining, HasVacation {  }

struct Sales: Employee {
    var name: String
    var workingHours: Int
    
    func calculateWages() -> Int {
        return workingHours * 2500
    }
    
    func study() {
        print("Studying market share!")
    }
    
    func takeVacation(days: Int) {
        if (workingHours / days) < 7 {
            print("You can't take your vacation!")
        } else {
            print("Enjoy your vacation.")
        }
    }
}

let raymond = Sales(name: "Raymond", workingHours: 40)
print(raymond.calculateWages())
raymond.study()
raymond.takeVacation(days: 5)





/// When should we use protocol inheritance?
///
/// Swift lets us build new protocol based on existing protocols, much like the way
/// it lets us build new classes based on existing classes.
///
/// One common reason for using protocol inheritance is to combine functionality
/// for common work. For example:
/// - All products have a price and a weight
/// - All computers have a CPU, plus how much memory they have and how much storage
/// - All laptops have a screen size
///
/// You could absolutely define a Computer protocol like this:
///
protocol Computer {
    var price: Double { get set }
    var weight: Int { get set }
    var cpu: String { get set }
    var memory: Int { get set }
    var storage: Int { get set }
}

/// Then define a Laptop protocol like this:
///
protocol Laptop {
    var price: Double { get set }
    var weight: Int { get set }
    var cpu: String { get set }
    var memory: Int { get set }
    var storage: Int { get set }
    var screenSize: Int { get set }
}

/// But do you see how much duplication we already have? Now imagine working with phones
/// and tablets – more protocols, and more duplication.
///
/// It’s much simpler and more flexible if we break our protocols up into smaller parts,
/// then reassemble them like Lego bricks.
///
/// So, we could start by defining what a product looks like:
///
protocol Product {
    var price: Double { get set }
    var weight: Int { get set }
}

/// We could then define what a computer looks like, by basing it on a Product
/// then adding some extras:
///
protocol Computer2: Product {
    var cpu: String { get set }
    var memory: Int { get set }
    var storage: Int { get set }
}

/// Now we can define what a Laptop looks like, by basing it on a Computer
/// (and therefore also a Product), and adding another property:
///
protocol Laptop2: Computer2 {
    var screenSize: Int { get set }
}

struct XLaptop: Laptop2 {
    var screenSize: Int
    
    var cpu: String
    
    var memory: Int
    
    var storage: Int
    
    var price: Double
    
    var weight: Int
}

let xLaptop = XLaptop(screenSize: 14,
                      cpu: "Core 7",
                      memory: 16,
                      storage: 1024,
                      price: 2200.50,
                      weight: 2)

print(xLaptop.screenSize)
print(xLaptop.cpu)
print(xLaptop.memory)
print(xLaptop.storage)
print(xLaptop.price)
print(xLaptop.weight)
    
/// As you can see, using protocol inheritance in this way lets us share definitions
/// and reduce duplication, which is a great way to build up functionality
/// piece by piece.
///
/// The second common reason for using protocol inheritance is to add extra restrictions
/// when they make sense. For example, Swift has a protocol called Equatable, which means
/// “this thing can be checked for equality against other instances of the same type,”
/// and it’s what makes 5 == 6 return false. Swift also has a protocol called Comparable,
/// which means “this type can be checked to see whether it is less than or greater than
/// another instance of the same type,” and it’s what makes "Hello" < "World" return true.
///
/// Think about it: if we can know whether an object is less than or greater than
/// some other object, then we must also be able to know when it is the same as
/// the other object. That is, if number X is not less than number Y, and is also
/// not greater than number Y, then X and Y must be equal.
///
/// Rather than copy all the functionality of Equatable into Comparable,
/// Swift just uses protocol inheritance so that Comparable inherits from Equatable.
///





/// Extensions
///
/// Extensions allow you to add methods to existing types, to make them do things
/// they weren’t originally designed to do.
///
/// For example, we could add an extension to the Int type so that it has a squared()
/// method that returns the current number multiplied by itself:
///
extension Int {
    func squared() -> Int {
        return self * self
    }
}

/// To try that out, just create an integer and you’ll see it now has a squared() method:
///
let number = 8
print(number.squared())

/// Swift doesn’t let you add stored properties in extensions, so you must use
/// computed properties instead. For example, we could add a new isEven
/// computed property to integers that returns true if it holds an even number:
///
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

let number2 = 123
print(number2.isEven)





/// When should you use extensions in Swift?
///
/// Extensions let us add functionality to classes, structs, and more, which is helpful
/// for modifying types we don’t own – types that were written by Apple or someone else,
/// for example. Methods added using extensions are indistinguishable from methods
/// that were originally part of the type, but there is a difference for properties:
/// extensions may not add new stored properties, only computed properties.
///
/// Extensions are also useful for organizing our own code, and although there are
/// several ways of doing this I want to focus on two here: conformance grouping
/// and purpose grouping.
///
/// Conformance grouping means adding a protocol conformance to a type as an extension,
/// adding all the required methods inside that extension. This makes it easier
/// to understand how much code a developer needs to keep in their head while reading
/// an extension – if the current extension adds support for Printable,
/// they won’t find printing methods mixed in with methods from other,
/// unrelated protocols.
///
/// On the other hand, purpose grouping means creating extensions to do specific tasks,
/// which makes it easier to work with large types. For example, you might have
/// an extension specifically to handle loading and saving of that type.
///
/// It’s worth adding here that many folks realize they have a large class and
/// try to make it smaller by splitting it into extensions. To be quite clear:
/// the type is exactly the same size it was before, it’s just neatly split up.
/// This does mean it’s likely to be a little easier to understand,
/// but it doesn’t mean the class is any smaller.
///





/// Protocol extensions
///
/// Protocols let you describe what methods something should have, but don’t provide
/// the code inside. Extensions let you provide the code inside your methods,
/// but only affect one data type – you can’t add the method to lots of types
/// at the same time.
///
/// Protocol extensions solve both those problems: they are like regular extensions,
/// except rather than extending a specific type like Int you extend a whole protocol
/// so that all conforming types get your changes.
///
/// For example, here is an array and a set containing some names:
///
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry",]
let beatles = Set(["John", "Paul", "George", "Ringo"])

/// Swift’s arrays and sets both conform to a protocol called Collection,
/// so we can write an extension to that protocol to add a summarize()
/// method to print the collection neatly
///
extension Collection {
    func summarize() {
        print("There are \(count) of us: ")
        
        for name in self {
            print(name)
        }
        
        print()
    }
}

/// Both Array and Set will now have that method, so we can try it out:
///
pythons.summarize()
beatles.summarize()






/// When are protocol extensions useful in Swift?
///
/// Protocol extensions are used everywhere in Swift, which is why you’ll often see it
/// described as a “protocol-oriented programming language.” We use them to add functionality
/// directly to protocols, which means we don’t need to copy that functionality across
/// many structs and classes.
///
/// For example, Swift’s arrays have an allSatisfy() method that returns true if all
/// the items in the array pass a test. So, we could create an array of numbers
/// and check that they are all even:
///
let numbers = [4, 8, 15, 16]
print(numbers.allSatisfy { $0.isMultiple(of: 2) })

/// That’s really useful, but wouldn’t it be more useful if it also worked on sets?
/// Sure it would, and that’s why it does:
///
/// The underlying principle is identical: pass each item in the array or set through
/// a test you provide, and if that returns true for all items then the result
/// of the method is true.
///
let numbers2 = Set([4, 8, 15, 16])
print(numbers2.allSatisfy { $0.isMultiple(of: 2) })

/// How about dictionaries – can they use this too? Sure they can, and it works identically:
/// each key/value pair gets passed into the closure, and you need to return either
/// true or false. It looks like this:
///
let numbers3 = ["four": 4, "eight": 8, "fifteen": 15, "sixteen": 16]
print(numbers3.allSatisfy { $0.value.isMultiple(of: 2) })

/// Of course, the Swift developers don’t want to write this same code again and again,
/// so they used a protocol extension: they wrote a single allSatisfy() method that works
/// on a protocol called Sequence, which all arrays, sets, and dictionaries conform to.
/// This meant the allSatisfy() method immediately became available on all those types,
/// sharing exactly the same code.
///





/// Protocol-oriented programming
///
/// Protocol extensions can provide default implementations for our own protocol methods.
/// This makes it easy for types to conform to a protocol, and allows a technique called
/// “protocol-oriented programming” – crafting your code around protocols
/// and protocol extensions.
///
/// First, here’s a protocol called Identifiable that requires any conforming type to
/// have an id property and an identify() method:
///
protocol Identifiable2 {
    var id: String { get set }
    func identify() -> Void
}

/// We could make every conforming type write their own identify() method,
/// but protocol extensions allow us to provide a default:
///
extension Identifiable2 {
    func identify() {
        print("My ID is: \(id).")
    }
}

/// Now when we create a type that conforms to Identifiable it gets identify() automatically:
///
struct User2: Identifiable2 {
    var id: String
}

let anonymous = User2(id: "Anonymous")
anonymous.identify()





/// How is protocol-oriented programming different from object-oriented programming?
///
/// Many Swift developers describe the language as being protocol-oriented, but what does
/// that really mean? In particular, how is it different from the older
/// object-oriented paradigm?
///
/// Getting down to the raw facts, there is no practical difference between the two:
/// both can place functionality into objects, use access control to limit where that
/// functionality can be called, make one class inherit from another, and more.
///
/// Some might say that the only real difference between the two is that in
/// protocol-oriented programming (POP) we prefer to build functionality by composing
/// protocols (“this new struct conforms to protocols X, Y, and Z”), whereas in
/// object-oriented programming (OOP) we prefer to build functionality through
/// class inheritance. However, even that is dubious because OOP developers also
/// usually prefer composing functionality to inheriting it – it’s just easier to maintain.
///
/// In fact, the only important difference between the two is one of mindset:
/// POP developers lean heavily on the protocol extension functionality of Swift to build
/// types that get a lot of their behavior from protocols. This makes it easier to share
/// functionality across many types, which in turn lets us build bigger, more powerful
/// software without having to write so much code.
///
/// For more information about protocol-oriented programming, you should watch
/// Dave Abraham’s talk at WWDC that introduced the topic:
/// https://developer.apple.com/videos/play/wwdc2015/408/
///





/// 
