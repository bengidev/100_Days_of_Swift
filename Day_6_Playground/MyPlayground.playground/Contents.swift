import Cocoa

/// Creating basic closures
///
/// Swift lets us use functions just like any other type such as strings and integers.
/// This means you can create a function and assign it to a variable, call that function
/// using that variable, and even pass that function into other functions as parameters.
///
/// Functions used in this way are called closures, and although they work like functions
/// they are written a little differently.
///
/// Let’s start with a simple example that prints a message:
///
let driving = {
    print("I'm driving in my car")
}

/// That effectively creates a function without a name, and assigns that function to driving.
/// You can now call driving() as if it were a regular function, like this:
///
driving()





/// What the heck are closures and why does Swift love them so much?
///
/// Go on, admit it: you asked yourself exactly this question. If you didn’t I’d be surprised,
/// because closures are one of the most powerful features of Swift but also easily
/// the feature that confuses people.
///
/// So, if you’re sitting here thinking “wow, closures are really hard”, don’t be dismayed –
/// they are hard, and you finding them hard just means your brain is operating correctly.
///
/// One of the most common reasons for closures in Swift is to store functionality –
/// to be able to say “here’s some work I want you to do at some point,
/// but not necessarily now.” Some examples:
/// - Running some code after a delay.
/// - Running some code after an animation has finished.
/// - Running some code when a download has finished.
/// - Running some code when a user has selected an option from your menu.
///
/// Closures let us wrap up some functionality in a single variable, then store that somewhere.
/// We can also return it from a function, and store the closure somewhere else.
///
/// When you’re learning, closures are a little hard to read – particularly when they accept and/or
/// return their own parameters. But that’s OK: take small steps, and backtrack if you get stuck,
/// and you’ll be fine.
///





/// Accepting parameters in a closure
///
/// When you create closures, they don’t have a name or space to write any parameters.
/// That doesn’t mean they can’t accept parameters, just that they do so in a different way:
/// they are listed inside the open braces.
///
/// To make a closure accept parameters, list them inside parentheses just after the opening brace,
/// then write in so that Swift knows the main body of the closure is starting.
///
/// For example, we could make a closure that accepts a place name string
/// as its only parameter like this:
///
let driving1 = { (place: String) in
    print("I'm going to \(place) in my car")
}

/// One of the differences between functions and closures is that you don’t use parameter labels
/// when running closures. So, to call driving() now we’d write this:
///
driving1("London")





/// Why are Swift’s closure parameters inside the braces?
///
/// Both closures and functions can take parameters, but the way they take parameters is very different.
/// Here’s a function that accepts a string and an integer:
///
func pay(user: String, amount: Int) {
    // code
}

/// And here’s exactly the same thing written as a closure:
///
let payment = { (user: String, amount: Int) in
    // code
}

/// As you can see, the parameters have moved inside the braces, and the in keyword is there
/// to mark the end of the parameter list and the start of the closure’s body itself.
///
/// Closures take their parameters inside the brace to avoid confusing Swift:
/// if we had written let payment = (user: String, amount: Int) then it would look like
/// we were trying to create a tuple, not a closure, which would be strange.
///
/// If you think about it, having the parameters inside the braces also neatly captures the way
/// that whole thing is one block of data stored inside the variable – the parameter list and
/// the closure body are all part of the same lump of code, and stored in our variable.
///
/// Having the parameter list inside the braces shows why the in keyword is so important –
/// without that it’s hard for Swift to know where your closure body actually starts,
/// because there’s no second set of braces.
///





/// Returning values from a closure
///
/// Closures can also return values, and they are written similarly to parameters:
/// you write them inside your closure, directly before the in keyword.
///
/// To demonstrate this, we’re going to take our driving() closure and make it
/// return its value rather than print it directly. Here’s the original:
///
let driving2 = { (place: String) in
    print("I'm going to \(place) in my car")
}

/// We want a closure that returns a string rather than printing the message directly,
/// so we need to use -> String before in, then use return just like a normal function:
///
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

/// We can now run that closure and print its return value:
///
let message = drivingWithReturn("London")
print(message)





/// How do you return a value from a closure that takes no parameters?
///
/// Closures in Swift have a distinct syntax that really separates them
/// from simple functions, and one place that can cause confusion
/// is how we accept and return parameters.
///
/// First, here’s a closure that accepts one parameter and returns nothing:
///
let payment1 = { (user: String) in
    print("Paying \(user)...")
}

/// Now here’s a closure that accepts one parameter and returns a Boolean:
///
let payment2 = { (user: String) -> Bool in
    print("paying \(user)...")
    return true
}

/// If you want to return a value without accepting any parameters,
/// you can’t just write -> Bool in – Swift won’t understand what you mean.
/// Instead, you should use empty parentheses for your parameter list, like this:
///
/// If you think about it, that works just the same as a standard function
/// where’d write func payment() -> Bool.
///
let payment3 = { () -> Bool in
    print("Paying an anonymous person...")
    return true
}





/// Closures as parameters
///
/// Because closures can be used just like strings and integers, you can pass them
/// into functions. The syntax for this can hurt your brain at first,
/// so we’re going to take it slow.
///
/// First, here’s our basic driving() closure again
///
/// If we wanted to pass that closure into a function so it can be run inside that function,
/// we would specify the parameter type as () -> Void. That means “accepts no parameters,
/// and returns Void” – Swift’s way of saying “nothing”.
///
let driving3 = {
    print("I'm driving in my car")
}

/// So, we can write a travel() function that accepts different kinds of traveling actions,
/// and prints a message before and after:
///
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

/// We can now call that using our driving closure, like this:
///
travel(action: driving3)





/// Why would you want to use closures as parameters?
///
/// Swift’s closures can be used just like any other type of data, which means
/// you can pass them into functions, take copies of them, and so on.
/// But when you’re just learning, this can feel very much like “just because you can,
/// doesn’t mean you should” – it’s hard to see the benefit.
///
/// One of the best examples I can give is the way Siri integrates with apps.
/// Siri is a system service that runs from anywhere on your iOS device,
/// but it’s able to communicate with apps – you can book a ride with Lyft,
/// you can check the weather with Carrot Weather, and so on. Behind the scenes,
/// Siri launches a small part of the app in the background to pass on our voice request,
/// then shows the app’s response as part of the Siri user interface.
///
/// Now think about this: what if my app behaves badly, and takes 10 seconds to respond to Siri?
/// Remember, the user doesn’t actually see my app, just Siri, so from their perspective
/// it looks like Siri has completely frozen.
///
/// This would be a terrible user experience, so Apple uses closures instead:
/// it launches our app in the background and passes in a closure that we can call when we’re done.
/// Our app then can take as long as it wants to figure out what work needs to be done,
/// and when we’re finished we call the closure to send back data to Siri.
/// Using a closure to send back data rather than returning a value from the function means
/// Siri doesn’t need to wait for the function to complete, so it can keep its
/// user interface interactive – it won’t freeze up.
///
/// Another common example is making network requests. Your average iPhone can do several
/// billion things a second, but connecting to a server in Japan takes half a second or more –
/// it’s almost glacial compared to the speed things happen on your device.
/// So, when we request data from the internet we do so with closures: “please fetch this data,
/// and when you’re done run this closure.” Again, it means we don’t force
/// our user interface to freeze while some slow work is happening.
///





/// Trailing closure syntax
///
/// If the last parameter to a function is a closure, Swift lets you use special syntax
/// called trailing closure syntax. Rather than pass in your closure as a parameter,
/// you pass it directly after the function inside braces.
///
/// To demonstrate this, here’s our travel() function again. It accepts an action closure
/// so that it can be run between two print() calls:
///
func travel1(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

/// Because its last parameter is a closure, we can call travel()
/// using trailing closure syntax like this:
///
travel1() {
    print("I'm driving in my car")
}

/// In fact, because there aren’t any other parameters, we can eliminate the parentheses entirely:
///
/// Trailing closure syntax is extremely common in Swift, so it’s worth getting used to.
///
travel1 {
    print("I'm driving in my car")
}





/// Why does Swift have trailing closure syntax?
///
/// Trailing closure syntax is designed to make Swift code easier to read,
/// although some prefer to avoid it.
///
/// Let’s start with a simple example first. Here’s a function that accepts a Double
/// then a closure full of changes to make:
///
/// (In case you were wondering, that’s a simplified version of a real and very common UIKit function!)
///
func animate(duration: Double, animations: () -> Void) {
    print("Starting a \(duration) second animation...")
    animations()
}

/// We can call that function without a trailing closure like this:
///
/// That’s very common. Many people don’t use trailing closures, and that’s OK.
/// But many more Swift developers look at the }) at the end and wince a little – it isn’t pleasant.
///
animate(duration: 3, animations: {
    print("Fade out the image")
})

/// Trailing closures allow us to clean that up, while also removing the animations parameter label.
/// That same function call becomes this:
///
animate(duration: 3) {
    print("Fade out the image")
}

/// Trailing closures work best when their meaning is directly attached to the name of the function –
/// you can see what the closure is doing because the function is called animate().
///
/// If you’re not sure whether to use trailing closures or not, my advice is to start
/// using them everywhere. Once you’ve given them a month or two you’ll have enough usage
/// to look back and decide more clearly, but hopefully you get used to them
/// because they are really common in Swift!
///
