import Cocoa

/// Creating your own structs
///
/// Swift lets you design your own types in two ways, of which the most common
/// are called structures, or just structs. Structs can be given their own variables
/// and constants, and their own functions, then created and used however you want.
///
/// Let’s start with a simple example: we’re going to create a Sport struct that stores
/// its name as a string. Variables inside structs are called properties,
/// so this is a struct with one property:
///
struct Sport {
    var name: String
}

/// That defines the type, so now we can create and use an instance of it:
///
var tennis = Sport(name: "Tennis")
print(tennis.name)

/// We made both name and tennis variable, so we can change them just like regular variables:
///
/// Properties can have default values just like regular variables, and you can usually rely
/// on Swift’s type inference.
///
tennis.name = "Lawn Tennis"





/// What’s the difference between a struct and a tuple?
///
/// Swift’s tuples let us store several different named values inside a single variable,
/// and a struct does much the same – so what’s the difference,
/// and when should you choose one over the other?
///
/// When you’re just learning, the difference is simple: a tuple is effectively just a struct
/// without a name, like an anonymous struct. This means you can define it as (name: String,
/// age: Int, city: String) and it will do the same thing as the following struct:
///
struct User {
    var name: String
    var age: Int
    var city: String
}

/// However, tuples have a problem: while they are great for one-off use, particularly
/// when you want to return several pieces of data from a single function,
/// they can be annoying to use again and again.
///
/// Think about it: if you have several functions that work with user information,
/// would you rather write this:
///
func authenticate(_ user: User) {  }
func showProfile(for user: User) {  }
func signOut(_ user: User) {  }

/// Or this:
///
func authenticate1(_ user: (name: String, age: Int, city: String)) {  }
func showProfile1(for user: (name: String, age: Int, city: String)) {  }
func signOut1(_ user: (name: String, age: Int, city: String)) {  }

/// Think about how hard it would be to add a new property to your User struct
/// (very easy indeed), compared to how hard it would be to add another value
/// to your tuple everywhere it was used? (Very hard, and error-prone!)
///
/// So, use tuples when you want to return two or more arbitrary pieces of values
/// from a function, but prefer structs when you have some fixed data
/// you want to send or receive multiple times.
///





/// Computed properties
///
/// We just created a Sport struct like this:
///
/// That has a name property that stores a String. These are called stored properties,
/// because Swift has a different kind of property called a computed property –
/// a property that runs code to figure out its value.
///
struct Sport1 {
    var name: String
}

/// We’re going to add another stored property to the Sport struct,
/// then a computed property. Here’s how that looks:
///
/// As you can see, olympicStatus looks like a regular String, but it returns
/// different values depending on the other properties.
///
struct Sport2 {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic Sport)"
        } else {
            return "\(name) is not an Olympic Sport)"
        }
    }
}

/// We can try it out by creating a new instance of Sport:
///
let chessBoxing = Sport2(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)





/// When should you use a computed property or a stored property?
///
/// Properties let us attach information to structs, and Swift gives us two variations:
/// stored properties, where a value is stashed away in some memory to be used later,
/// and computed properties, where a value is recomputed every time it’s called.
/// Behind the scenes, a computed property is effectively just a function call
/// that happens to belong to your struct.
///
/// Deciding which to use depends partly on whether your property’s value depends on other data,
/// and partly also on performance. The performance part is easy: if you regularly
/// read the property when its value hasn’t changed, then using a stored property
/// will be much faster than using a computed property. On the other hand, if your property
/// is read very rarely and perhaps not at all, then using a computed property saves you
/// from having to calculate its value and store it somewhere.
///
/// When it comes to dependencies – whether your property’s value relies on the values
/// of your other properties – then the tables are turned: this is a place where
/// computed properties are useful, because you can be sure the value they return
/// always takes into account the latest program state.
///
/// Lazy properties help mitigate the performance issues of rarely read stored properties,
/// and property observers mitigate the dependency problems of stored properties –
/// we’ll be looking at them soon.
///





/// Property observers
///
/// Property observers let you run code before or after any property changes.
/// To demonstrate this, we’ll write a Progress struct that tracks a task
/// and a completion percentage:
///
struct Progress {
    var task: String
    var amount: Int
}

/// We can now create an instance of that struct and adjust its progress over time:
///
var progress = Progress(task: "Loading data...", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

/// What we want to happen is for Swift to print a message every time amount changes,
/// and we can use a didSet property observer for that. This will run some code
/// every time amount changes:
///
/// You can also use willSet to take action before a property changes,
/// but that is rarely used.
///
struct Progress1 {
    var task: String
    var amount: Int {
        willSet {
            print("\(task) will change to \(amount)% complete")
        }
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress1 = Progress1(task: "Loading data...", amount: 0)
progress1.amount = 30
progress1.amount = 80
progress1.amount = 100





/// When should you use property observers?
///
/// Swift’s property observers let us attach functionality to be run before
/// or after a property is changed, using willSet and didSet respectively.
/// Most of the time property observers aren’t required, just nice to have –
/// we could just update a property normally then call a function ourselves in code.
/// So why bother? When would you actually use property observers?
///
/// The most important reason is convenience: using a property observer means
/// your functionality will be executed whenever the property changes.
/// Sure, you could use a function to do that, but would you remember? Always?
/// In every place you change the property?
///
/// This is where the function approach goes sour: it’s on you to remember to call
/// that function whenever the property changes, and if you forget then you’ll
/// have mysterious bugs in your code. On the other hand, if you attach
/// your functionality directly to the property using didSet, it will always happen,
/// and you’re transferring the work of ensuring that to Swift so your brain
/// can focus on more interesting problems.
///
/// There is one place where using a property observer is a bad idea, and that’s if
/// you put slow work in there. If you had a User struct with an age integer,
/// you would expect that changing age would take place virtually instantly –
/// it’s just a number, after all. If you attach a didSet property observer
/// that does all sorts of slow work, then suddenly changing a single integer
/// could take way longer than you expected, and it could cause all sorts of problems for you.
///





/// When should you use willSet rather than didSet?
///
/// Both willSet and didSet let us attach observers to properties, meaning that
/// Swift will run some code when they change so that we have a chance to respond
/// to the change. The question is: do you want to know before the property changes, or after?
///
/// The simple answer is this: most of the time you will be using didSet, because
/// we want to take action after the change has happened so we can update our user interface,
/// save changes, or whatever. That doesn’t mean willSet isn’t useful, it’s just that
/// in practice it is significantly less popular than its counterpart.
///
/// The most common time willSet is used is when you need to know the state of your program
/// before a change is made. For example, SwiftUI uses willSet in some places to handle
/// animations so that it can take a snapshot of the user interface before a change.
/// When it has both the “before” and “after” snapshot, it can compare the two to see
/// all the parts of the user interface that need to be updated.
///





/// Methods
///
/// Structs can have functions inside them, and those functions can use the properties
/// of the struct as they need to. Functions inside structs are called methods,
/// but they still use the same func keyword.
///
/// We can demonstrate this with a City struct. This will have a population property
/// that stores how many people are in the city, plus a collectTaxes() method that returns
/// the population count multiplied by 1000. Because the method belongs to City it can read
/// the current city’s population property.
///
/// Here’s the code:
///
struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
}

/// That method belongs to the struct, so we call it on instances of the struct like this:
///
let london = City(population: 9_000_000)
print(london.collectTaxes())





/// What’s the difference between a function and a method?
///
/// Swift’s functions let us name a piece of functionality and run it repeatedly,
/// and Swift’s methods do much the same thing, so what’s the difference?
///
/// Honestly, the only real difference is that methods belong to a type, such as structs,
/// enums, and classes, whereas functions do not. That’s it – that’s the only difference.
/// Both can accept any number of parameters, including variadic parameters, and both
/// can return values. Heck, they are so similar that Swift still uses the func keyword
/// to define a method.
///
/// Of course, being associated with a specific type such as a struct means that methods
/// gain one important super power: they can refer to the other properties and methods
/// inside that type, meaning that you can write a describe() method for a User type
/// that prints the user’s name, age, and city.
///
/// There is one more advantage to methods, but it’s quite subtle: methods avoid
/// namespace pollution. Whenever we create a function, the name of that function starts
/// to have meaning in our code – we can write wakeUp() and have it do something.
/// So, if you write 100 functions you end up with 100 reserved names,
/// and if you write 1000 functions you have 1000 reserved names.
///
/// That can get messy quickly, but by putting functionality into methods we restrict
/// where those names are available – wakeUp() isn’t a reserved name any more unless
/// we specifically write someUser.wakeUp(). This reduces the so-called pollution,
/// because if most of our code is in methods then we won’t get name clashes by accident.
///





/// Mutating methods
///
/// If a struct has a variable property but the instance of the struct was created
/// as a constant, that property can’t be changed – the struct is constant,
/// so all its properties are also constant regardless of how they were created.
///
/// The problem is that when you create the struct Swift has no idea whether you will use it
/// with constants or variables, so by default it takes the safe approach: Swift won’t let you
/// write methods that change properties unless you specifically request it.
///
/// When you want to change a property inside a method, you need to mark it
/// using the mutating keyword, like this:
///
struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

/// Because it changes the property, Swift will only allow that method to be called
/// on Person instances that are variables:
///
var person = Person(name: "Ed")
print(person.name)
person.makeAnonymous()
print(person.name)





/// Why do we need to mark some methods as mutating?
///
/// It’s possible to modify the properties of a struct, but only if that struct
/// is created as a variable. Of course, inside your struct there’s no way of telling
/// whether you’ll be working with a variable struct or a constant struct,
/// so Swift has a simple solution: any time a struct’s method tries to change
/// any properties, you must mark it as mutating.
///
/// You don’t need to do anything else other than mark the method as mutating,
/// but doing that gives Swift enough information to stop that method from being
/// used with constant struct instances.
///
/// There are two important details you’ll find useful:
/// - Marking methods as mutating will stop the method from being called on constant structs,
///     even if the method itself doesn’t actually change any properties.
///     If you say it changes stuff, Swift believes you!
/// - A method that is not marked as mutating cannot call a mutating function –
///     you must mark them both as mutating.
///





/// Properties and methods of strings
///
/// We’ve used lots of strings so far, and it turns out they are structs – they have
/// their own methods and properties we can use to query and manipulate the string.
///
/// First, let’s create a test string:
///
let string = "Do or do not, there is no try. "

/// You can read the number of characters in a string using its count property:
///
print(string.count)

/// They have a hasPrefix() method that returns true if the string starts with specific letters:
///
print(string.hasPrefix("Do"))

/// You can uppercase a string by calling its uppercased() method:
///
print(string.uppercased())

/// And you can even have Swift sort the letters of the string into an array:
///
print(string.sorted())

/// Strings have lots more properties and methods – try typing string.
/// to bring up Xcode’s code completion options.
///





/// Why are strings structs in Swift?
///
/// In many other languages, strings aren’t structs – they are just a sequence of letters,
/// and nothing more. Swift takes a different approach: strings are structs, and in fact
/// come packed with functionality.
///
/// Almost all of Swift’s core types are implemented as structs, including strings,
/// integers, arrays, dictionaries, and even Booleans. This isn’t an accident: structs are simple,
/// fast, and efficient in Swift, which means we can create and destroy them as much as we need
/// without worrying too much about performance.
///
/// However, strings are a particularly complicated problem to solve because language is complex.
/// Yes, things like the English alphabet takes just 26 lowercase and 26 uppercase characters,
/// but Swift also needs to be able to handle other scripts – Hebrew, Arabic, Cyrillic, Tamil,
/// and many more. Heck, there are over 50,000 Chinese characters!
///
/// Where things get really complex is how we handle emoji, because there are countless variations
/// for skin tone and gender. Rather than storing each emoji as a unique “letter”, these often
/// broken down into multiple special letters. For example, the emoji “two women holding hands,
/// where the the left woman has light skin tone and the right woman has medium-dark skin tone,”
/// Swift actually stores:
/// - Woman
/// - Light skin tone
/// - Joined to
/// - Shaking hands
/// - Joined to
/// - Woman
/// - Medium-dark skin tone
///
/// So, we actually use seven “letters” to store one emoji in that instance – it’s complicated!
///
/// As a result, Swift encapsulates all the functionality to handle strings into the string themselves.
/// This means we can use functionality such as the count property without worrying about it
/// miscounting emoji. The alternative would be to have hundreds of standalone functions to handle
/// strings and their complexities, which wouldn’t be pleasant.
///
/// Now you understand some of the complexities of strings, take another look
/// at these properties and methods:
///
print(string.count)
print(string.hasPrefix("Hello"))
print(string.uppercased())
print(string.sorted())

/// I hope you can see they do a heck of a lot of work on our behalf! Sorting a string with emoji
/// would cause all sorts of problems if the individual characters inside the emoji were pulled apart.
/// Fortunately, Swift’s strings are designed to take care of all this work for us, and although
/// it causes a few road bumps here and there the overall benefit is massive.
///





/// Properties and methods of arrays
///
/// Arrays are also structs, which means they too have their own methods and properties we can use
/// to query and manipulate the array.
///
/// Here’s a simple array to get us started:
///
var toys = ["Woody"]

/// You can read the number of items in an array using its count property:
///
print(toys.count)

/// If you want to add a new item, use the append() method like this:
///
toys.append("Buzz")

/// You can locate any item inside an array using its firstIndex() method, like this:
///
/// That will return 1 because arrays count from 0.
///
toys.firstIndex(of: "Buzz")

/// Just like with strings, you can have Swift sort the items of the array alphabetically:
///
print(toys.sorted())

/// Finally, if you want to remove an item, use the remove() method like this:
///
toys.remove(at: 0)

/// Arrays have lots more properties and methods – try typing toys.
/// to bring up Xcode’s code completion options.
///





/// Why do strings behave differently from arrays in Swift?
///
/// If you think about it, strings are really just lots of individual characters
/// that come together to form text: “Hello”, for example. But whereas Swift lets us
/// read array values using myArray[3], we can’t do the same with strings –
/// myString[3] is invalid.
///
/// The reason for this goes back to emoji and other similarly complex characters,
/// which are made up of multiple special characters back to back. Although they are
/// individual letters, they must be treated as one cohesive unit: we can’t take just
/// part of an emoji, because it wouldn’t make sense. For example, the US flag
/// is made up of the characters “Regional indicator symbol letter U” and
/// “Regional indicator symbol letter S”, which, when put together,
/// are interpreted as the United States flag.
///
/// Those two characters can’t be pulled apart individually – if you read the
/// first character of the string, you wouldn’t want to get back
/// “Regional indicator symbol letter U”, or half the US flag, or something weird.
/// Instead, both of them need to be kept together in order for the emoji to make sense.
///
/// What this means is that if you have a string containing four emoji,
/// it’s possible your string contains 10 or even 20 of these special symbols.
/// Many of them are likely meaningless to humans by themselves, and only have
/// the correct emoji meaning when joined with the other special symbols around them.
///
/// Now think about trying to read the fourth character of a string using something like
/// myString[3]. If I wrote out a string on some graph paper, one letter per box, and
/// asked you to jump to the fourth letter, you could just count along four boxes and
/// you’d be there – you wouldn’t actually need to know how many letters were in each box.
/// And that system scales beautifully: if our graph paper had 50 boxes per page,
/// and I asked you to read letter 50,000, you could literally skip over hundreds of pages
/// without even counting the boxes, because you know there’s always exactly one letter
/// per box and 50 boxes per page.
///
/// Now imagine I said to you that actually only some letters took up one box on the grid paper.
/// Some took up two boxes, some three, some four, some five and some even more than that.
/// How would you find letter 50,000 now?
///
/// The answer is that you’d need to start at the very first letter, then move along box by box,
/// one by one, checking every box to see whether it contained a letter by itself or
/// was one special character that was part of a larger letter.
///
/// Well, this little thought experiment is actually exactly how Swift works: if you ask
/// for character 50,000 in a string, it needs to start at the very beginning and
/// count all the way through letter by letter until it finds the one you want.
/// It’s slow, and gets slower the further through a string you want to read.
///
/// And so the Swift team made a decision: yes, they absolutely could make myString[49999] work,
/// but if they did that you might think the code was easy. So, they specifically made that
/// functionality unavailable so that folks wouldn’t write it by accident and
/// wonder why their code was slow.
///
/// In case you were curious, arrays don’t have the same problem, because they store everything
/// in a box that’s exactly the same size. This is because their usage is very different from strings:
/// we nearly always use strings in their entirety, whereas it’s more common to read
/// individual items from an array.
///
/// Before I’m done, I want to add one thing that might not have occurred to you:
/// if you want to check whether a string is empty, you should write this:
///
var myString = ""

if myString.isEmpty {  }

/// And not this:
///
if myString.count == 0 {  }

/// The first code can return true if the string has any letters, but the second has to count
/// all the letters in the string – has to go through all the boxes in our grid paper –
/// just to compare that final number against 0.
///
/// If you’d like more detail on this topic, I have a blog post that will help:
/// https://www.hackingwithswift.com/articles/181/why-using-isempty-is-faster-than-checking-count-0
///
