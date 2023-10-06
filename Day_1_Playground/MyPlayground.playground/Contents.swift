import Cocoa

/// Variables
///
/// In this video I want to introduce you to variables, which are places where you can store program data.
///
/// They are called variables because they can vary – you can change their values freely.
/// That creates a new variable called greeting, giving it the value “Hello, playground”.
/// On the right of the playground you can see “Hello, playground” in the output area –
/// that’s Xcode showing us the value was set.
///
var greeting = "Hello, playground"

/// Because str is a variable we can change it:
///
/// We don’t need var the second time because the variable has already been created –
/// we’re just changing it.
///
greeting = "Goodbye"





/// Why does Swift have variables?
///
/// Variables allow us to store temporary information in our program,
/// and form a key part of almost every Swift program.
///
/// Of course, the “transforming it somehow” is where the real magic comes in,
/// because that’s the part where your brilliant app idea happens.
/// But the process of storing data in memory – holding on to something the user typed,
/// or something you downloaded from the internet – is where variables come in.
///
/// Once you create a variable using var, you can change it as often as you want
/// without using var again. For example:
///
/// If it helps, try reading var as “create a new variable”. So, the first line above
/// might be read out loud as “create a new variable called favoriteShow and
/// give it the value Orange is the New Black.” Lines 2 and 3 don’t have var in there,
/// so they modify the existing value rather than creating a new variable.
///
var favoriteShow = "Orange is the New Black"
favoriteShow = "The Good Place"
favoriteShow = "Doctor Who"





/// Strings and integers
///
/// Swift is what’s known as a type-safe language, which means that every variable
/// must be of one specific type. The str variable that Xcode created for us
/// holds a string of letters that spell “Hello, playground”, so Swift assigns it the type String.
///
var str = "Hello, playground"

/// On the other hand, if we want to store someone’s age we might make a variable like this:
/// That holds a whole number, so Swift assigns the type Int – short for “integer”.
///
var age = 38

/// If you have large numbers, Swift lets you use underscores as thousands separators –
/// they don’t change the number, but they do make it easier to read. For example:
///
var population = 8_000_000

/// Strings and integers are different types, and they can’t be mixed.
/// So, while it’s safe to change str to “Goodbye”,
/// I can’t make it 38 because that’s an Int not a String.
///





/// Why is Swift a type-safe language?
///
/// Swift lets us create variables as strings and integers, but also many other types of data too.
/// When you create a variable Swift can figure out what type the variable is based on what kind
/// of data you assign to it, and from then on that variable will always have that one specific type.
///
/// For example, this creates a new variable called meaningOfLife equal to 42:
///
/// Because we assigned 42 as the initial value of meaningOfLife, Swift will assign it the type integer –
/// a whole number. It’s a variable, which means we can change its value as often as we need to,
/// but we can’t change its type: it will always be an integer.
///
var meaningOfLife = 42

/// This is extremely helpful when building apps, because it means Swift will make sure we don’t make
/// mistakes with our data. For example, we can’t write this:
///
/// That tries to assign a string to a variable that is an integer, which isn’t allowed.
/// Although we rarely make such an obvious mistake, you will find that this type safety helps out
/// every single day you’re writing code with Swift.
///
/// Think about it: we just created one variable then tried to change its type, which will obviously fail.
/// But as your programs grow in size and complexity, it becomes impossible to keep the types of your variables
/// in your head at all times, so we’re effectively shifting that work on to Swift instead.
///
//meaningOfLife = "Forty Two"





/// Multi-line strings
///
/// Standard Swift strings use double quotes, but you can’t include line breaks in there.
/// If you want multi-line strings you need slightly different syntax:
/// start and end with three double quote marks, like this:
///
/// Swift is very particular about how you write those quote marks: the opening and closing triple
/// must be on their own line, but opening and closing line breaks won’t be included in your final string.
///
var str1 = """
This goes
over multiple
lines
"""

/// If you only want multi-line strings to format your code neatly, and you don’t want those line breaks
/// to actually be in your string, end each line with a \, like this:
///
var str2 = """
This goes \
over multiple \
lines
"""





/// Why does Swift need multi-line strings?
///
/// Swift’s standard strings start and end with quotes, but must never contain any line breaks.
/// For example, this is a standard string:
///
var quote = "Change the world by being yourself"

/// That works fine for small pieces of text, but becomes ugly in source code if you have lots of text
/// you want to store. That’s where multi-line strings come in: if you use triple quotes you can write
/// your strings across as many lines as you need, which means the text remains easy to read in your code:
///
/// Swift sees those line breaks in your string as being part of the text itself,
/// so that string actually contains three lines.
///
var burns = """
The best laid schemes
O’ mice and men
Gang aft agley
"""





/// Doubles and booleans
///
/// Two other basic types of data in Swift are doubles and booleans, and you’ll be using them a lot.
///
/// “Double” is short for “double-precision floating-point number”, and it’s a fancy way of saying
/// it holds fractional values such as 38.1, or 3.141592654.
///
/// Whenever you create a variable with a fractional number, Swift automatically
/// gives that variable the type Double. For example:
///
/// Doubles are different from integers, and you can’t mix them by accident.
///
var pi = 3.141

/// As for booleans, they are much simpler: they just hold either true or false, and Swift will automatically
/// assign the boolean type to any variable assigned either true or false as its value.
///
/// For example:
///
var awesome = true





/// Why does Swift need both Doubles and Integers?
///
/// Swift gives us several different ways of storing numbers in our code, and they are designed
/// to solve different problems. Swift doesn’t let us mix them together because doing so
/// will (as in, 100% guaranteed) lead to problems.
///
/// The two main types of numbers you’ll use are called integers and doubles. Integers hold whole numbers,
/// such as 0, 1, -100, and 65 million, whereas doubles hold decimal numbers, such as 0.1, -1.001, and 3.141592654.
///
/// When creating a numeric variable, Swift decides whether to consider it an integer or a double
/// based on whether you include a decimal point. For example:
///
/// As you can see, they both contain the number 1, but the former is an integer and the latter a double.
///
/// Now, if they both contain the number 1, you might wonder why we can’t add them together –
/// why can’t we write var total = myInt + myDouble? The answer is that Swift is playing it safe:
/// we can both see that 1 plus 1.0 will be 2, but your double is a variable so it could be modified
/// to be 1.1 or 3.5 or something else. How can Swift be sure it’s safe to add an integer to a double –
/// how can it be sure you won’t lose the 0.1 or 0.5?
///
var myInt = 1
var myDouble = 1.0





/// String interpolation
///
/// You’ve seen how you can type values for strings directly into your code, but Swift also has a feature
/// called string interpolation – the ability to place variables inside your strings to make them more useful.
///
/// You can place any type of variable inside your string – all you have to do is write a backslash, \,
/// followed by your variable name in parentheses. For example:
///
/// As you can see in the playground output, that sets the str variable to be “Your score was 85”.
///
var score = 85
var str3 = "Your score was \(score)"

/// You can do this as many times as you need, making strings out of strings if you want:
///
/// As you’ll see later on, string interpolation isn’t just limited to placing variables –
/// you can actually run code inside there.
///
var results = "The test results are here: \(str3)"





/// Why does Swift have string interpolation?
///
/// When it comes time to showing information to your user – whether that’s messages being printed out,
/// text on buttons, or whatever fits your app idea – you will usually rely heavily on strings.
///
/// Of course, we don’t just want static strings, because we want to show the user some sort of relevant data
/// they can use. So, Swift gives us string interpolation as a way of injecting custom data into strings
/// at runtime: it replaces one or more parts of a string with data provided by us.
///
/// For example:
///
/// Of course, in that trivial example we could have just written our city name directly into the string –
/// “Welcome to Cardiff!” – but in real apps having this inserted dynamically is important because it lets us
/// show real-world user data rather than things we typed ourselves.
///
/// Swift is capable of placing any kind of data inside string interpolation.
/// The result might not always be useful, but for all of Swift’s basic types –
/// strings, integers, Booleans, etc – the results are great.
///
var city = "Cardiff"
var message = "Welcome to \(city)"





/// Constants
///
/// I already said that variables have that name because their values can change over time,
/// and that is often useful. However, very often you want to set a value once and never change it,
/// and so we have an alternative to the var keyword called let.
///
/// The let keyword creates constants, which are values that can be set once and never again. For example:
///
/// If you try to change that, Xcode will refuse to run your code. It’s a form of safety:
/// when you use constants you can no longer change something by accident.
///
/// When you write your own Swift code, you should always use let unless you specifically want to change a value.
/// In fact, Xcode will warn you if you use var then don’t change the variable.
///
let name = "Anonymous"





/// Why does Swift have constants as well as variables?
///
/// Variables are a great way to store temporary data in your programs, but Swift gives us a second option
/// that’s even better: constants. They are identical to variables in every way, with one important difference:
/// we can’t change their values once they are set.
///
/// Swift really loves constants, and in fact will recommend you use one if you created a variable
/// then never changed its value. The reason for this is about avoiding problems: any variable you create
/// can be changed by you whenever you want and as often as you want, so you lose some control –
/// that important piece of user data you stashed away might be removed or replaced at any point in the future.
///
/// Constants don’t let us change values once they are set, so it’s a bit like a contract with Swift:
/// you’re saying “this value matters, don’t let me change it no matter what I do.” Sure,
/// you could try to make the same contract with a variable, but one slip of your keyboard could screw things up
/// and Swift wouldn’t be able to help. By using a constant instead – just by changing var to let –
/// you’re asking Swift to make sure the value never changes, which is another thing you no longer need to worry about.
///





/// Type annotations
///
/// Swift assigns each variable and constant a type based on what value it’s given when it’s created.
/// So, when you write code like this Swift can see it holds a string:
///
/// That will make str a string, so you can’t try to assign it an integer or a boolean later on.
/// This is called type inference: Swift is able to infer the type of something based on how you created it.
///
let str4 = "Hello, playground"

/// If you want you can be explicit about the type of your data rather than relying on Swift’s type inference, like this:
///
/// Notice that booleans have the short type name Bool, in the same way that integers have the short type name Int.
///
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true





/// Why does Swift have type annotations?
///
/// A common question folks ask when learning Swift is “why does Swift have type annotations?”,
/// which is usually followed by “when should I use type annotations in Swift?”
///
/// The answer to the first question is primarily one of three reasons:
/// - Swift can’t figure out what type should be used.
/// - You want Swift to use a different type from its default.
/// - You don’t want to assign a value just yet.
///
/// The first of those will usually happen only in more advanced code. For example, if you were loading some data
/// from the internet that you know happens to be the name of your local politician, Swift can’t know that
/// ahead of time so you’ll need to tell it.
///
/// The second scenario is quite common as you learn more in Swift, but right now a simple example is trying to
/// create a double variable without having to constantly write “.0” everywhere:
///
/// That makes percentage a double with the value of 99.0. Yes, we have assigned an integer to it,
/// but our type annotation makes it clear that the actual data type we want is double.
///
var percentage: Double = 99

/// The third option happens when you want to tell Swift that a variable is going to exist, but you don’t want
/// to set its value just yet. This happens in lots of places in Swift, and looks like this:
///
/// You can then assign a string to name later on, but you can’t assign a different type
/// because Swift knows it would be invalid.
///
var name1: String

/// Of course, the second question here is “when should I use type annotations in Swift?” This is much more subjective,
/// because the answer usually depends on your personal style.
///
/// In my own code, I prefer to use type inference as much as possible. That means I leave off the type annotations,
/// and let Swift figure out the type of things based on what data I store in them. My reasons for this are:
/// - It makes my code shorter and easier to read.
/// - It allows me to change the type of something just by changing whatever is its initial value.
///
/// Some other folks prefer to always use explicit type annotation, and that works fine too –
/// it really is a question of style.
///

