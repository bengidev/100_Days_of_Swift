import Cocoa

/// Creating your own classes
///
/// Classes are similar to structs in that they allow you to create new types
/// with properties and methods, but they have five important differences and
/// I’m going to walk you through each of those differences one at a time.
///
/// The first difference between classes and structs is that classes never come
/// with a memberwise initializer. This means if you have properties in your class,
/// you must always create your own initializer.
///
/// For example:
///
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

/// Creating instances of that class looks just the same as if it were a struct:
///
let poppy = Dog(name: "Poppy", breed: "Poodle")
print(poppy.name)
print(poppy.breed)





/// Why does Swift have both classes and structs?
///
/// Classes and structs give Swift developers the ability to create custom,
/// complex types with properties and methods, but they have five important differences:
/// - Classes do not come with synthesized memberwise initializers.
/// - One class can be built upon (“inherit from”) another class,
///     gaining its properties and methods.
/// - Copies of structs are always unique, whereas copies of classes actually point
///     to the same shared data.
/// - Classes have deinitializers, which are methods that are called when an instance
///     of the class is destroyed, but structs do not.
/// - Variable properties in constant classes can be modified freely,
///     but variable properties in constant structs cannot.
///
/// I’ll explain these differences in more detail soon, but the point is that they exist
/// and that they matter. Most Swift developers prefer to use structs rather than classes
/// when possible, which means when you choose a class over a struct you’re doing so
/// because you want one of the above behaviors.
/// 





/// Class inheritance
///
/// The second difference between classes and structs is that you can create a class
/// based on an existing class – it inherits all the properties and methods
/// of the original class, and can add its own on top.
///
/// This is called class inheritance or subclassing, the class you inherit from
/// is called the “parent” or “super” class, and the new class is called the “child” class.
///
/// Here’s the Dog class we just created:
///
class Dog2 {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

/// We could create a new class based on that one called Poodle.
/// It will inherit the same properties and initializer as Dog by default:
///
class Poodle: Dog2 {
    
}

/// However, we can also give Poodle its own initializer. We know it will always
/// have the breed “Poodle”, so we can make a new initializer that only needs a name property.
/// Even better, we can make the Poodle initializer call the Dog initializer directly
/// so that all the same setup happens:
///
/// For safety reasons, Swift always makes you call super.init() from child classes –
/// just in case the parent class does some important work when it’s created.
///
class Poodle2: Dog2 {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}





/// Why don’t Swift classes have a memberwise initializer?
///
/// One of the many useful features of Swift’s struct is that they come with
/// a synthesized memberwise initializer, letting us create new instances
/// of the struct just by specifying its properties. However, Swift’s classes
/// don’t have this feature, which is annoying – but why don’t they have it?
///
/// The main reason is that classes have inheritance, which would make
/// memberwise initializers difficult to work with. Think about it:
/// if I built a class that you inherited from, then added some properties
/// to my class later on, your code would break – all those places
/// you relied on my memberwise initializer would suddenly no longer work.
///
/// So, Swift has a simple solution: rather than automatically generating
/// a memberwise initializer, authors of classes must write their own
/// initializer by hand. This way, you can add properties as much as you want
/// without affecting the initializer for your class, and affecting others
/// who inherit from your class. And when you do decide to change your initializer,
/// you’re doing so yourself, and are therefore fully aware of the
/// implications for any inheriting classes.
///





/// Overriding methods
///
/// Child classes can replace parent methods with their own implementations –
/// a process known as overriding. Here’s a trivial Dog class with a makeNoise() method:
///
class Dog3 {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
    func makeNoise() {
        print("Woof!")
    }
}

/// If we create a new Poodle class that inherits from Dog, it will inherit the makeNoise() method.
///
/// Method overriding allows us to change the implementation of makeNoise() for the Poodle class.
///
/// Swift requires us to use override func rather than just func when overriding a method –
/// it stops you from overriding a method by accident, and you’ll get an error if you try
/// to override something that doesn’t exist on the parent class:
///
/// With that change, poppy.makeNoise() will print “Yip!” rather than “Woof!”.
///
class Poodle3: Dog3 {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
    
    override func makeNoise() {
        print("Yip!")
    }
}

let poppy2 = Poodle3(name: "Poppy2")
print(poppy2.name)
print(poppy2.breed)
poppy2.makeNoise()





/// When would you want to override a method?
///
/// In Swift, any class that inherits from a parent class can override the methods and
/// sometimes the properties of that parent class, which means they can replace
/// the parent’s method implementation with one of their own.
///
/// This level of customization is really important, and makes our lives easier as developers.
/// Think about it: if someone has designed a brilliant class that you want to use,
/// but it isn’t quite right, wouldn’t it be nice to just override one part of its behavior
/// rather than having to rewrite the whole thing yourself?
///
/// Sure it would, and that’s exactly where method overriding comes in: you can keep all
/// the behavior you want, and just change one or two little parts in a custom subclass.
///
/// In UIKit, Apple’s original user interface framework for iOS, this approach was used a lot.
/// For example, consider some of the built-in apps such as Settings and Messages.
/// Both of these present information in rows: Settings has rows such as General,
/// Control Center, Display & Brightness, and so on, and Messages has individual rows
/// for each conversation you’ve had with different people. In UIKit these are called tables,
/// and they have some common behavior: you can scroll through all the rows, you can tap
/// on the rows to select one, there are little gray arrows on the right side of the rows,
/// and so on.
///
/// These lists of rows are very common, so Apple provided us existing code to use them
/// that has all that standard behavior built right in. Of course, there are some bits
/// that actually need to change, such as how many rows the lists have and what content
/// they have inside. So, Swift developers would create subclasses of Apple’s table and
/// override the parts they wanted to change, giving them all the built-in functionality
/// and lots of flexibility and control.
///
/// Swift makes us use the override keyword before overriding functions, which is really helpful:
/// - If you use it when it isn’t needed (because the parent class doesn’t declare the same method)
///     then you’ll get an error. This stops you from mistyping things, such as parameter names
///     or types, and also stops your override from failing if the parent class
///     changes its method and you don’t follow suit.
/// - If you don’t use it when it is needed, then you’ll also get an error.
///     This stops you from accidentally changing behavior from the parent class.
///





/// Final classes
///
/// Although class inheritance is very useful – and in fact large parts of Apple’s platforms
/// require you to use it – sometimes you want to disallow other developers from building
/// their own class based on yours.
///
/// Swift gives us a final keyword just for this purpose: when you declare a class as being final,
/// no other class can inherit from it. This means they can’t override your methods
/// in order to change your behavior – they need to use your class the way it was written.
///
/// To make a class final just put the final keyword before it, like this:
///
final class Dog4 {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
    func makeNoise() {
        print("Woof!")
    }
}





/// Which classes should be declared as final?
///
/// Final classes are ones that cannot be inherited from, which means it’s not possible
/// for users of your code to add functionality or change what they have. This is
/// not the default: you must opt in to this behavior by adding the final keyword to your class.
///
/// Remember, anyone who subclasses your class can override your properties and perhaps
/// also your methods, which offers them incredible power. If you do something they don’t like,
/// bam – they can just replace that. They might still call your original method as well
/// as their replacement, but they might not.
///
/// This can be problematic: perhaps your class does something really important that mustn’t
/// be replaced, or perhaps you have clients on a support contract and you don’t want
/// them breaking the way your code works.
///
/// Much of Apple’s own code was written before Swift came along, in an earlier language
/// called Objective-C. Objective-C didn’t have great support for final classes,
/// so Apple usually resorted to large warnings on their site. For example, there’s a
/// very important class called AVPlayerViewController that is designed to play movies,
/// and its documentation page has a large yellow warning saying: “Subclassing
/// AVPlayerViewController and overriddng its methods isn’t supported, and results
/// in undefined behavior.” We don’t know why, only that we shouldn’t do it.
/// There’s another class called Timer that handles timed events like an alarm,
/// and there the warning is even simpler: “Do not subclass Timer”.
///
/// In Swift it used to be the case that final classes were more performant than non-final classes,
/// because we were providing a little bit more information about how our code would run
/// and Swift would use that to make some optimizations.
///
/// That hasn’t been true for a while, but even today I think many people instinctively declare
/// their classes as final to mean “you shouldn’t subclass from this unless I specifically allow it.”
/// I certainly do this a lot, because it’s another way I can help folks understand how my code works.
///





/// Copying objects
///
/// The third difference between classes and structs is how they are copied. When you copy a struct,
/// both the original and the copy are different things – changing one won’t change the other.
/// When you copy a class, both the original and the copy point to the same thing,
/// so changing one does change the other.
///
/// For example, here’s a simple Singer class that has a name property with a default value:
///
class Singer {
    var name = "Taylor Swift"
}

/// If we create an instance of that class and prints its name, we’ll get “Taylor Swift”:
///
var singer = Singer()
print(singer.name)

/// Now let’s create a second variable from the first one and change its name:
///
var singerCopy = singer
singerCopy.name = "Justin Bieber"

/// Because of the way classes work, both singer and singerCopy point to the same object in memory,
/// so when we print the singer name again we’ll see “Justin Bieber”:
///
print(singer.name)
print(singerCopy.name)

/// On the other hand, if Singer were a struct then we would get “Taylor Swift” printed a second time:
///
struct Singer2 {
    var name = "Taylor Swift"
}

var singer2 = Singer2()
print(singer2.name)

var singerCopy2 = singer2
singerCopy2.name = "Justin Bieber"

print(singer2.name)
print(singerCopy2.name)





/// Why do copies of a class share their data?
///
/// One feature of Swift that is truly confusing at first is how the behaviors of its classes
/// and structs differ when they are copied: copies of the same class share their underlying data,
/// meaning that changing one changes them all, whereas structs always have their own unique data,
/// and changing a copy does not affect the others.
///
/// The technical term for this distinction is “value types vs reference types.” Structs are value types,
/// which means they hold simple values such as the number 5 or the string “hello”. It doesn’t matter
/// how many properties or methods your struct has, it’s still considered one simple value like a number.
/// On the other hand, classes are reference types, which means they refer to a value somewhere else.
///
/// For value types, this is easy enough to understand that it’s self-evident.
/// For example, look at this code:
///
/// When that code runs, message will still be set to “Welcome”, but greeting will be set to “Hello”.
/// As Chris Eidhof says, “this is so natural it seems like stating the obvious.”
/// (https://chris.eidhof.nl/post/structs-and-mutation-in-swift/) But that’s how structs behave:
/// their value are wholly contained inside their variable, and not somehow shared with other values.
/// This means all their data is stored directly in each variable,
/// so when you copy it you get a deep copy of all the data.
///
var message = "Welcome"
var greeting = message
greeting = "Hello"

/// In contrast, the best way to think about a reference type is that it’s like a signpost
/// pointing to some data. If we create an instance of a class, it will take up some memory
///  on your iPhone, and the variable that stores the instance is really just a signpost
///  to the actual memory where the object lives. If you take a copy of the object,
///  you get a new signpost but it still points to the memory where the original object lives.
///  This is why changing one instance of a class changes them all: all copies of the object
///  are signposts pointing to the same piece of memory.
///
///  It’s hard to overestimate how important this difference is in Swift development.
///  Previously I mentioned that Swift developers prefer to use structs for their custom types,
///  and this copy behavior is a big reason. Imagine if you had a big app and wanted to share
///  a User object in various places – what would happen if one of those places changed your user?
///  If you were using a class, all the other places that used your user would have their data
///  changed without realizing it, and you might end up with problems. But if you were using a struct,
///  every part of your app has its own copy of the data and it can’t be changed by surprise.
///
///  As with many things in programming, the choices you make should help convey a little of your reasoning.
///  In this case, using a class rather than a struct sends a strong message that you want the data
///  to be shared somehow, rather than having lots of distinct copies.
///





/// Deinitializers
///
/// The fourth difference between classes and structs is that classes can have deinitializers –
/// code that gets run when an instance of a class is destroyed.
///
/// To demonstrate this, here’s a Person class with a name property, a simple initializer,
/// and a printGreeting() method that prints a message:
///
/// And now for the deinitializer. This will be called when the Person instance is being destroyed:
///
class Person {
    var name = "John Doe"
    
    init() {
        print("\(name) is alive!")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
}

/// We’re going to create a few instances of the Person class inside a loop,
/// because each time the loop goes around a new person will be created then destroyed:
///
for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}





/// Why do classes have deinitializers and structs don’t?
///
/// One small but important feature of classes is that they can have a deinitializer function –
/// a counterpart to init() that gets run when the class instance gets destroyed.
/// Structs don’t have deinitializers, which means we can’t tell when they are destroyed.
///
/// The job of deinitializers is to tell us when a class instance was destroyed. For structs
/// this is fairly simple: the struct is destroyed when whatever owns it no longer exists.
/// So, if we create a struct inside a method and the methods ends, the struct is destroyed.
///
/// However, classes have complex copying behavior that means several copies of the class
/// can exist in various parts of your program. All the copies point to the same underlying data,
/// and so it’s now much harder to tell when the actual class instance is destroyed –
/// when the final variable pointing to it has gone away.
///
/// Behind the scenes Swift performs something called automatic reference counting, or ARC.
/// ARC tracks how many copies of each class instance exists: every time you take a copy
/// of a class instance Swift adds 1 to its reference count, and every time a copy is destroyed
/// Swift subtracts 1 from its reference count. When the count reaches 0 it means no one refers
/// to the class any more, and Swift will call its deinitializer and destroy the object.
///
/// So, the simple reason for why structs don’t have deinitializers is because they don’t need them:
/// each struct has its own copy of its data, so nothing special needs to happen when it is destroyed.
///
/// You can put your deinitializer anywhere you want in your code, but I love this quote
/// from Anne Cahalan: “Code should read like sentences, which makes me think my classes
/// should read like chapters. So the deinitializer goes at the end, it's the ~fin~ of the class!”
///





/// Mutability
///
/// The final difference between classes and structs is the way they deal with constants.
/// If you have a constant struct with a variable property, that property can’t be changed
/// because the struct itself is constant.
///
/// However, if you have a constant class with a variable property, that property can be changed.
/// Because of this, classes don’t need the mutating keyword with methods that change properties;
/// that’s only needed with structs.
///
/// This difference means you can change any variable property on a class even when the class
/// is created as a constant – this is perfectly valid code:
///
class Singer3 {
    var name = "Taylor Swift"
}

let taylor = Singer3()
print(taylor.name)
taylor.name = "Ed Sheeran"
print(taylor.name)

/// If you want to stop that from happening you need to make the property constant:
///
class Singer4 {
    let name = "Taylor Swift"
}

let taylor2 = Singer4()
print(taylor2.name)





/// Why can variable properties in constant classes be changed?
///
/// One of the small but important differences between structs and classes
/// is the way they handle mutability of properties:
/// - Variable classes can have variable properties changed
/// - Constant classes can have variable properties changed
/// - Variable structs can have variable properties changed
/// - Constant structs cannot have variable properties changed
///
/// The reason for this lies in the fundamental difference between a class and a struct:
/// one points to some data in memory, whereas the other is one value such as the number 5.
///
/// Consider code such as this:
///
var number = 5
number = 6

/// We can’t simply define the number 5 to be 6, because that wouldn’t make sense –
/// it would break everything we know about mathematics. Instead, that code removes
/// the existing value assigned to number and gives it the number 6 instead.
///
/// That’s how structs work in Swift: when we change one of its properties, we are in fact
/// changing the entire struct. Sure, behind the scenes Swift can do some optimization
/// so that it isn’t really throwing away the whole value every time we change
/// just one part of it, but that’s how it’s treated from our perspective.
///
/// So, if changing one part of a struct effectively means destroying and recreating
/// the entire struct, hopefully you can see why constant structs don’t allow
/// their variable properties to be changed – it would mean destroying and
/// recreating something that is supposed to be constant, which isn’t possible.
///
/// Classes don’t work this way: you can change any part of their properties
/// without having to destroy and recreate the value. As a result,
/// constant classes can have their variable properties changed freely.
///





/// 


