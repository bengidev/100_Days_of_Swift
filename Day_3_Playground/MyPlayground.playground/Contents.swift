import Cocoa

/// Arithmetic operators
///
/// Now you know all the basic types in Swift, we can start to put them together using operators.
/// Operators are those little mathematical symbols like + and -, and Swift has a huge range of them.
///
/// Here are a couple of test variables for us to work with:
///
let firstScore = 12
let secondScore = 4

/// We can add and subtract using + and -:
///
let total = firstScore + secondScore
let difference = firstScore - secondScore

/// And we can multiply and divide using * and /:
///
let product = firstScore * secondScore
let divided = firstScore / secondScore

/// Swift has a special operator for calculating remainders after division: %.
/// It calculates how many times one number can fit inside another,
/// then sends back the value that’s left over.
///
/// For example, we set secondScore to 4, so if we say 13 % secondScore we’ll get back one,
/// because 4 fits into 13 three times with remainder one:
///
let remainder = 13 % secondScore





/// Why can’t Swift add a Double to an Int?
///
/// Swift has a number of ways of storing data, such as strings, Booleans, and arrays.
/// But when it comes to working with numbers, it has several very specific types,
/// including Double, Float, and Int – there are many more than those,
/// but they are the most commonly used.
///
/// Swift has these different numerical types because they store their data differently.
/// For example, both Double and Int take the same amount of memory to store their number,
/// but Int only stores whole numbers whereas Double can store values after the decimal place.
///
/// So, at the simplest level you can see that adding a Double to an Int isn’t safe
/// because the Double can store things the Int can’t and that would be lost in the resulting integer.
///
/// Now, you might then think “well, how about when we add an Int to a Double we get back
/// a new Double that can store all the data?” And that’s a great question!
///
/// The problem is that although Double uses the same amount of memory to store its value as Int,
/// the way it stores its data is a little fuzzy – it has really great precision with smaller numbers,
/// but increasingly fuzzy precision when you start working with large numbers. In fact,
/// there are certain numbers that Double isn’t even able to hold,
/// so instead it stores a very slightly different value.
///
/// Helpfully, Swift even warns us when this happens. For example, try this code:
///
/// When you build that, Swift shows a warning: '90000000000000001' is not exactly representable
/// as 'Double'; it becomes '90000000000000000’.
///
//let value: Double = 90000000000000001

/// Integers lose the ability to store fractional values, but they gain the ability to store precise values.
/// This means the following code won’t produce a warning, because the number can be stored exactly:
///
//let value: Int = 90000000000000001

/// So, it isn’t safe to add a Double to an Int because we lose any numbers after the decimal point,
/// and it isn’t safe to add an Int to a Double because we lose some accuracy.
///
/// At this point, a third question might come to you: how about Swift lets us add an Int to a Double
/// only when it’s sure the resulting value can be stored safely? After all, it’s very rare
/// we need to work with numbers as big as 90000000000000001.
///
/// And that’s true, but the problem is that Swift can’t tell what your numbers will be
/// when you build your code, so we’re back to the problem of safety – sure, you might be working with
/// safe numbers most of the time, but Swift is specifically designed not to take risks
/// even when the unexpected happens.
///
/// As a result of all this, Swift will refuse to automatically convert between its various numeric types –
/// you can’t add an Int and a Double, you can’t multiply a Float and an Int, and so on.
///





/// Why does Swift have a dedicated division remainder operator?
///
/// Swift has an operator allows us to calculate the remainder after a division. This is sometimes called modulo,
/// but if you wanted to be really specific it isn’t quite the same thing.
///
/// First, let’s look at why it’s useful. If I said to you that there were 465 days until a special event,
/// how would you show that value to a user in a more useful way?
///
/// You might start with code like this:
///
let weeks = 465 / 7
print("There are \(weeks) weeks until the event.")

/// That will print that there are 66 weeks until the event, but that isn’t true. When faced
/// with two integers like this, Swift will divide the two and round towards zero to make a whole number.
/// 465 divided by 7 doesn’t equal exactly 66, so folks might miss your event entirely!
///
/// Your second attempt might tell Swift to use a Double rather than an Int, so we get a more accurate answer:
///
/// But now we get something that’s Technically Correct™ but not actually that useful:
/// there are 66.42857142857143 weeks until the event.
///
let weeksOne: Double = 465 / 7
print("There are \(weeks) weeks until the event.")

/// This is where the remainder operator comes in:
///
/// So, weeks divides 465 by 7 and rounds towards 0, giving 66 weeks,
/// then days uses the remainder operator to calculate how much was left over.
///
let weeksTwo = 465 / 7
let daysTwo = 465 % 7
print("There are \(weeksTwo) and \(daysTwo) days until the event.")

/// The remainder operator is really useful and comes up a lot. For example,
/// many tables of data use “zebra striping” – they alternate the colors of rows
/// to make them easier to read.
///
/// If your goal is to ask “does this number divide equally into some other number?”
/// then Swift has an easier approach:
///
let number = 465
let isMultiple = number.isMultiple(of: 7)





/// Operator overloading
///
/// Swift supports operator overloading, which is a fancy way of saying that what an operator does
/// depends on the values you use it with. For example, + sums integers like this:
///
let meaningOfLife = 42
let doubleMeaning = 42 + 42

/// But + also joins strings, like this:
///
let fakers = "Fakers gonna "
let action = fakers + "fake"

/// You can even use + to join arrays, like this:
///
let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

/// Remember, Swift is a type-safe language, which means it won’t let you mix types.
/// For example, you can’t add an integer to a string because it doesn’t make any sense.
///





/// Why does Swift need operator overloading?
///
/// Operator overloading allows the same operator – +, *, /, and so on – to do different things
/// depending on what data you use it with. This allows us to use these symbols in various places
/// where they would make sense: we can add two integers using +, we can append one string to another
/// using +, we can join two arrays using +, and so on.
///
/// Of course, this doesn’t mean we can use all the operators in every place: we can subtract one integer
/// from another, but what would it mean to subtract one string from another? Would it subtract from the start
/// or the end? Would it subtract all instances of the string or just one?
///
/// When your skills grow you’ll find you can create your own custom operators if you want to,
/// and even modify Swift’s existing operators.
///





/// Compound assignment operators
///
/// Swift has shorthand operators that combine one operator with an assignment, so you can change
/// a variable in place. These look like the existing operators you know – +, -, *, and /,
/// but they have an = on the end because they assign the result back to whatever variable you were using.
///
/// For example, if someone scored 95 in an exam but needs to be penalized 5 points, you could write this:
///
var score = 95
score -= 5

/// Similarly, you can add one string to another using +=:
///
var quote =  "The rain in Spain falls mainly on the "
quote += "Spaniards"





/// Why does Swift have compound assignment operators?
///
/// If you want to add 5 to a score variable, you’re perfectly able to write score = score + 5 if you want.
/// Swift also allows us to write score += 5 to get the same result, but why?
///
/// Well, it isn’t for performance reasons – under the hood, Swift turns score += 5 into
/// score = score + 5 just as if we had written it.
///
/// Instead, they are just available as a shorthand: a simpler way to write the same thing.
/// This means less typing for us, less code to read, and also less chance of making mistakes – a win all around!
///






/// Comparison operators
///
/// Swift has several operators that perform comparison, and these work more or less
/// like you would expect in mathematics.
///
/// Let’s start with a couple of example variables so we have something to work with:
///
let firstScore1 = 6
let secondScore1 = 4

/// There are two operators that check for equality: == checks two values are the same,
/// and != (pronounced “not equals”) checks two values are not the same:
firstScore1 == secondScore1
firstScore1 != secondScore1

/// There are four operators for comparing whether one value is greater than,
/// less than, or equal to another. These are just like in mathematics:
///
firstScore1 > secondScore1
firstScore1 >= secondScore1
firstScore1 < secondScore1
firstScore1 <= secondScore1

/// Each of these also work with strings, because strings have a natural alphabetical order:
///
"Unknown" <= "Secret"





/// How does Swift let us compare many types of data?
///
/// Swift lets us compare many kinds of values out of the box, which means we can check
/// a variety of values for equality and comparison. For example, if we had values such as these:
///
let firstName = "Kenshin"
let secondName = "Himura"

let firstAge = 40
let secondAge = 30

/// Then we could compare them in various ways:
///
print(firstName == secondName)
print(firstName != secondName)
print(firstName < secondName)
print(firstName <= secondName)
print(firstName > secondName)
print(firstName >= secondName)

print(firstAge == secondAge)
print(firstAge != secondAge)
print(firstAge < secondAge)
print(firstAge <= secondAge)
print(firstAge > secondAge)
print(firstAge >= secondAge)

/// Behind the scenes, Swift implements this in a remarkably clever way that actually allows it
/// to compare a wide variety of things. For example, Swift has a special type for storing dates
/// called Date, and you can compare dates using the same operators: someDate < someOtherDate, for example.
///
/// We can even ask Swift to make our enums comparable, like this:
///
/// That will print “true”, because small comes before large in the enum case list.
///
enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large
print(first <  second)





/// Conditions
///
/// Now you know some operators you can write conditions using if statements. You give Swift a condition,
/// and if that condition is true it will run code of your choosing.
///
/// To try this out, I want to use a Swift function called print(): you run it with some text,
/// and it will be printed out.
///
/// We can use conditions to check for a winning Blackjack hand:
///
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21 {
    print("Blackjack!")
}

/// The code inside the braces – { and } – will be run if the condition is true.
/// If you want you can provide alternative code to run if the condition is false, using else:
///
if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}

/// You can also chain conditions together using else if:
///
if firstCard + secondCard == 2 {
    print("Aces - lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack")
} else {
    print("Regular cards")
}





/// What’s the difference between if and else if?
///
/// When you’re just learning Swift, it can be a bit hard to know when to use else,
/// when to use else if, and what the difference really is.
///
/// Well, let’s start with an example value we can work with:
///
let score1 = 9001

/// We could write a simple condition to check whether the score is over 9000 like this:
///
if score > 9000 {
    print("It's over 9000!")
}

/// Now, if we want to print a different message for scores equal to or under 9000,
/// we could write this:
///
if score > 900 {
    print("It's over 9000!")
}

if score <= 9000 {
    print("It's not over 9000!")
}

/// That works perfectly fine, and your code would do exactly what you expect.
/// But now we’ve given Swift more work to do: it needs to check the value of score twice.
/// That’s very fast here with a simple integer, but if our data was more complex
/// then it would be slower.
///
/// This is where else comes in, because it means “if the condition we checked wasn’t true,
/// run this code instead.”
///
/// So, we could rewrite our previous code to this:
///
/// With that change Swift will only check score once, plus our code is shorter and easier to read too.
///
if score > 9000 {
    print("It's over 9000!")
} else {
    print("It's not over 9000!")
}

/// Now imagine we wanted three messages: one when the score is over 9000,
/// one when exactly 9000, and one when it’s under 9000. We could write this:
///
if score > 9000 {
    print("It's over 9000!")
} else {
    if score == 9000 {
        print("It's exactly 9000!")
    } else {
        print("It's not over 9000!")
    }
}

/// Again, that’s exactly fine and works just like you would hope. However, we can make the code
/// easier to read by using else if, which lets us combine the else with the if directly after it,
/// like this:
///
if score > 9000 {
    print("It's over 9000!")
} else if score == 9000 {
    print("It's exactly 9000!")
} else {
    print("It's not over 9000!")
}

/// To try this out, I want to use a Swift function called print(): you run it with some text,
/// and it will be printed out.
///
/// That makes our code a little easier to read and understand, because rather than having nested conditions
/// we have a single flow we can read down.
///
/// You can have as many else if checks as you want, but you need exactly one if and either zero or one else.
///






/// Combining conditions
///
/// Swift has two special operators that let us combine conditions together:
/// they are && (pronounced “and”) and || (pronounced “or”).
///
/// For example, we could check that the age of two people are both over a certain value like this:
///
/// That print() call will only happen if both ages are over 18, which they aren’t. In fact,
/// Swift won’t even bother checking the value of age2 because it can see that age1 already failed the test.
///
let age1 = 12
let age2 = 20

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

/// The alternative to && is ||, which evaluates as true if either item passes the test.
/// For example we could print a message if either age is over 18:
///
if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}

/// You can use && and || more than once in a single condition, but don’t make things too complicated
/// otherwise it can be hard to read!
///





/// How to check multiple conditions
///
/// Swift gives us && and || for checking multiple conditions at the same time,
/// and when used with just two conditions they are fairly straightforward.
///
/// As an example, imagine we were running a forum where users could post messages,
/// and delete any messages they owned. We might write code like this:
///
let isOwner = false
let isAdmin = false
let isEditingEnabled = false

if isOwner == true || isAdmin == true {
    print("You can delete this post")
}

/// Where things get more confusing is when we want to check several things. For example,
/// we could say that regular users can delete messages only we allowed them,
/// but admins can always delete posts. We might write code like this:
///
if isOwner == true && isEditingEnabled || isAdmin == true {
    print("You can delete this post")
}

/// But what is that trying to check? What order are the && and || checks executed? It could mean this:
///
/// That says “if we’re the owner and editing is enabled you can delete the post,
/// or if you’re an admin you can delete the post even if you don’t own it.” That makes sense:
/// folks can delete their own posts if editing is allowed, but admins can always delete posts.
///
if (isOwner == true && isEditingEnabled) || isAdmin == true {
    print("You can delete this post")
}

/// However, you might also read it like this: {
///
if isOwner == true && (isEditingEnabled || isAdmin == true) {
    print("You can delete this post")
}

/// And now it means something quite different: “if you’re the owner of the post,
/// and either editing is enabled or you’re the admin, then you can delete the post.”
/// This means admins can’t delete posts they don’t own, which wouldn’t make sense.
///
/// Obviously Swift doesn’t like ambiguity like this, so it will always interpret
/// the code as if we had written this:
///
if (isOwner == true && isEditingEnabled) || isAdmin == true {
    print("You can delete this post")
}

/// However, honestly it’s not a nice experience to leave this to Swift to figure out,
/// which is why we can insert the parentheses ourselves to clarify exactly what we mean.
///
/// There is no specific advice on this, but realistically any time you mix && and || in a single condition
/// you should almost certainly use parentheses to make the result clear.
///





/// The ternary operator
///
/// Swift has a rarely used operator called the ternary operator. It works with three values at once,
/// which is where its name comes from: it checks a condition specified in the first value,
/// and if it’s true returns the second value, but if it’s false returns the third value.
///
/// The ternary operator is a condition plus true or false blocks all in one, split up by a question mark
/// and a colon, all of which which makes it rather hard to read. Here’s an example:
///
let firstCard1 = 11
let secondCard1 = 10
print(firstCard1 == secondCard1 ? "Cards are the same" : "Cards are different")

/// That checks whether the two cards are the same, then prints “Cards are the same” if the condition is true,
/// or “Cards are different” if it’s false. We could write the same code using a regular condition:
///
if firstCard1 == secondCard1 {
    print("Cards are the same")
} else {
    print("Cards are different")
}





/// When should you use the ternary operator in Swift?
///
/// The ternary operator lets us choose from one of two results based on a condition,
/// and does so in a really concise way:
///
let isAuthenticated = true
print(isAuthenticated ? "Welcome!" : "Who are you?")

/// Some people rely very heavily on the ternary operator because it makes for very short code,
/// whereas some stay away from it as much as possible because it can make code harder to read.
///
/// I’m very much in the “avoid where possible” camp because even though this code
/// is longer I do find it easier to follow:
///
if isAuthenticated {
    print("Welcome")
} else {
    print("Who are you?")
}

/// Now, there is one time when the ternary operator gets a lot of use and that’s with SwiftUI.
/// I don’t want to give code examples here because it can be a bit overwhelming,
/// but you can really go to town with the ternary operator there if you want to.
/// Even then, I prefer to remove them when possible, to make my code easier to read,
/// but you should try it for yourself and come to your own conclusions.
///






/// Switch statements
///
/// If you have several conditions using if and else if, it’s often clearer to use
/// a different construct known as switch case. Using this approach you write your condition once,
/// then list all possible outcomes and what should happen for each of them.
///
/// To try this out, here’s a weather constant containing the string sunny:
///
let weather = "sunny"

/// We can use a switch block to print one of four different messages:
///
/// In that example, the last case – default – is required because Swift makes sure
/// you cover all possible cases so that no eventuality is missed off.
/// If the weather is anything other than rain, snow, or sun, the default case will be run.
/// 
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}

/// Swift will only run the code inside each case. If you want execution
/// to continue on to the next case, use the fallthrough keyword like this:
///
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}





/// When should you use switch statements rather than if?
///
/// Swift developers can use both switch and if to check multiple values in their code,
/// and often there isn’t a hard reason why you should choose one rather than the other.
/// That being said, there are three reasons why you might want to consider using switch rather than if:
/// - Swift requires that its switch statements are exhaustive, which means
///     you must either have a case block for every possible value to check
///     (e.g. all cases of an enum) or you must have a default case.
///     This isn’t true for if and else if, so you might accidentally miss a case.
/// - When you use switch to check a value for multiple possible results, that value will only be read once,
///     whereas if you use if it will be read multiple times. This becomes more important when you start
///     using function calls, because some of these can be slow.
/// - Swift’s switch cases allow for advanced pattern matching that is unwieldy with if.
///
/// There’s one more situation, but it’s a little fuzzier: broadly speaking, if you want to check the same value
/// for three or more possible states, you’ll find folks prefer to use switch rather than if for legibility purposes
/// if nothing else – it becomes clearer that we’re checking the same value repeatedly, rather than writing different conditions.
///





/// Range operators
///
/// Swift gives us two ways of making ranges: the ..< and ... operators. The half-open range operator, ..<,
/// creates ranges up to but excluding the final value, and the closed range operator, ...,
/// creates ranges up to and including the final value.
///
/// For example, the range 1..<5 contains the numbers 1, 2, 3, and 4,
/// whereas the range 1...5 contains the numbers 1, 2, 3, 4, and 5.
///
/// Ranges are helpful with switch blocks, because you can use them for each of your cases.
/// For example, if someone sat an exam we could print different messages depending on their score:
///
/// As before, the default case must be there to ensure all possible values are covered.
///
let score2 = 85

switch score2 {
case 0..<50:
    print("You failed badly.")
case 0..<85:
    print("You did OK.")
default:
    print("You did great!")
}





/// Why does Swift have two range operators?
///
/// When we think about ranges of values, English is quite confusing. If I say “give me
/// the sales figures up to yesterday” does that mean including yesterday or excluding yesterday?
/// Both are useful in their own right, so Swift gives us a way of representing them both:
/// ..< is the half-open range that specifies “up to but excluding” and
/// ... is the closed range operator that specifies “up to and including”.
///
/// To make the distinction easier when talking, Swift regularly uses very specific language:
/// “1 to 5” means 1, 2, 3, and 4, but “1 through 5” means 1, 2, 3, 4, and 5. If you remember,
/// Swift’s arrays start at index 0, which means an array containing three items
/// have items at indexes 0, 1, and 2 – a perfect use case for the half-open range operator.
///
/// Things get more interesting when you want only part of a range, such as “anything from 0 upwards”
/// or “index 5 to the end of the array.” You see, these are fairly useful in programming,
/// so Swift make them easier to create by letting us specify only part of a range.
///
/// For example, if we had an array of names like this one:
///
let names = ["Piper", "Alex", "Suzanne", "Gloria"]

/// We could read out an individual name like this:
///
print(names[0])

/// With ranges, we can also print a range of values like this:
///
print(names[1...3])

/// With ranges, we can also print a range of values like this:
///
print(names[1...])

/// So, ranges are great for counting through specific values, but they are also helpful
/// for reading groups of items from arrays.
///
