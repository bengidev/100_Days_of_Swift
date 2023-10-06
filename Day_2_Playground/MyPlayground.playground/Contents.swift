import Cocoa

/// Arrays
///
/// Arrays are collections of values that are stored as a single value.
/// For example, John, Paul, George, and Ringo are names, but arrays let you group them
/// in a single value called The Beatles.
///
/// In code, we write this:
///
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

/// That last line makes the array: it starts and ends with brackets,
/// with each item in the array separated by a comma.
///
let beatles = [john, paul, george, ringo]

/// You can read values from an array by writing a number inside brackets. Array positions count from 0,
/// so if you want to read “Paul McCartney” you would write this:
///
let beatleNumber2 = beatles[1]

/// Be careful: Swift crashes if you read an item that doesn’t exist.
/// For example, trying to read beatles[9] is a bad idea.
///
/// If you’re using type annotations, arrays are written in brackets: [String], [Int], [Double], and [Bool].
///

/// Why does Swift have arrays?
///
/// Swift’s strings, integers, Booleans, and Doubles allow us to temporarily store single values,
/// but if you want to store many values you will often use arrays instead.
///
/// We can create constants and variables of arrays just like other types of data, but the difference is
/// that arrays hold many values inside them. So, if you want to store the names of weekdays,
/// the temperature forecast for the next week, or the high scores for a video game,
/// you’ll want an array rather than a single value.
///
/// Arrays in Swift can be as large or as small as you want. If they are variable,
/// you can add to them freely to build up your data over time, or you can remove
/// or even rearrange items if you want.
///
/// We read values out of arrays using their numerical position, counting from 0. This “counting from 0”
/// has a technical term: we can say that Swift’s arrays are zero-based.
/// Swift will automatically crash your program if you attempt to read an array using an invalid index.
/// For example, creating an array with three items then trying to read index 10.
///
/// I know what you’re thinking: an app crash is bad, right? Right. But trust me:
/// if Swift didn’t crash then it’s very likely you would get back bad data,
/// because you tried to read a value outside what your array holds.
///

/// Sets
///
/// Sets are collections of values just like arrays, except they have two differences:
/// - Items aren’t stored in any order; they are stored in what is effectively a random order.
/// - No item can appear twice in a set; all items must be unique.
///
/// You can create sets directly from arrays, like this:
///
/// When you look at the value of colors inside the playground output you’ll see it doesn’t match
/// the order we used to create it. It’s not really a random order, it’s just unordered –
/// Swift makes no guarantees about its order. Because they are unordered, you can’t read values
/// from a set using numerical positions like you can with arrays.
///
let colors = Set(["red", "green", "blue"])

/// If you try to insert a duplicate item into a set, the duplicates get ignored. For example:
///
/// The final colors2 set will still only include red, green, and blue once.
///
let colors2 = Set(["red", "green", "blue", "red", "blue"])

/// Why are sets different from arrays in Swift?
///
/// Both sets and arrays are important in Swift, and understanding what their differences
/// are will help you understand which one to choose for any given circumstance.
///
/// Both sets and arrays are collections of data, meaning that they hold multiple values
/// inside a single variable. However, how they hold their values is what matters:
/// sets are unordered and cannot contain duplicates,
/// whereas arrays retain their order and can contain duplicates.
///
/// Those two differences might seem small, but they have an interesting side effect:
/// because sets don’t need to store your objects in the order you add them,
/// they can instead store them in a seemingly random order that optimizes them for fast retrieval.
/// So, when you say “does this set contain item X,”
/// you’ll get an answer in a split second no matter how big the set is.
///
/// In comparison, arrays must store their items in the order you give them,
/// so to check whether item X exists in an array containing 10,000 items Swift needs to start
/// at the first item and check every single item until it’s found – or perhaps it isn’t found at all.
///
/// This difference means that sets are more useful for times when you want to say
/// “does this item exist?” For example, if you want to check whether a word appears in a dictionary,
/// you should use a set: you don’t have duplicates, and you want to do a fast look up.
///

/// Tuples
///
/// Tuples allow you to store several values together in a single value. That might sound like arrays,
/// but tuples are different:
/// - You can’t add or remove items from a tuple; they are fixed in size.
/// - You can’t change the type of items in a tuple; they always have the same types they were created with.
/// - You can access items in a tuple using numerical positions or by naming them,
///     but Swift won’t let you read numbers or names that don’t exist.
///
/// Tuples are created by placing multiple items into parentheses, like this:
///
var name = (first: "Taylor", last: "Swift")

/// You then access items using numerical positions starting from 0:
///
print(name.0)

/// Or you can access items using their names:
///
print(name.first)

/// Remember, you can change the values inside a tuple after you create it, but not the types of values.
/// So, if you tried to change name to be (first: "Justin", age: 25) you would get an error.
///

/// How are tuples different from arrays in Swift?
///
/// When you’re learning Swift tuples and arrays can seem like they are the same thing,
/// but really they couldn’t be much more different.
///
/// Both tuples and arrays allow us to hold several values in one variable, but tuples hold a fixed set of things
/// that can’t be changed, whereas variable arrays can have items added to them indefinitely.
///
/// For example, if we wanted a variable tuple to store a website, we might write this:
///
/// If we wanted to add to that the date we last visited the site, we couldn’t –
/// it’s two string items, name and url, nothing more. Because they are specific and named,
/// Swift lets us read them back as website.name and website.url.
///
var website = (name: "Apple", url: "www.apple.com")

/// In comparison, if we wanted an array instead we might have written this:
///
/// That no longer has names, so we need to read the values using integers: website[0] and website[1].
/// We can also add more things to it freely, because it’s a variable array –
/// it can hold any number of strings, rather than just the two we specified.
///
var website1 = ["Apple", "www.apple.com"]

/// Another advantage to tuples is that each value is specifically created by you, so as well as providing
/// a name you also provide a type. So, you could create a tuple like this one:
///
/// That combines a string, an integer, and a Boolean in a single value, which would be pretty ugly in an array.
///
var person = (name: "Bengi", age: 25, isMarried: false)

/// Dictionaries provide an interesting third case, because they give us some of the name safety of tuples
/// but can grow and change like arrays. I say “some of the name safety” because we can’t guarantee
/// that a particular value exists in a dictionary like we can with a tuple –
/// we just need to try reading it and handle the optional that comes back.
///

/// Arrays vs sets vs tuples
///
/// Arrays, sets, and tuples can seem similar at first, but they have distinct uses.
/// To help you know which to use, here are some rules.
///
/// If you need a specific, fixed collection of related values where each item has a
/// precise position or name, you should use a tuple:
///
let address = (house: 555, street: "Unknown Street", city: "Nashville")

/// If you need a collection of values that must be unique or you need to be able to check
/// whether a specific item is in there extremely quickly, you should use a set:
///
let set = Set(["aardvark", "astronaut", "azalea"])

/// If you need a collection of values that can contain duplicates,
/// or the order of your items matters, you should use an array:
///
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

/// Arrays are by far the most common of the three types.
///

/// When should you use an array, a set, or a tuple in Swift?
///
/// Because arrays, sets, and tuples work in slightly different ways, it’s important
/// to make sure you choose the right one so your data is stored correctly and efficiently.
///
/// Remember: arrays keep the order and can have duplicates, sets are unordered and
/// can’t have duplicates, and tuples have a fixed number of values of fixed types inside them.
///
/// So:
/// - If you want to store a list of all words in a dictionary for a game,
///     that has no duplicates and the order doesn’t matter so you would go for a set.
/// - If you want to store all the articles read by a user, you would use a set if the order
///     didn’t matter (if all you cared about was whether they had read it or not),
///     or use an array if the order did matter.
/// - If you want to store a list of high scores for a video game, that has an order that matters
///     and might contain duplicates (if two players get the same score), so you’d use an array.
/// - If you want to store items for a todo list, that works best when the order is predictable
///     so you should use an array.
/// - If you want to hold precisely two strings, or precisely two strings and an integer,
///     or precisely three Booleans, or similar, you should use a tuple.
///

/// Dictionaries
///
/// Dictionaries are collections of values just like arrays, but rather than storing things
/// with an integer position you can access them using anything you want.
///
/// The most common way of storing dictionary data is using strings. For example,
/// we could create a dictionary that stores the height of singers using their name:
///
/// Just like arrays, dictionaries start and end with brackets and each item is separated with a comma.
/// However, we also use a colon to separate the value you want to store (e.g. 1.78)
/// from the identifier you want to store it under (e.g. “Taylor Swift”).
///
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73,
]

/// These identifiers are called keys, and you can use them to read data back out of the dictionary:
///
print(heights["Taylor Swift", default: 0.0])

/// When using type annotations, dictionaries are written in brackets with a colon
/// between your identifier and value types. For example, [String: Double] and [String: String].
///

/// Why does Swift have dictionaries as well as arrays?
///
/// Dictionaries and arrays are both ways of storing lots of data in one variable,
/// but they store them in different ways: dictionaries let us choose a “key” that identifies
/// the item we want to add, whereas arrays just add each item sequentially.
///
/// So, rather than trying to remember that array index 7 means a user’s country,
/// we could just write user["country"] – it’s much more convenient.
///
/// Dictionaries don’t store our items using an index, but instead they optimize
/// the way they store items for fast retrieval. So, when we say user["country"] it will send back
/// the item at that key (or nil) instantly, even if we have a dictionary with 100,000 items inside.
///
/// Remember, you can’t be guaranteed that a key in a dictionary exists. This is why reading a value
/// from a dictionary might send back nothing – you might have requested a key that doesn’t exist!
///

/// Dictionary default values
///
/// If you try to read a value from a dictionary using a key that doesn’t exist,
/// Swift will send you back nil – nothing at all. While this might be what you want,
/// there’s an alternative: we can provide the dictionary with a default value to use
/// if we request a missing key.
///
/// To demonstrate this, let’s create a dictionary of favorite ice creams for two people:
///
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla",
]

/// We can read Paul’s favorite ice cream like this:
///
favoriteIceCream["Paul"]

/// But if we tried reading the favorite ice cream for Charlotte, we’d get back nil,
/// meaning that Swift doesn’t have a value for that key:
///
favoriteIceCream["Charlotte"]

/// We can fix this by giving the dictionary a default value of “Unknown”,
/// so that when no ice cream is found for Charlotte we get back “Unknown” rather than nil:
///
print(favoriteIceCream["Charlotte", default: "Unknown"])

/// Why does Swift have default values for dictionaries?
///
/// Whenever you read a value from a dictionary, you might get a value back or
/// you might get back nil – there might be no value for that key. Having no value
/// can cause problems in your code, not least because you need to add extra functionality
/// to handle missing values safely, and that’s where dictionary default values come in:
/// they let you provide a backup value to use for when the key you ask for doesn’t exist.
///
/// For example, here’s a dictionary that stores the exam results for a student:
///
let results = [
    "english": 100,
    "french": 85,
    "geography": 75,
]

/// As you can see, they sat three exams and scored 100%, 85%, and 75% for English, French, and Geography.
/// If we wanted to read their history score, how we do it depends on what we want:
/// - If a missing value means the student failed to take the test, then we could use
///     a default value of 0 so that we always get an integer back.
/// - If a missing value means the student has yet to take the exam, then we should skip
///     the default value and instead look for a nil value.
///
/// So, it’s not like you always need a default value when working with dictionaries, but when you do it’s easy:
///
let historyResult = results["history", default: 0]

/// Creating empty collections
///
/// Arrays, sets, and dictionaries are called collections, because they collect values together in one place.
///
/// If you want to create an empty collection just write its type followed by opening and closing parentheses.
/// For example, we can create an empty dictionary with strings for keys and values like this:
///
var teams1 = [String: String]()

/// We can then add entries later on, like this:
///
teams1["Paul"] = "Red"

/// Similarly, you can create an empty array to store integers like this:
///
var results1 = [Int]()

/// The exception is creating an empty set, which is done differently:
///
/// This is because Swift has special syntax only for dictionaries and arrays;
/// other types must use angle bracket syntax like sets.
///
var words = Set<String>()
var numbers = Set<Int>()

/// If you wanted, you could create arrays and dictionaries with similar syntax:
///
var scores2 = Dictionary<String, Int>()
var results2 = Array<Int>()

/// Why would you want to create an empty collection?
///
/// When you’re just learning Swift, it’s common to see examples such as this one:
///
/// That’s a constant array of six strings, and because it’s constant it means
/// we can’t add more things to the array – we know all our items when the array is created,
/// so the rest of our program is just using that fixed data.
///
let names = ["Eleanor", "Chidi", "Tahani", "Jianyu", "Michael", "Janet"]

/// But sometimes you don’t know all your data up front, and in those cases it’s more common
/// to create an empty collection then add things as you calculate your data.
///
/// For example, we have our fixed names array above, and if we wanted to figure out
/// which names started with J then we would:
/// - Creating an empty string array called something like jNames
/// - Go over every name in the original names array and check whether it starts with “J”
/// - If it does, add it to the jNames array.
///
/// When we’ve gone over all the names, we’ll end up with two strings in jNames: Jianyu and Janet.
/// Of course, if our check was which names started with “X” then we’d end up with
/// no names in the array – and that’s OK. It started as empty and ended as empty.
///

/// Enumerations
///
/// Enumerations – usually called just enums – are a way of defining groups of related values
/// in a way that makes them easier to use.
///
/// For example, if you wanted to write some code to represent the success or failure
/// of some work you were doing, you could represent that as strings:
///
let result = "failure"

/// But what happens if someone accidentally uses different naming?
///
/// All those three are different strings, so they mean different things.
///
let result2 = "failed"
let result3 = "fail"

/// With enums we can define a Result type that can be either success or failure, like this:
///
enum Result {
    case success
    case failure
}

/// And now when we use it we must choose one of those two values:
///
/// This stops you from accidentally using different strings each time.
///
let result4 = Result.failure

/// Why does Swift need enums?
///
/// Enums are an extraordinarily powerful feature of Swift, and you’ll see them used
/// in a great many ways and places. Many languages don’t have enums and get by just fine,
/// so you might wonder why Swift needs enums at all!
///
/// Well, at their simplest an enum is simply a nice name for a value. We can make an enum
/// called Direction with cases for north, south, east, and west, and refer to those in our code.
/// Sure, we could have used an integer instead, in which case we’d refer to 1, 2, 3, and 4,
/// but could you really remember what 3 meant? And what if you typed 5 by mistake?
///
/// So, enums are a way of us saying Direction.north to mean something specific and safe.
/// If we had written Direction.thatWay and no such case existed, Swift would simply
/// refuse to build our code – it doesn’t understand the enum case. Behind the scenes,
/// Swift can store its enum values very simply, so they are much faster to create and
/// store than something like a string.
///

/// Enum associated values
///
/// As well as storing a simple value, enums can also store associated values attached to each case.
/// This lets you attach additional information to your enums so they can represent more nuanced data.
///
/// For example, we might define an enum that stores various kinds of activities:
///
/// That lets us say that someone is talking, but we don’t know what they are talking about,
/// or we can know that someone is running, but we don’t know where they are running to.
///
enum Activity {
    case bored
    case running
    case talking
    case singing
}

/// Enum associated values let us add those additional details:
///
enum Activity2 {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

/// Now we can be more precise – we can say that someone is talking about football:
///
let talking = Activity2.talking(topic: "Football")

/// Why would you want to associate a value with an enum case?
///
/// One of the most powerful features of Swift’s enums is their ability to store one or
/// more associated values – extra pieces of information that describe the enum case in more detail.
///
/// Associated values can be attached to every case, or only some cases. Plus, each case can have
/// as many associated values as you want, as long as each one has a type.
///
/// For example, we might create a Weather enum with three cases:
///
/// That means our weather can be sunny, it can be windy, or it can be rainy. However, when it’s windy
/// we’re also asking to store how fast the wind is as an integer – whether it’s 10 kilometers per hour (kph),
/// 20, 30, and so on. And when it’s rainy, we’re storing a percentage chance of the rain happening and
/// a volume value, storing how much rain will store.
///
enum Weather {
    case sunny
    case windy(speed: Int)
    case rainy(chance: Int, amount: Int)
}

/// We could do something similar, but it would be pretty unpleasant. Imagine this:
///
/// That gives us more ways to describe windy weather, but it’s very imprecise –
/// we’ve gone from being able to distinguish between a 10kph wind and a 15kph wind.
/// Worse, if you hadn’t seen the list ordered like it is above, would you know that
/// aBitWindy was supposed to be stronger than lightBreeze but less strong than quiteBlusteryNow?
///
/// Now imagine trying to work with the rainy case, where we need to store two integers.
/// We’d end up having to have cases that describe a low chance of light rain,
/// a low chance of moderate rain, a low chance of heavy rain, a moderate chance of light rain,
/// a moderate chance of moderate rain… well, you get the point.
///
enum AbsurdWeather {
    case sunny
    case lightBreeze
    case aBitWindy
    case quiteBlusteryNow
    case nowThatsAStrongWind
    case thisIsSeriousNow
    case itsAHurricane
}

/// So, enums with associated values let us add extra information to an enum case –
/// think of them as being adjectives to a noun, because it lets us describe the thing in more detail.
///

/// Enum raw values
///
/// Sometimes you need to be able to assign values to enums so they have meaning.
/// This lets you create them dynamically, and also use them in different ways.
///
/// For example, you might create a Planet enum that stores integer values for each of its cases:
///
enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}

/// Swift will automatically assign each of those a number starting from 0, and you can use that number
/// to create an instance of the appropriate enum case. For example, earth will be given the number 2,
/// so you can write this:
///
let earth = Planet(rawValue: 2)

/// If you want, you can assign one or more cases a specific value, and Swift will generate the rest.
/// It’s not very natural for us to think of Earth as the second planet, so you could write this:
///
/// Now Swift will assign 1 to mercury and count upwards from there, meaning that earth is now the third planet.
///
enum PlanetOne: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

/// Why do Swift’s enums have raw values?
///
/// Think about an enum such as this one:
///
/// That lets us use values such as Mood.happy in our code, which is much safer and
/// more efficient than storing “happy” as a string.
///
enum Mood {
    case happy
    case sad
    case grumpy
    case sleepy
    case hungry
}

/// Now think about stuff outside our code – if we were reading the user’s saved data,
/// or downloading something from the internet. Sure, our Swift code knows what Mood.happy means,
/// but how could we send that value over the internet?
///
/// I know this sounds a bit philosophical, but I want you to think about what Mood.happy really is.
/// How is it stored when our program runs? The point is that we don’t really care most of the time –
/// Swift could internally store it as the number 556, and it wouldn’t make any difference.
/// All we care about is that we get the safety and performance that enums bring.
///
/// However, things get more complex when we do need to know how the value is stored.
/// If we need to download a list of users from the internet and know what their current mood is,
/// then that server needs to be able to send that data in a way we can understand.
///
/// That’s where enum raw values come in: they let us use enums just like we normally would,
/// but also attach an underlying value to each case. Inside our Swift code this mostly won’t have any effect,
/// but it does mean we now have a specific, fixed way of referring to each value for the times we need it.
///
/// So, for our Mood enum we could ask Swift to provide integer values for each of our cases like this:
///
enum MoodOne: Int {
    case happy
    case sad
    case grumpy
    case sleepy
    case hungry
}

/// In our code we can carry on writing Mood.happy, Mood.sad, and so on, just like before.
/// However, now we can also download some data from a server, and be told “this user has mood 0,”
/// and match that up with Mood.happy.
///

