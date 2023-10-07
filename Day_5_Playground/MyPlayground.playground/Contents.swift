import Cocoa

/// Writing functions
///
/// Functions let us re-use code, which means we can write a function to do something
/// interesting then run that function from lots of places. Repeating code is
/// generally a bad idea, and functions help us avoid doing that.
///
/// To start with, we’re going to write a function that prints help information
/// for users of our app. We might need this anywhere in our app,
/// so having it as a function is a good idea.
///
/// Swift functions start with the func keyword, then your function name,
/// then open and close parentheses. All the body of your function –
/// the code that should be run when the function is requested – is placed inside braces.
///
/// Let’s write the printHelp() function now:
///
func printHelp() {
    let message = """
    Welcome to my App!
    
    Run this app inside a directory of images and
    MyApp will resize them all into thumbnails
    """
    
    print(message)
}

/// We can now run that using printHelp() by itself:
///
/// Running a function is often referred to as calling a function.
///
printHelp()





/// What code should be put in a function?
///
/// Functions are designed to let us re-use code easily, which means we don’t have
/// to copy and paste code to get common behaviors. You could use them very rarely
/// if you wanted, but honestly there’s no point – they are wonderful tools for helping us
/// write clearer, more flexible code.
///
/// There are three times you’ll want to create your own functions:
/// - The most common time is when you want the same functionality in many places.
///     Using a function here means you can change one piece of code and have everywhere
///     that uses your function get updated.
/// - Functions are also useful for breaking up code. If you have one long function
///     it can be hard to follow everything that’s going on, but if you break it up
///     into three or four smaller functions then it becomes easier to follow.
/// - The last reason is more advanced: Swift lets us build new functions out of existing functions,
///     which is a technique called function composition. By splitting your work into
///     multiple small functions, function composition lets us build big functions by combining
///     those small functions in various ways, a bit like Lego bricks.
///





/// Accepting parameters
///
/// Functions become more powerful when they can be customized each time you run them.
/// Swift lets you send values to a function that can then be used inside the function
/// to change the way it behaves. We’ve used this already – we’ve been sending strings
/// and integers to the print() function, like this:
///
/// Values sent into functions this way are called parameters.
///
print("Hello, world!")

/// To make your own functions accept parameters, give each parameter a name,
/// then a colon, then tell Swift the type of data it must be.
/// All this goes inside the parentheses after your function name.
///
/// For example, we can write a function to print the square of any number:
///
func square(number: Int) {
    print(number * number)
}

/// That tells Swift we expect to receive an Int, and it should be called number.
/// This name is used both inside the function when you want to refer to the parameter,
/// but also when you run the function, like this:
///
square(number: 8)





/// How many parameters should a function accept?
///
/// At first glance, this question seems like “how long is a piece of a string?” That is,
/// it’s something where there is no real, hard answer – a function could take no parameters
/// or take 20 of them.
///
/// That’s certainly true, but when a function takes many parameters – perhaps six or more,
/// but this is extremely subjective – you need to start asking whether that function
/// is perhaps doing a bit too much work.
/// - Does it need all six of those parameters?
/// - Could that function be split up into smaller functions that take fewer parameters?
/// - Should those parameters be grouped somehow?
///
/// We’ll look at some techniques for solving this later on, but there’s an important lesson
/// to be learned here: this is called a “code smell” – something about our code that suggests
/// an underlying problem in the way we’ve structured our program.
///





/// Returning values
///
/// As well as receiving data, functions can also send back data. To do this, write a dash
/// then a right angle bracket after your function’s parameter list, then tell Swift
/// what kind of data will be returned.
///
/// Inside your function, you use the return keyword to send a value back if you have one.
/// Your function then immediately exits, sending back that value – no other code
/// from that function will be run.
///
/// We could rewrite our square() function to return a value rather than print it directly:
///
func square1(number: Int) -> Int {
    return number * number
}

/// Now we can grab that return value when the function is run, and print it there:
///
/// If you need to return multiple values, this is a perfect example of when to use tuples.
///
let result = square1(number: 8)
print(result)





/// When is the return keyword not needed in a Swift function?
///
/// We use the return keyword to send back values from functions in Swift,
/// but there is one specific case where it isn’t needed: when our function
/// contains only a single expression.
///
/// Now, “expression” isn’t a word I use often, but it’s important to understand here.
/// When we write programs we do things like this:
///
5 + 8

/// Or this:
///
//greet("Paul")

/// These lines of code get resolved to a single value: 5 + 8 gets resolved to 13,
/// and greet("Paul") might return a string “Hi, Paul!”
///
/// Even some longer code will get resolved to a single value. For example,
/// if we had three Boolean constants like this:
///
let isAdmin = true
let isOwner = false
let isEditingEnabled = false

/// Then this line of code would resolve to a single value:
///
/// That would become “true”, because even though isOwner is false,
/// isAdmin is true, so the whole expression becomes true.
///
isOwner == true && isEditingEnabled || isAdmin == true

/// So, lots of code we write can be resolved to a single value. But there’s also
/// a lot of code that can’t be resolved to a single value.
/// For example, what’s the value here:
///
/// Yes, that creates a constant, but it doesn’t become a value in its own right –
/// we couldn’t write return let name = "Otis".
///
let name = "Otis"

/// Similarly, we write conditions like this:
///
/// That also can’t become a single value, because it has a condition in there.
///
if name == "Maeve" {
    print("Hello, Maeve!")
}

/// Now, all this matters because these divisions have names: when our code
/// can be boiled down to a single value, such as true, false, “Hello”,
/// or 19, we call that an expression. Expressions are things that can be assigned
/// to a variable, or printed using print(). On the other hand, when we’re performing
/// actions such as creating variables, starting a loop, or checking a condition,
/// then we call that a statement.
///
/// All this matters because Swift lets us skip using the return keyword
/// when we have only one expression in our function.
/// So, these two functions do the same thing:
///
func doMath() -> Int {
    return 5 + 5
}

func doMoreMath() -> Int {
    5 + 5
}

/// All this matters because Swift lets us skip using the return keyword
/// when we have only one expression in our function.
/// So, these two functions do the same thing:
///
/// Now, you might think this is pointless, and you would always use the return keyword.
/// However, this functionality is used very commonly with SwiftUI, so it’s worth keeping in mind.
///
/// Before we’re done, I want to mention one more thing. You’ve seen how we can use operators
/// such as +, &&, and || in our expressions, because they still resolve to a single value.
/// Well, the ternary operator works here too, and in fact this is the primary use case for it:
/// when you want to have a single expression, but don’t want to have a full if.
///
/// To demonstrate this, consider the following function:
///
func greet(name: String) -> String {
    if name == "Taylor Swift" {
        return "Oh wow!"
    } else {
        return "Hello, \(name)"
    }
}

/// If we wanted to remove the return statements in there, we could not write this:
///
/// That isn’t allowed, because we have actual statements in there – if and else.
///
//func greet(name: String) -> String {
//    if name == "Taylor Swift" {
//        return "Oh wow!"
//    } else {
//        return "Hello, \(name)"
//    }
//}

/// However, we could use the ternary operator like this:
///
/// That is a single expression. If name is equal to “Taylor Swift” then
/// it will resolve something like this:
/// - Swift will check whether name is Taylor Swift or not.
/// - It is, so name == "Taylor Swift" is true.
/// - The ternary operator will realize its condition is now true,
///     so it will pick “Oh wow” rather than “Hello, (name)”.
///
func greet1(name: String) -> String {
    name == "Taylor Swift" ? "Oh wow!" : "Hello, \(name)"
}

/// So, when that function runs it effectively boils down to this:
///
func greet2(name: String) -> String {
    "Oh wow!"
}

/// Letting us put conditional functionality into a single line of code
/// is where the ternary operator really shines. And, because SwiftUI
/// uses single expression functions quite a lot, this means ternary operators
/// get used in SwiftUI quite a lot too.
///





/// How can you return two or more values from a function?
///
/// Swift’s functions have a single return type, such as Int or String,
/// but that doesn’t mean we can only return a single value. In fact,
/// there are two ways we can send back multiple pieces of data:
/// - Using a tuple, such as (name: String, age: Int)
/// - Using some sort of collection, such as an array or a dictionary.
///
/// If you had a hard time understanding why tuples were important,
/// this is a really good example of a place where they really stand out.
///
/// If we wanted to make a function that returns a person’s first name and last name,
/// we could do it like this:
///
/// That sends back an array containing two strings and stores it in user,
/// which does the job. However, the code is problematic for two reasons:
/// - Some cultures write their last names first (“Swift Taylor”),
///     so it’s possible other developers might expect index 0 to be the last name
///     and index 1 to be the first name.
/// - What if we inserted a middle name? It would push “Swift” back
///     from index 1 to index 2, causing problems.
///
func getUser() -> [String] {
    ["Taylor", "Swift"]
}

let user = getUser()
print(user[0])

/// A second pass at the function might look like this:
///
/// That’s definitely better, because now we can be sure exactly where to find each value:
/// user["first"] will always be “Taylor” no matter whether we change the dictionary order
/// or if we insert a middle name.
///
/// However, this solution still isn’t ideal:
/// - We’re need to look for values using strings, which means user["First"]
///     will fail because we wrote “First” rather than “first”.
/// - Our dictionary might contain neither value – maybe our user was Prince,
///     Plato, Beyonce, or someone else who goes by only one name.
/// - Every time we read a value from the dictionary we need to unwrap the optional,
///     because Swift can’t be sure the value is definitely there.
///
func getUser1() -> [String: String] {
    ["first": "Taylor", "second": "Swift"]
}

let user1 = getUser1()
print(user1["first"] ?? "Unknown")

/// Tuples can solve the problem by letting us be specific about what data will come back:
/// its name, its type, its order, and whether it’s optional or not. This means we can write
/// functions to return multiple values much more safely:
///
/// Now we’ve written code that is immune to all our problems:
/// - Our data must be returned first name first and last name second.
/// - If we insert a middle name it will not affect the position of other values.
/// - We can’t make case-sensitive mistakes while reading values.
/// - There's no way we won’t get back a first name or last name –
///     if someone only uses one name then we’ll get back an empty string.
/// - There is no optionality.
///
/// So, tuples make fantastic candidates for returning multiple values from functions.
///
func getUser2() -> (first: String, last: String) {
    (first: "Taylor", last: "Swift")
}

let user2 = getUser2()
print(user2.first)





/// Parameter labels
///
/// We wrote our square() function like this:
///
func square2(number: Int) -> Int {
    return number * number
}

/// That names its parameter number, so we can use number inside the function to refer to it,
/// but we must also use the name when running the function, like this:
///
let result2 = square2(number: 8)

/// Swift lets us provide two names for each parameter: one to be used externally
/// when calling the function, and one to be used internally inside the function.
/// This is as simple as writing two names, separated by a space.
///
/// To demonstrate this, here’s a function that uses two names for its string parameter:
///
/// The parameter is called to name, which means externally it’s called to,
/// but internally it’s called name. This gives variables a sensible name inside the function,
/// but means calling the function reads naturally:
///
func sayHello(to name: String) {
    print("Hello, \(name)")
}

sayHello(to: "Taylor")





/// Why does Swift use parameter labels?
///
/// Many programming languages either do not use parameter labels or make them optional.
/// Swift is unusual in that it uses them extensively, and it even lets us differentiate
/// between external parameter names and internal parameter names – it’s doubly unusual!
///
/// To look at why labels are useful, consider code like this:
///
//setReactorStatus(true, true, false)

/// That’s perfectly normal code in many languages, but you will rarely if ever see that in Swift
/// because we prefer to give our parameters names. So, we’d write our function like this:
///
func setReactorStatus(primaryActive: Bool, backupActove: Bool, isEmergency: Bool) {
    // code here
}

/// As a result, Swift will require those Booleans to be used when calling the function, like this:
///
setReactorStatus(primaryActive: true, backupActove: true, isEmergency: false)

/// And now our code becomes much clearer – we know exactly what each value does
/// when we call the function, rather than having to remember whether isEmergency comes first or last.
///
/// Of course, Swift takes this even further by letting us write our labels twice, like this:
///
func setAge(for person: String, to value: Int) {
    print("\(person) is now \(value)")
}

/// This solves two problems at once: it makes those labels more meaningful inside the function,
/// and also makes those labels more meaningful outside the function.
///
/// To demonstrate this, here’s how the function is called right now:
///
setAge(for: "Paul", to: 40)

/// If we had only used the person and value labels, we would have to write this instead:
///
/// I hope you can see that the original code can actually be read aloud
/// as a standard English statement: “set age for Paul to 40”. On the other hand,
/// “set age person Paul value 40” isn’t natural at all.
///
//setAge(person: "Paul", value: 40)

/// Going the other way, if we had used only the for and to labels, then calling the function
/// would look natural but using those values inside the function would be weird:
///
/// In fact, Swift wouldn’t even allow that because it will think for is the start of a loop!
///
//func setAge1(for: String, to: Int) {
//    print("\(for) is now \(to)")
//}

/// By having both the internal and external labels, our functions read more naturally both
/// where we call them and inside the function itself. They aren’t required,
/// and often you’ll have only one label for your parameters, but it’s still nice to have them around.
///





/// Omitting parameter labels
///
/// You might have noticed that we don’t actually send any parameter names when we call print() –
/// we say print("Hello") rather than print(message: "Hello").
///
/// You can get this same behavior in your own functions by using an underscore, _,
/// for your external parameter name, like this:
///
func greet(_ person: String) {
    print("Hello, \(person)!")
}

/// You can now call greet() without having to use the person parameter name:
///
greet("Taylor")

/// This can make some code more natural to read, but generally it’s better to give your
/// parameters external names to avoid confusion. For example, if I say setAlarm(5)
/// it’s hard to tell what that means – does it set an alarm for five o’clock,
/// set an alarm for five hours from now, or activate pre-configured alarm number 5?
///





/// When should you omit a parameter label?
///
/// If we use an underscore for a function parameter’s external label, Swift lets us use
/// no name for that parameter at all. This is very common practice in some parts of Swift development,
/// particularly when building apps that don’t use SwiftUI, but there are many other times
/// when you’ll also want to use this.
///
/// The main reason for skipping a parameter name is when your function name is a verb and
/// the first parameter is a noun the verb is acting on. For example:
/// - Greeting a person would be greet(taylor) rather than greet(person: taylor)
/// - Buying a product would be buy(toothbrush) rather than buy(item: toothbrush)
/// - Finding a customer would be find(customer) rather than find(user: customer)
///
/// This is particularly important when the parameter label is likely to be the same
/// as the name of whatever you’re passing in:
/// - Singing a song would be sing(song) rather than sing(song: song)
/// - Enabling an alarm would be enable(alarm) rather than enable(alarm: alarm)
/// - Reading a book would be read(book) rather than read(book: book)
///
/// Before SwiftUI came along, apps were built using Apple’s UIKit, AppKit, and WatchKit frameworks,
/// which were designed using an older language called Objective-C. In that language,
/// the first parameter to a function was always left unnamed, and so when you use those frameworks
/// in Swift you’ll see lots of functions that have underscores for their first parameter label to
/// preserve interoperability with Objective-C.
///





/// Default parameters
///
/// The print() function prints something to the screen, but always adds a new line to the end
/// of whatever you printed, so that multiple calls to print() don’t all appear on the same line.
///
/// You can change that behavior if you want, so you could use spaces rather than line breaks.
/// Most of the time, though, folks want new lines, so print() has a terminator parameter
/// that uses new line as its default value.
///
/// You can give your own parameters a default value just by writing an = after its type
/// followed by the default you want to give it. So, we could write a greet() function
/// that can optionally print nice greetings:
///
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

/// That can be called in two ways:
///
greet("Taylor")
greet("Taylor", nicely: false)





/// When to use default parameters for functions
///
/// Default parameters let us make functions easier to call by letting us provide
/// common defaults for parameters. So, when we want to call that function
/// using those default values we can just ignore the parameters entirely –
/// as if they didn’t exist – and our function will just do the right thing.
/// Of course, when we want something custom it’s there for us to change.
///
/// Swift developers use default parameters very commonly, because they let us
/// focus on the important parts that do need to change regularly.
/// This can really help simplify complex function, and make your code easier to write.
///
/// For example, imagine some route finding code such as this:
///
func findDirections(from: String, to: String, route: String = "fastest", avoidhighways: Bool = false) {
    // code here
}

/// That assumes that most of the time folks want to drive between two locations by the fastest route,
/// without avoiding highways – sensible defaults that are likely to work most of the time,
/// while giving us the scope to provide custom values when needed.
///
/// As a result, we can call that same function in any of three ways:
///
/// Shorter, simpler code most of the time, but flexibility when we need it – perfect.
///
findDirections(from: "London", to: "Glasgow")
findDirections(from: "London", to: "Glasgow", route: "scenic")
findDirections(from: "London", to: "Glasgow", route: "scenic", avoidhighways: true)





/// Variadic functions
///
/// Some functions are variadic, which is a fancy way of saying they accept any number of
/// parameters of the same type. The print() function is actually variadic:
/// if you pass lots of parameters, they are all printed on one line with spaces between them:
///
print("Haters", "gonna", "hate")

/// You can make any parameter variadic by writing ... after its type. So, an Int parameter
/// is a single integer, whereas Int... is zero or more integers – potentially hundreds.
///
/// Inside the function, Swift converts the values that were passed in to an array of integers,
/// so you can loop over them as needed.
///
/// To try this out, let’s write a square() function that can square many numbers:
///
func square3(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

/// Now we can run that with lots of numbers just by passing them in separated by commas:
///
square3(numbers: 1, 2, 3, 4, 5)





/// When to use variadic functions
///
/// Swift’s variadic functions let us accept any number of parameters of the same type,
/// separated by a comma. Inside the function they are handed to us as an array,
/// which we can index into, loop over, and so on.
///
/// The power of variadic parameters is that we can treat them as if they weren’t variadic
/// most of the time. For example, if you had an open() function that opened a file
/// for editing in Preview, TextEdit, or whatever was the correct program, you might call it like this:
///
//open("photo.jpg")

/// But that same function could take a variadic parameter – lots of filenames to open,
/// so several could be opened at once:
///
//open("photo.jpg", "recipes.txt", "myCode.swift")

/// So, by making that parameter variadic, we can open up a whole range of additional functionality
/// without having to change the way the function is called – it’s really useful!
///
/// As for when you should use them, chances are you won’t use them that much while you’re learning
/// because you’re going to be focused on very specific problems that are usually fairly small.
/// But as your skills increase, you’ll find that you can change your existing functions
/// to make them variadic without breaking any of your code – you can add functionality
/// without changing what you already have.
///





/// Writing throwing functions
///
/// Sometimes functions fail because they have bad input, or because something went wrong internally.
/// Swift lets us throw errors from functions by marking them as throws before their return type,
/// then using the throw keyword when something goes wrong.
///
/// First we need to define an enum that describes the errors we can throw. These must always be
/// based on Swift’s existing Error type. We’re going to write a function that checks
/// whether a password is good, so we’ll throw an error if the user tries an obvious password:
///
enum PasswordError: Error {
    case obvious
}

/// Now we’ll write a checkPassword() function that will throw that error if something goes wrong.
/// This means using the throws keyword before the function’s return value, then using throw
/// PasswordError.obvious if their password is “password”.
///
/// Here’s that in Swift:
///
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}





/// When should you write throwing functions?
///
/// Throwing functions in Swift are those that are able to encounter errors they are unable or
/// unwilling to handle. That doesn’t mean they will throw errors, just that it’s possible they can.
/// As a result, Swift will make sure we’re careful when we use them,
/// so that any errors that do occur are catered for.
///
/// But when you’re writing your code, chances are you’ll think to yourself “should this function
/// throw any errors it encounters, or should it maybe handle them itself?” This is really common,
/// and to be honest there is no single answer – you can handle the errors inside the function
/// (thus making it not a throwing function), you can send them all back to whatever called the function
/// (called “error propagation” or sometimes “bubbling up errors”), and you can even handle some errors
/// in the function and send some back. All of those are valid solutions,
/// and you will use all of them at some point.
///
/// When you’re just getting started, I would recommend you avoid throwing functions most of the time.
/// They can feel a bit clumsy at first because you need to make sure all the errors are handled
/// wherever you use the function, so it feels almost a bit “infectious” – suddenly you have errors
/// needing to be handled in several places in your code, and if those errors bubble up further
/// then the “infection” just spreads.
///
/// So, when you’re learning start small: keep the number of throwing functions low,
/// and work outwards from there. Over time you’ll get a get better grip on managing errors
/// to keep your program flow smooth, and you’ll feel more confident about adding throwing functions.
///





/// Running throwing functions
///
/// Swift doesn’t like errors to happen when your program runs, which means it won’t let you run
/// an error-throwing function by accident.
///
/// Instead, you need to call these functions using three new keywords: do starts a section
/// of code that might cause problems, try is used before every function that might throw an error,
/// and catch lets you handle errors gracefully.
///
/// If any errors are thrown inside the do block, execution immediately jumps to the catch block.
/// Let’s try calling checkPassword() with a parameter that throws an error:
///
enum PasswordError1: Error {
    case obvious
}

func checkPassword1(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

/// When that code runs, “You can’t use that password” is printed, but “That password is good”
/// won’t be – that code will never be reached, because the error is thrown.
///
do {
    try checkPassword1("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}





/// Why does Swift make us use try before every throwing function?
///
/// Using Swift’s throwing functions relies on three unique keywords: do, try, and catch.
/// We need all three to be able to call a throwing function, which is unusual –
/// most other languages use only two, because they don’t need to write try before every throwing function.
///
/// The reason Swift is different is fairly simple: by forcing us to use try before every throwing function,
/// we’re explicitly acknowledging which parts of our code can cause errors. This is particularly useful
/// if you have several throwing functions in a single do block, like this:
///
/// As you can see, using try makes it clear that the first, third, and fifth function calls
/// can throw errors, but the second and fourth cannot.
///
//do {
//    try throwingFunction1()
//    nonThrowingFunction1()
//    try throwingFunction2()
//    nonThrowingFunction2()
//    try throwingFunction3()
//} catch {
//    // handle errors
//}





/// inout parameters
///
/// All parameters passed into a Swift function are constants, so you can’t change them.
/// If you want, you can pass in one or more parameters as inout, which means they can be changed
/// inside your function, and those changes reflect in the original value outside the function.
///
/// For example, if you want to double a number in place – i.e., change the value directly
/// rather than returning a new one – you might write a function like this:
///
func doubleInPlace(number: inout Int) {
    number *= 2
}

/// To use that, you first need to make a variable integer – you can’t use constant integers with inout,
/// because they might be changed. You also need to pass the parameter to doubleInPlace
/// using an ampersand, &, before its name, which is an explicit recognition
/// that you’re aware it is being used as inout.
///
/// In code, you’d write this:
///
var myNum = 10
doubleInPlace(number: &myNum)





/// When should you use inout parameters?
///
/// Swift’s inout parameters are very commonly used, but less commonly created. That is, they are
/// the kind of thing you’ll rely on a lot, perhaps without even realizing, but it’s not common
/// you’ll want to create functions with them – at least not while you’re learning.
///
/// How common are they? Well, all of Swift’s operators are actually implemented as functions
/// behind the scenes – things like +, -, and so on. Yes, they really are just functions
/// behind the scenes. You can imagine them a bit like this:
///
/// So, when writing 5 + 3 we’re actually calling a function called + takes an integer
/// on the left (5) and an integer on the right (3), and returns a new integer containing the result.
///
func +(leftNumber: Int, rightNumber: Int) -> Int {
    // code here
}

/// Now think about the += operator, which both adds and assigns at the same time.
/// That doesn’t have a return value, but actually modifies the original value directly.
/// As a result, it looks a bit more like this:
///
func +=(leftNumber: inout Int, rightNumber: Int) {
    // code here
}

/// Broadly speaking, it’s best to avoid creating inout parameters until you feel confident
/// they are definitely the right choice. When you’re learning (and actually when you’re
/// very experienced too!) it’s usually better to send in some data to a function and get new data back,
/// because it makes it easier to follow your program’s logic.
///
/// That doesn’t mean inout isn’t worth knowing, only that you want to be really sure
/// you need it before you begin.
/// 
