import Cocoa

/// Handling missing data
///
/// We’ve used types such as Int to hold values like 5. But if you wanted to store an
/// age property for users, what would you do if you didn’t know someone’s age?
///
/// You might say “well, I’ll store 0”, but then you would get confused between
/// new-born babies and people whose age you don’t know. You could use a special number
/// such as 1000 or -1 to represent “unknown”, both of which are impossible ages,
/// but then would you really remember that number in all the places it’s used?
///
/// Swift’s solution is called optionals, and you can make optionals out of any type.
/// An optional integer might have a number like 0 or 40, but it might have no value at all
/// – it might literally be missing, which is nil in Swift.
///
/// To make a type optional, add a question mark after it. For example,
/// we can make an optional integer like this:
///
var age: Int? = nil

/// That doesn’t hold any number – it holds nothing. But if we later learn that age,
/// we can use it:
///
age = 38





/// Why does Swift have optionals?
///
/// Swift’s optionals are one of its most powerful features, while also being one
/// of the most confusing. Their core job is simple: they allow us to represent
/// the absence of some data – a string that isn’t just empty, but literally doesn’t exist.
///
/// Any data type can be optional in Swift:
/// - An integer might be 0, -1, 500, or any other range of numbers.
/// - An optional integer might be all the regular integer values, but also might be nil –
///     it might not exist.
/// - A string might be “Hello”, it might be the complete works of Shakespeare,
///     or it might be “” – an empty string.
/// - An optional string might be any regular string value, but also might be nil.
/// - A custom User struct could contain all sorts of properties that describe a user.
/// - An optional User struct could contain all those same properties, or not exist at all.
///
/// Making that distinction between “it could be any possible value for that type” and
/// “it could be nil” is the key to understanding optionals, and it’s not easy sometimes.
///
/// For example, think about Booleans: they can be true or false. That means an optional
/// Bool can be true, false, or neither – it can be nothing at all. That’s a little hard
/// to grasp mentally, because surely something is always true or false at any given time?
///
/// Well, answer me this: do I like chocolate? Unless you’re a friend of mine or perhaps
/// follow me very closely on Twitter, you can’t say for sure – you can’t definitely say True
/// (I like chocolate) or False (I don’t like chocolate), because you just don’t know.
/// Sure, you could ask me and find out, but until you do so the only safe answer is
/// “I don’t know”, which in this case could be represented by making the Boolean
/// an optional with a nil value.
///
/// This is also a bit confusing when you think about empty strings, “”. That string
/// contains nothing, but that isn’t the same thing as nil – an empty string
/// is still a string.
///
/// When you’re learning, optionals can feel really painful – you might think Swift doesn’t
/// need them, you might think they just get in the way, and you might grind your teeth
/// every time you have to use them. But please trust me on this: after a few months
/// they will make perfect sense, and you’ll wonder how you survived without them!
///
/// For another perspective on optionals, check out this video from Brian Voong:
/// https://www.youtube.com/watch?v=7a7As0uNWOQ
///





/// Unwrapping optionals
///
/// Optional strings might contain a string like “Hello” or they might be nil – nothing at all.
///
/// Consider this optional string:
///
var name: String? = nil

/// What happens if we use name.count? A real string has a count property that stores
/// how many letters it has, but this is nil – it’s empty memory, not a string,
/// so it doesn’t have a count.
///
/// Because of this, trying to read name.count is unsafe and Swift won’t allow it.
/// Instead, we must look inside the optional and see what’s there –
/// a process known as unwrapping.
///
/// A common way of unwrapping optionals is with if let syntax, which unwraps
/// with a condition. If there was a value inside the optional then you can use it,
/// but if there wasn’t the condition fails.
///
/// For example:
/// If name holds a string, it will be put inside unwrapped as a regular String and
/// we can read its count property inside the condition. Alternatively,
/// if name is empty, the else code will be run.
///
if let unwrapped = name {
    print("\(unwrapped.count) letters.")
} else {
    print("Missing name.")
}





/// Why does Swift make us unwrap optionals?
///
/// Swift’s optionals can either store a value, such as 5 or “Hello”, or they might be
/// nothing at all. As you might imagine, trying to add two numbers together is only
/// possible if the numbers are actually there, which is why Swift won’t let us try
/// to use the values of optionals unless we unwrap them – unless we look inside
/// the optional, check there’s actually a value there, then take the value out for us.
///
/// There are several ways of doing this in Swift, but one of the most common is if let,
/// like this:
///
func getUsername() -> String? {
    return "Taylor"
}

if let username = getUsername() {
    print("Username is: \(username)")
} else {
    print("No username")
}

/// The getUsername() function returns an optional string, which means it could be a string
/// or it could be nil. I’ve made it always return a value here to make it easier
/// to understand, but that doesn’t change what Swift thinks – it’s still an optional string.
///
/// That single if let line combines lots of functionality:
/// - It calls the getUsername() function.
/// - It receives the optional string back from there.
/// - It looks inside the optional string to see whether it has a value.
/// - As it does have a value (it’s “Taylor”), that value will be taken out of the optional
///     and placed into a new username constant.
/// - The condition is then considered true, and it will print “Username is Taylor”.
///
/// So, if let is a fantastically concise way of working with optionals,
/// taking care of checking and extracting values all at once.
///
/// In fact, it’s so concise it even gives us a little shortcut. Rather than writing this:
///
extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number: Int? = 8

if let number = number {
    print(number.squared())
}

/// We can actually write this:
///
if let number {
    print(number.squared())
}

/// It does exactly the same thing – it creates a shadowed copy of number that is unwrapped
/// only inside that condition’s body, just with a bit less repetition.
///
/// The single most important feature of optionals is that Swift won’t let us use them
/// without unwrapping them first. This provides a huge amount of protection for all
/// our apps, because it puts a stop to uncertainty: when you’re handing a string you know
/// it’s a valid string, when you call a function that returns an integer, you know it’s
/// immediately safe to use. And when you do have optionals in your code, Swift will always
/// make sure you handle them correctly – that you check and unwrap them, rather than just
/// mixing unsafe values with known safe data.
///





/// Unwrapping with guard
///
/// An alternative to if let is guard let, which also unwraps optionals. guard let will
/// unwrap an optional for you, but if it finds nil inside it expects you to exit
/// the function, loop, or condition you used it in.
///
/// However, the major difference between if let and guard let is that your unwrapped
/// optional remains usable after the guard code.
///
/// Let’s try it out with a greet() function. This will accept an optional string
/// as its only parameter and try to unwrap it, but if there’s nothing inside
/// it will print a message and exit. Because optionals unwrapped using guard let
/// stay around after the guard finishes, we can print the unwrapped string
/// at the end of the function:
///
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("Hello, \(unwrapped)!")
}

/// Using guard let lets you deal with problems at the start of your functions,
/// then exit immediately. This means the rest of your function is the happy path –
/// the path your code takes if everything is correct.
///





/// When to use guard let rather than if let
///
/// Swift gives us an alternative to if let called guard let, which also unwraps
/// optionals if they contain a value, but works slightly differently:
/// guard let is designed to exit the current function, loop, or condition
/// if the check fails, so any values you unwrap using it
/// will stay around after the check.
///
/// To demonstrate the difference, here’s a function that returns
/// the meaning of life as an optional integer:
///
func getMeaningOfLife() -> Int? {
    return 42
}

/// And here’s that function being used inside another function,
/// called printMeaningOfLife():
///
/// That uses if let, so that the result of getMeaningOfLife() will only be printed
/// if it returned an integer rather than nil.
///
func printMeaningOfLife() {
    if let name = getMeaningOfLife() {
        print(name)
    }
}

/// If we had written that using guard let, it would look like this:
///
func printMeaningOfLife2() {
    guard let name = getMeaningOfLife() else { return }
    
    print(name)
}

printMeaningOfLife()
printMeaningOfLife2()

/// Yes, that’s a little longer, but two important things have changed:
/// - It lets us focus on the “happy path” – the behavior of our function when everything
///     has gone to plan, which is to print the meaning of life.
/// - guard requires that we exit the current scope when it’s used, which in this case
///     means we must return from the function if it fails. This is not optional:
///     Swift won’t compile our code without the return.
///
/// It’s common to see guard used one or more times at the start of methods,
/// because it’s used to verify some conditions are correct up front.
/// This makes our code easier to read than if we tried to check a condition then
/// run some code, then check another condition and run some different code.
///
/// So, use if let if you just want to unwrap some optionals, but prefer guard let
/// if you’re specifically checking that conditions are correct before continuing.
///





/// Force unwrapping
///
/// Optionals represent data that may or may not be there, but sometimes you know for sure
/// that a value isn’t nil. In these cases, Swift lets you force unwrap the optional:
/// convert it from an optional type to a non-optional type.
///
/// For example, if you have a string that contains a number, you can convert it
/// to an Int like this:
///
let str = "5"
let num = Int(str)

/// That makes num an optional Int because you might have tried to convert a string like
/// “Fish” rather than “5”.
///
/// Even though Swift isn’t sure the conversion will work, you can see the code is safe
/// so you can force unwrap the result by writing ! after Int(str), like this:
///
let str2 = "5"
let num2 = Int(str2)!

/// Swift will immediately unwrap the optional and make num a regular Int rather than an Int?.
///  But if you’re wrong – if str was something that couldn’t be converted to an integer –
///  your code will crash.
///
///  As a result, you should force unwrap only when you’re sure it’s safe –
///  there’s a reason it’s often called the crash operator.
///





/// When should you force unwrap optionals in Swift?
///
/// Optionals provide us with safety in Swift by stopping us from accessing data
/// that doesn’t exist. However, in a handful of circumstances you might want to consider
/// force unwrapping the optionals rather than using if let or similar.
///
/// Remember, what you don’t want to do is risk a crash – you don’t want to force unwrap
/// an optional only to find that it’s nil. That might save you a line or two of code,
/// but “that should never crash” isn’t a good enough reason for a force unwrap,
/// and we can all do better.
///
/// I’m going to go into more detail in a moment, but I want to give you some examples of code
/// that I’m happy to force unwrap and code that should not be force unwrapped. These examples
/// are drawn from real-world Apple APIs that you might not have met yet, but that’s OK –
/// you’ll get the idea.
///
/// First, this code creates a URL from a string:
///
let url = URL(string: "https://www.apple.com")!

/// That is a hand-typed URL and I have verified that it’s correct, I’m happy to
/// force unwrap it. This cannot go wrong at runtime, and there is no scope for surprises.
/// Compare that to using string interpolation:
///
/// That isn’t safe, and can’t be verified, and if given a malformed web address could crash.
///
let website = ""
let url2 = URL(string: "https://www.\(website)")!

/// Second, this code creates a closed range from 1 through 10, then picks a random number
/// from that range using the randomElement() method:
///
let randomNumber = (1...10).randomElement()!

/// randomElement() returns an optional value because it’s possible the range or array
/// we’re using it with was empty. In this case, though, you can see that I’ve hand-typed
/// the range so I know there will always be a number coming back, and again this cannot
/// go wrong at runtime. Compare that to using an unknown array:
///
/// What does that isLuckyNumber() function do? I haven’t included it here because
/// it doesn’t really matter, but it’s still some code that isn’t visible right here
/// so we can’t guarantee that items will have any items by the time
/// we call randomElement() on it.
///
//var items = [Int]()
//
//for i in 1...10 {
//    if isLuckyNumber(i) {
//        items.append(i)
//    }
//}
//
//let randomNumber2 = items.randomElement()!

/// Hopefully you can see the difference between the two: one situation is guaranteed
/// to work 100% of the time, and the other “should” work or “will nearly always work”.
/// That’s the key here: you should never force unwrap something that won’t
/// succeed 100% of the time. That’s it – that’s the entire rule.
///
/// Now, some people disagree and instead argue that force unwrapping should never happen.
/// I can see their point of view, and I’ve certainly thought that myself previous.
/// However, I find the extra code to handle all those impossible situations
/// to be distracting, because they add clutter to our code that literally never does anything.
///
/// More annoying are the times when there is no sensible alternative. For example,
/// if you make an enum conform to the CaseIterable protocol, Swift will generate
/// a special allCases array property for your enum that contains all the cases
/// in the order they were defined. So, we could create a Direction enum and
/// pick a random value like this:
///
enum Direction: CaseIterable {
    case north, south, east, west
}

let randomDirection = Direction.allCases.randomElement()!

/// We’ve defined an enum with four cases, and we’re asking to pick a random case.
/// The randomElement() method returns an optional because that’s how it works,
/// but we know it will always succeed because our enum has cases.
///
/// If we were to decide we never wanted to use force unwraps, what value could we use
/// instead – what default value could we give randomDirection that allowed
/// our code to continue safely?
///
/// The only way a force unwrap would be unsafe here would be if we deleted
/// the four cases from Direction, but even then Swift shows a warning
/// that we’re going to get unexpected behavior.
///
/// So, I think force unwrapping is sometimes a good idea, and sometimes even required.
/// However, I am not advocating that you start scattering exclamation marks
/// around your program, because that starts to get messy.
///
/// Instead, a better idea is to create a handful of functions and extensions that isolate
/// your force unwraps in one place. This means your force unwrapping can be stored
/// near to the place where its behavior is clarified, and the vast majority of your code
/// doesn’t need to force unwrap directly.
///
/// For example, we could rewrite our Direction enum to this:
///
enum Direction2: CaseIterable {
    case north, south, east, west
    
    static func random() -> Direction2 {
        return Direction2.allCases.randomElement()!
    }
}

/// With that in place, everywhere we need to get a random direction no longer needs
/// a force unwrap:
///
let randomDirection2 = Direction2.random()

/// Before moving on, I want to reiterate one key point here: if you’re only 99% certain
/// that a force unwrap is safe, you shouldn’t use it. Heck, even if you’re 99.999%
/// certain that it’s safe, you shouldn’t be using it – that equates to one crash in
/// 100,000, which is really bad. Instead, force unwraps should be reserved for times
/// when your code is absolutely guaranteed to be safe, as demonstrated above.
///
/// For a discussing on avoiding force unwrapping, check out this blog post
/// from Alexandre Colucci:
/// https://blog.timac.org/2017/0628-swift-banning-force-unwrapping-optionals/
///





/// Implicitly unwrapped optionals
///
/// Like regular optionals, implicitly unwrapped optionals might contain a value or
/// they might be nil. However, unlike regular optionals you don’t need to unwrap them
/// in order to use them: you can use them as if they weren’t optional at all.
///
/// Implicitly unwrapped optionals are created by adding an exclamation mark after
/// your type name, like this:
///
let age2: Int! = nil

/// Because they behave as if they were already unwrapped, you don’t need if let or
/// guard let to use implicitly unwrapped optionals. However, if you try to use them
/// and they have no value – if they are nil – your code crashes.
///
/// Implicitly unwrapped optionals exist because sometimes a variable will start life
/// as nil, but will always have a value before you need to use it. Because you know
/// they will have a value by the time you need them, it’s helpful not having to write
/// if let all the time.
///
/// That being said, if you’re able to use regular optionals instead
/// it’s generally a good idea.
///





/// Why does Swift need both implicitly unwrapped optionals and regular optionals?
///
/// Implicitly unwrapped optionals can contain a value or be nil, and regular optionals
/// can also contain a value or be nil, but there’s a subtle difference:
/// implicitly unwrapped optionals don’t need to be unwrapped to be used. This means
/// if you attempt to use an implicitly unwrapped optional and it’s actually nil,
/// your code will just crash – Swift won’t make you use if let or similar like
/// it would with regular optionals.
///
/// In the earlier days of Swift, implicitly unwrapped optionals (IUOs) played
/// a critical part in making our code work. However, since SwiftUI launched
/// they are disappearing by the thousand. That’s not to say they are useless,
/// only that they are becoming much more rare.
///
/// IUOs are useful in situations where a variable will start empty, but won’t be empty
/// by the time you want to use it, and will stay not empty for the rest of its life.
/// In this situation they are by definition safe to use without careful unwrapping,
/// because they will always have a value by the time we want to use them.
///
/// The primary reason for IUOs is for use with Apple’s older UIKit user interface framework.
/// If you wanted an image in your layout you’d need to create a property for it,
/// but that image wouldn’t be created immediately – UIKit has a performance optimization
/// that means the image is only created when that piece of user interface is actually shown.
/// Apple pushes back the work of creating the image until it’s actually needed,
/// like a lazy Swift property, but in practice it means the variable starts as nil
/// then gets set to an image as soon as it’s needed, at which point we can start using it.
///
/// Yes, these could have been written using regular optionals, but it would have
/// been annoying to have to unwrap them safely all the time when we know they must exist.
/// In the SwiftUI world this whole use case goes away, so IUOs are much less important.
///





/// Nil coalescing
///
/// The nil coalescing operator unwraps an optional and returns the value inside
/// if there is one. If there isn’t a value – if the optional was nil –
/// then a default value is used instead. Either way, the result won’t be optional:
/// it will either be the value from inside the optional or
/// the default value used as a backup.
///
/// Here’s a function that accepts an integer as its only parameter and
/// returns an optional string:
///
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

/// If we call that with ID 15 we’ll get back nil because the user isn’t recognized,
/// but with nil coalescing we can provide a default value of “Anonymous” like this:
///
/// That will check the result that comes back from the username() function:
/// if it’s a string then it will be unwrapped and placed into user,
/// but if it has nil inside then “Anonymous” will be used instead.
///
let user = username(for: 15) ?? "Anonymous"





/// When should you use nil coalescing in Swift?
///
/// Nil coalescing lets us attempt to unwrap an optional, but provide a default value
/// if the optional contains nil. This is extraordinarily useful in Swift,
/// because although optionals are a great feature it’s usually better to have
/// a non-optional – to have a real string rather than a “might be a string,
/// might be nil” – and nil coalescing is a great way to get that.
///
/// For example, if you were working on a chat app and wanted to load whatever
/// message draft the user had saved, you might write code like this:
///
//let savedData = loadSavedMessage() ?? ""

/// So, if loadSavedMessage() returns an optional with a string inside, it will be unwrapped
/// and placed into savedData. But if the optional is nil then Swift will set savedData
/// to be an empty string. Either way, savedData will end up being a String and not a String?.
///
/// You can chain nil coalescing if you want to, although I don’t think it’s common.
/// So, this kind of code is valid if you wanted it:
///
/// That will attempt to run first(), and if that returns nil attempt to run second(),
/// and if that returns nil then it will use an empty string.
///
//let savedData = first() ?? second() ?? ""

/// Remember, reading a dictionary key will always return an optional, so you might want
/// to use nil coalescing here to ensure you get back a non-optional:
///
let scores = ["Picard": 800, "Data": 7000, "Troi": 900]
let crusherScore = scores["Crusher"] ?? 0

/// This is definitely a matter of taste, but dictionaries offer a slightly different approach
/// that lets us specify the default value for when the key isn’t found:
///
/// You can choose whichever you prefer – when reading dictionary values
/// there’s no real difference.
///
let scores2 = ["Picard": 800, "Data": 7000, "Troi": 900]
let crusherScore2 = scores2["Crusher", default: 0]





/// Optional chaining
///
/// Swift provides us with a shortcut when using optionals: if you want to access something
/// like a.b.c and b is optional, you can write a question mark after it to enable
/// optional chaining: a.b?.c.
///
/// When that code is run, Swift will check whether b has a value, and if it’s nil
/// the rest of the line will be ignored – Swift will return nil immediately.
/// But if it has a value, it will be unwrapped and execution will continue.
///
/// To try this out, here’s an array of names:
///
let names = ["John", "Paul", "George", "Ringo"]

/// We’re going to use the first property of that array, which will return the first name
/// if there is one or nil if the array is empty. We can then call uppercased()
/// on the result to make it an uppercase string:
///
/// That question mark is optional chaining – if first returns nil then Swift won’t try
/// to uppercase it, and will set beatle to nil immediately.
///
let beatle = names.first?.uppercased()





/// Why is optional chaining so important?
///
/// Swift’s optional chaining lets us dig through several layers of optionals in a
/// single line of code, and if any one of those layers is nil then
/// the whole line becomes nil.
///
/// As a simple example, we might have a list of names and want to find where they
/// should be placed based on the first letter of their surname:
///
let names2 = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
let surnameLetter = names2["Vincent"]?.first?.uppercased()

/// There we use optional chaining with the dictionary value because names["Vincent"]
/// might not exist, and again when reading the first character from the surname,
/// because it’s possible the string could be empty.
///
/// Optional chaining makes for a very good companion to nil coalescing, because
/// it allows you to dig through layers of optionals while also providing
/// a sensible fall back if any of the optionals are nil.
///
/// Returning to our surname example, we could automatically return “?”
/// if we were unable to read the first letter of someone’s surname:
///
/// For more information on optional chaining, I can recommend this blog post
/// from Andy Bargh: https://andybargh.com/optional-chaining/
///
let names3 = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
let surnameLetter2 = names3["Vincent"]?.first?.uppercased() ?? "?"





/// Optional try
///
/// Back when we were talking about throwing functions, we looked at this code:
///
/// That runs a throwing function, using do, try, and catch to handle errors gracefully.
///
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

/// There are two alternatives to try, both of which will make more sense now that
/// you understand optionals and force unwrapping.
///
/// The first is try?, and changes throwing functions into functions that return an optional.
/// If the function throws an error you’ll be sent nil as the result, otherwise
/// you’ll get the return value wrapped as an optional.
///
/// Using try? we can run checkPassword() like this:
///
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

/// The other alternative is try!, which you can use when you know for sure that the function
/// will not fail. If the function does throw an error, your code will crash.
///
/// Using try! we can rewrite the code to this:
///
try! checkPassword("sekrit")
print("OK!")





/// When should you use optional try?
///
/// We can run throwing functions using do, try, and catch in Swift, but an alternative
/// is to use try? to convert a throwing function call into an optional. If the function
/// succeeds, its return value will be an optional containing whatever you would normally
/// have received back, and if it fails the return value will be an optional set to nil.
///
/// There are advantages and disadvantages to using optional try, but it mostly centers
/// around how important the error is to you. If you want to run a function and
/// care only that it succeeds or fails – you don’t need to distinguish between
/// the various reasons why it might fail – then using optional try is a great fit,
/// because you can boil the whole thing down to “did it work?”
///
/// So, rather than writing this:
///
//do {
//    let result = try runRiskyFunction()
//    print(result)
//} catch {
//    // it failed
//}

/// You can instead write this:
///
//if let result = try? runRiskyFunction() {
//    print(result)
//}

/// If that’s what you wanted to do then you could just make runRiskyFunction() return
/// an optional rather than throwing an error, but throwing and using optional try
/// does give us the flexibility to change our mind later. That is, if we write
/// a function that throws errors then at the call site we can either use
/// try/catch or use optional try based on what we need at that point.
///
/// For what it’s worth, I use optional try a heck of a lot in my own code,
/// because it does wonders for letting me focus on the problem at hand.
///





/// Failable initializers
///
/// When talking about force unwrapping, I used this code:
///
let str3 = "5"
let num3 = Int(str3)

/// That converts a string to an integer, but because you might try to pass any string
/// there what you actually get back is an optional integer.
///
/// This is a failable initializer: an initializer that might work or might not.
/// You can write these in your own structs and classes by using init?() rather than init(),
/// and return nil if something goes wrong. The return value will then be an optional
/// of your type, for you to unwrap however you want.
///
/// As an example, we could code a Person struct that must be created using a nine-letter
/// ID string. If anything other than a nine-letter string is used we’ll return nil,
/// otherwise we’ll continue as normal.
///
/// Here’s that in Swift:
///
struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

let popeye = Person(id: "Popeye")
if let popeye = popeye {
    print("Person ID: \(popeye.id)")
} else {
    print("Your ID is less than 9 characters!")
}





/// Why would you want a failable initializer?
///
/// If an initializer for a struct or class can fail – if you realize part-way through
/// that you cannot create the object using the data you were provided – then you need
/// a failable initializer. Rather than returning a new object instance, this returns
/// an optional instance that will be nil if initialization failed.
///
/// Making a failable initializer takes two steps:
/// - Write your initializer as init?() rather than init()
/// - Return nil for any paths that should fail
///
/// You can have as many failing paths as you need, but you don’t need to worry about
/// the success path – if you don’t return nil from the method, Swift assumes
/// you mean everything worked correctly.
///
/// To demonstrate this, here’s an Employee struct that has a failable initializer
/// with two checks:
///
struct Employee {
    var username: String
    var password: String
    
    init?(username: String, password: String) {
        guard password.count >= 8 else { return nil }
        guard password.lowercased() != "password" else { return nil }
        
        self.username = username
        self.password = password
    }
}

/// That requires passwords be at least 8 characters and not be the string “password”.
/// We can try that out with two example employees:
///
let tim = Employee(username: "TimC", password: "app1e")
let craig = Employee(username: "CraigF", password: "ha1rf0rce0ne")

if let tim = tim {
    print("Employee: \(tim)")
} else {
    print("Your data is not valid!")
}

if let craig = craig {
    print("Employee: \(craig)")
} else {
    print("Your data is not valid!")
}

/// The first of those will be an optional set to nil because the password is too short,
/// but the second will be an optional set to a valid User instance.
///
/// Failable initializers give us the opportunity to back out of an object’s creation
/// if validation checks fail. In the previous case that was a password that was too short,
/// but you could also check whether the username was taken already,
/// whether the password was the same as the username, and so on.
///
/// Yes, you could absolutely put these checks into a separate method, but it’s much safer
/// to put them into the initializer – it’s too easy to forget to call the other method,
/// and there’s no point leaving that hole open.
///





/// Typecasting
///
/// Swift must always know the type of each of your variables, but sometimes you know more
/// information than Swift does. For example, here are three classes:
///
class Animal {  }

class Fish: Animal {  }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

/// We can create a couple of fish and a couple of dogs, and put them into an array, like this:
/// Swift can see both Fish and Dog inherit from the Animal class,
/// so it uses type inference to make pets an array of Animal.
///
let pets = [Fish(), Dog(), Fish(), Dog(),]

/// If we want to loop over the pets array and ask all the dogs to bark, we need to perform
/// a typecast: Swift will check to see whether each pet is a Dog object,
/// and if it is we can then call makeNoise().
///
/// This uses a new keyword called as?, which returns an optional:
/// it will be nil if the typecast failed, or a converted type otherwise.
///
/// Here’s how we write the loop in Swift:
///
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}





/// When is type casting useful in Swift?
///
/// Type casting lets us tell Swift that an object it thinks is type A is actually type B,
/// which is helpful when working with protocols and class inheritance.
///
/// As you’ve seen, protocols let us group together common functionality so we can share code.
/// However, some times we need to go in the opposite direction – we need to be able to see
/// “you have an object that conforms to a protocol,
/// but I’d like you to let me use it as a specific type.”
///
/// To demonstrate this, here’s a simple class hierarchy:
///
/// I’ve used default values for each property so we don’t need to write an initializer.
///
class Person2 {
    var name = "Anonymous"
}

class Customer2: Person2 {
    var id = 12345
}

class Employee2: Person2 {
    var salary = 50_000
}

/// We can create an instance of each of those, and add them to the same array:
///
let customer2 = Customer2()
let employee2 = Employee2()
let people = [customer2, employee2]

/// Because both Customer and Employee inherit from Person, Swift will consider that
/// people constant to be a Person array. So, if we loop over people we’ll only
/// be able to access the name of each item in the array – or at least we would
/// only be able to do that, if it weren’t for type casting:
///
for person in people {
    if let customer = person as? Customer2 {
        print("I'm a customer, with id \(customer.id)")
    } else if let employee = person as? Employee2 {
        print("I'm an employee, earning $\(employee.salary)")
    }
}

/// As you can see, that attempts to convert person first to Customer and then to Employee.
/// If either test passes, we can then use the extra properties that belong to that class,
/// as well as the name property from the parent class.
///
/// Type casting isn’t specifically frowned upon in Swift, but I would say that repeated
/// type casting might mean you’ve got an underlying problem in your code. More specifically,
/// Swift works best when it understands what data you’re working with, and a type cast
/// effectively says to Swift, “I know more information than you do.” If you can find ways
/// to convey that information to Swift so it understand it as well, that usually works better.
///
