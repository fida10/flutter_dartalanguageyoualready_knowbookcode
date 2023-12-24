void main() {
  //the main function. all executable code goes here
  variablePlayground(); //call to a function, which has code we can reuse by calling its name

  stringPlayground();

  consumeClosure();

  int dayOfWeek = 7;
//String myDay = getDay(dayOfWeek);
  var myDay = switch (dayOfWeek) {
    1 => 'Monday',
    2 => 'Tuesday',
    3 => 'Wednesday',
    4 => 'Thursday',
    5 => 'Friday',
    6 => 'Saturday',
    7 => 'Sunday',
    _ => 'Invalid day' //Default value
  }; //note that switch statements also work with fat arrow notation; this is more succinct
  print(myDay);

  classPlayground();

  collectionPlayground();

  higherOrderFunctions();

  cascadePlayground();

  testExtension();

  int? someNumber; //? means this value can be null
  increaseValue(someNumber);
  int y =
      21; //can also put regular non-null values in places expecting a nullable type
  increaseValue(y);

  var bruce = Person('Bruce', 'Wayne', age: 42);
  if ((bruce.age ?? 0) < 18) {
    //if bruce.age is null, give it a default value of 0 with null coalescing; check bruce.age against 18
    print('Minor');
  }

  Person? person;
  print(person?.name); //?. is the null aware operator. this will print null
  //print(person!.name); //this on the other hand will give a runtime error
  //we are telling dart with ! that the person is not null
  //but person is null
  //so dart throws an error

  var clark = Person.fromMap({'name': 'Clark', 'surname': 'Kent'});
  print(clark.age); //will give null, as age has not been initialized for clark
 // print(clark.age!); will give an exception; expected clark.age to not be null due to !

  clark
    ..name = 'Superman'
    ..age = 654; //another usage of the spread operator
  print(clark.age);
  //this now gives a value, since we set it above, so no longer null
}

//part 1: Declaring variables—var versus final versus const
void variablePlayground() {
  basicTypes(); //another function call
  untypedVariables();
  typeInterpolation();
  immutableVariables();
}

void basicTypes() {
  int four = 4;
  double pi = 3.14;
  num someNumber = 24601;
  bool yes = true;
  bool no = false;
  //above has various types of variables, like bool, num, double, etc.
  int? nothing;
  //? -> can be null
  print(four);
  print(pi);
  print(someNumber);
  print(yes);
  print(no);
  print(nothing == null);
  //above variables are 'mutable'; they can be changed after being declared
}

void untypedVariables() {
  dynamic something = 14.2; //dynamic means the variable can be of any type
  //avoid unless absolutely needed
  print(something.runtimeType); //outputs 'double'
}

void typeInterpolation() {
  var anInteger = 15;
  var aDouble = 27.6;
  var aBoolean = false;
  //can use 'var', which means dart will set the type at compile time
  //different from dynamic, which sets a variables type as any type, or 'dynamic' type
  print(anInteger.runtimeType);
  print(anInteger);
  print(aDouble.runtimeType);
  print(aDouble);
  print(aBoolean.runtimeType);
  print(aBoolean);
}

void immutableVariables() {
  final int immutableInteger = 5;
  final double immutableDouble = 0.015;
// Type annotation is optional
  final interpolatedInteger = 10;
  final interpolatedDouble = 72.8;
  //'final' means a variable's value cannot be changed after it is declared. The value is set at runtime
  //the type also does not need to be specified, as it can be interpolated
  //a note: final data structures can be modified (their innards I mean, not the data structure itself)
  print(interpolatedInteger);
  print(interpolatedDouble);
  const aFullySealedVariable = true;
  //on the other hand, const is completely unmodifiable
  //the values are set before compilation as part of compilation
  //this can often improve performance as it does not consume runtime resources
  print(aFullySealedVariable);
}

//part 2: Strings and string interpolation
void stringPlayground() {
  basicStringDeclaration();
  multiLineStrings();
  combiningStrings();
}

void basicStringDeclaration() {
// With Single Quotes
  print('Single quotes');
  final aBoldStatement = 'Dart isn\'t loosely typed.';
  print(aBoldStatement);
//raw string
  print('Raw String');
  final rawString = r'Show an escape \ character';
  //Raw strings can also be useful whenever you want to treat your characters literally, like in regular expressions or file paths.
  print(rawString);
// With Double Quotes
  print("Hello, World");
  final aMoreMildOpinion = "Dart's popularity has skyrocketed with Flutter!";
  print(aMoreMildOpinion);
// Combining single and double quotes
  final mixAndMatch =
      'Every programmer should write "Hello, World" when learning a new language.';
  print(mixAndMatch);
}

void multiLineStrings() {
  final withEscaping = 'One Fish\nTwo Fish\nRed Fish\nBlue Fish';
  print(withEscaping);
// pay attention to any spaces left at the beginning
// of the lines when using '''
  final hamlet = '''
To be, or not to be, that is the question:
Whether 'tis nobler in the mind to suffer
The slings and arrows of outrageous fortune,
Or to take arms against a sea of troubles
And by opposing end them.
''';
  print(hamlet);
}

void combiningStrings() {
  traditionalConcatenation();
  modernInterpolation();
}

void traditionalConcatenation() {
  final hello = 'Hello';
  final world = "world";
  final combined = hello + ' ' + world;
  print(combined);
}

void modernInterpolation() {
  final year = 2011;
  final interpolated = 'Dart was announced in $year.';
  print(interpolated);
  final age = 42;
  final howOld = 'I am $age ${age == 1 ? 'year' : 'years'} old.';
  print(howOld);
}

//part 3: How to write functions
void functionPlayground() {
  classicalFunctions();
  optionalParameters();
}

void printMyName(String name) {
  print('Hello $name');
}

int add(int a, int b) {
  return a + b;
}

int factorial(int number) {
  if (number <= 0) {
    return 1;
  }
  return number * factorial(number - 1);
}

void optionalParameters() {
  unnamed('Huxley', 3); //note with square brackets, the params are not called
  unnamed();
// Notice how named parameters can be in any order
  named(greeting: 'Greetings and Salutations');
  named(name: 'Sonia');
  named(name: 'Alex', greeting: 'Bonjour'); //notice how here
  final multiply = duplicate('Mikey', times: 3);
  print(multiply);
}

void classicalFunctions() {
  printMyName('Anna');
  printMyName('Michael');
  final sum = add(5, 3);
  print(sum);
  print('10 Factorial is ${factorial(10)}');
}

void unnamed([String? name, int? age]) {
  //parameters using regular lists (don't have to specify parameter name, see above call)
  final actualName = name ?? 'Unknown';
  final actualAge = age ?? 0;
  print('$actualName is $actualAge years old.');
}

void named({String? greeting, String? name}) {
  //parameters using initializer lists
  final actualGreeting = greeting ?? 'Hello';
  final actualName = name ?? 'Mystery Person';
  print('$actualGreeting, $actualName!');
}

String duplicate(String name, {int times = 1}) {
  final merged = StringBuffer(name);
  for (var i = 1; i < times; i++) {
    merged.write(' $name');
  }
  return merged.toString();
}

//part 4: How to write functions
void callbackExample(void Function(String value) callback) {
  callback('Hello Callback');
}

void printSomething(String value) {
  print(value);
}

typedef NumberGetter = int
    Function(); //typedefs are a convenient way to store large variable types or function signatures

int powerOfTwo(NumberGetter getter) {
  //takes a closure as input
  return getter() * getter();
}

void consumeClosure() {
  int getFour() => 4; //a closure, with fat arrow notation
  //fat arrow notation should only be used for single line functions
  //for more complex stuff, stick to blocks {}
  final squared = powerOfTwo(getFour);
  print(squared);
  callbackExample(printSomething);
}

String getDay(int day) {
  switch (day) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default: //default specified here in case all of the above cases do not match
      return 'Invalid day';
  }
  //using a switch statement for control flow
  //syntax is case <insert expected value here>: <insert some work to be done if expected value matches actual value in switch statement>
}

//part 5: Creating classes and using the class constructor shorthand
void classPlayground() {
  final name = OfficialName('Mr', 'Clark', 'Kent');
  final message = name.toString();
  print(message);
}

class Name {
  final String first;
  final String last; //fields
  Name(this.first, this.last); //constructor
  //use 'this' keyword to refer to items of the current class
  @override
  String toString() {
    //method
    return '$first $last';
  }
}
//creating a "class", basically our own type, with its own fields, methods and a constructor to create objects of this type

class OfficialName extends Name {
// Private properties begin with an underscore
  final String _title;
// You can add colons after constructor
// to parse data or delegate to super
  OfficialName(this._title, String first, String last)
      : super(first,
            last); //use 'super' keyword to refer to items of the parent class
  @override
  String toString() {
    return '$_title. ${super.toString()}';
  }
}
//above is a subclass of Name; it has access to all of Name's fields, methods and classes and can override them with its own

//in addition to extends, we have the following:
//implements - for implementing interfaces, classes whose items must ALL be overriden
//with - for use with mixins, class like structures that can modify multiple, unrelated classes without modifying the class itself

//part 6: How to group and manipulate data with collections
/*
Data structures in dart and their equivalents in other languages: 
Dart Java Swift JavaScript
List ArrayList Array Array
Map HashMap Dictionary Object
Set HashSet Set Set
 */

void collectionPlayground() {
  listPlayground();
  mapPlayground();
  setPlayground();
  collectionControlFlow();
}

void listPlayground() {
// Creating with list literal syntax
  final List<int> numbers = [1, 2, 3, 5, 7]; //creates a list
  numbers.add(11); //adds one element to the list
  numbers.addAll(
      [8, 17, 35]); //adds multiple elements (in the form of a list) to the list
// Assigning via subscript
  numbers[1] = 15; //assign values of indexes within the list
  print('The second number is ${numbers[1]}');
  for (int number in numbers) {
    print(number); //looping through all values within the list using a for loop
  }
}

void mapPlayground() {
// Map Literal syntax
  final Map<String, int> ages = {
    'Clark': 26,
    'Peter': 35,
    'Bruce': 44,
  }; //create a map with soem initial values
// Subscript syntax uses the key type.
// A String in this case
  ages['Steve'] = 48; //insert a value into the map at a certain key
  final ageOfPeter = ages['Peter']; //retrieve the value of a certain key
  print('Peter is $ageOfPeter years old.');
  ages.remove('Peter'); //remove the value of a given key in a map
  ages.forEach((String name, int age) {
    //loops through each individual key value pair in the map
    print('$name is $age years old');
  });
}

void setPlayground() {
// Set literal, similar to Map, but no keys
  final Set<String> ministers = {
    'Justin',
    'Stephen',
    'Paul',
    'Jean',
    'Kim',
    'Brian'
  }; //creates a set
  ministers.addAll({
    'John',
    'Pierre',
    'Joe',
    'Pierre'
  }); //Pierre is a duplicate, which is not allowed in a set.
  final isJustinAMinister = ministers
      .contains('Justin'); //use containes to see if a set contains an element
  print(isJustinAMinister);
// 'Pierre' will only be printed once
// Duplicates are automatically rejected
  for (String primeMinister in ministers) {
    print('$primeMinister is a Prime Minister.');
  }
}

void collectionControlFlow() {
  final addMore = true;
  final randomNumbers = [
    34,
    232,
    54,
    32,
    if (addMore) ...[
      //also possible to use booleans to add stuff to a collection, in this case a list
      //if addMore is true, then add the below 3 elements to the randomNumbers list
      123,
      258,
      512,
    ],
  ];
  final doubled = [
    for (int number in randomNumbers) number * 2,
    //a form of list comprehension also works here it seems
    //each element inside randomNumbers is taken and multiplied by 2
    //syntax appears to be: for (<variable type> <variable name of individual element> in <list to take variables from>) <variable name of individual element> <insert operation to do on each number>
    //admittedly, the above is a lot easier with the map function haha
  ];
  print(doubled);
}

//part 7: Writing less code with higher-order functions
void higherOrderFunctions() {
  final names = mapping();
  names.forEach(print);
  sorting();
  filtering();
  reducing();
  flattening();
}

List<Map> data = [
  {'first': 'Nada', 'last': 'Mueller', 'age': 10},
  {'first': 'Kurt', 'last': 'Gibbons', 'age': 9},
  {'first': 'Natalya', 'last': 'Compton', 'age': 15},
  {'first': 'Kaycee', 'last': 'Grant', 'age': 20},
  {'first': 'Kody', 'last': 'Ali', 'age': 17},
  {'first': 'Rhodri', 'last': 'Marshall', 'age': 30},
  {'first': 'Kali', 'last': 'Fleming', 'age': 9},
  {'first': 'Steve', 'last': 'Goulding', 'age': 32},
  {'first': 'Ivie', 'last': 'Haworth', 'age': 14},
  {'first': 'Anisha', 'last': 'Bourne', 'age': 40},
  {'first': 'Dominique', 'last': 'Madden', 'age': 31},
  {'first': 'Kornelia', 'last': 'Bass', 'age': 20},
  {'first': 'Saad', 'last': 'Feeney', 'age': 2},
  {'first': 'Eric', 'last': 'Lindsey', 'age': 51},
  {'first': 'Anushka', 'last': 'Harding', 'age': 23},
  {'first': 'Samiya', 'last': 'Allen', 'age': 18},
  {'first': 'Rabia', 'last': 'Merrill', 'age': 6},
  {'first': 'Safwan', 'last': 'Schaefer', 'age': 41},
  {'first': 'Celeste', 'last': 'Aldred', 'age': 34},
  {'first': 'Taio', 'last': 'Mathews', 'age': 17},
];

List<Name> mapping() {
  //using Name, a class created previously
// Transform the data from raw maps to a strongly typed model
  final names = data.map<Name>((Map rawName) {
    //the 'map' higher order function, used to convert all elements in an iterable (a list in this case)
    final first = rawName['first'];
    final last = rawName['last'];
    return Name(first,
        last); //puts both first and last into an instance of the Name class (calls Name constructor, which joins the two into a single string), and returns the combined string, to be stored in the 'names' variable above
  }).toList(); //don't forget the toList() method!
  //the result of the map operation is an iterable. we want a list, so we convert toList
  return names;
}

void sorting() {
  final names =
      mapping(); //calling the above function and saving its result in 'names' variable
// Sort the list by last name
  names.sort((a, b) => a.last.compareTo(
      b.last)); //compareTo is a higher order function that sorts a given list
  //in this case, since names has strings, the Name's are sorted alphabetically
  //I think that the Name's toString method is being called implicitly to convert a and b (which are instances of Name) into strings, so that they can be compared and sorted alphabetically
  //since the Name class does not implement the CompareTo class

  //note that this modifies the original names map; it doesn't create a new one like the other higher order functions
  print('');
  print('Alphabetical List of Names');
  names.forEach(
      print); //same as a for each loop, loops through each element and does something
}

void filtering() {
  final names = mapping();
  final onlyMs = names.where((name) => name.last.startsWith(
      'M')); //creates a new iterable from 'names', with only elements that start with 'M'
  print('');
  print('Filters name list by M');
  onlyMs.forEach(print);
}

void reducing() {
// Merge an element of the data together
  final allAges = data.map<int>((person) => person['age']);
  //final total = allAges.reduce((total, age) => total + age); //adds all ages together and saves in total. Fold is better as it is more explicit
  final total = allAges.fold(
      0,
      (previousValue, element) =>
          previousValue +
          element); //the same as above but with fold. here we specify the starting (initial number) as 0
  final average = total / allAges.length;
  print('The average age is $average');
}

void flattening() {
  final matrix = [
    [1, 0, 0],
    [0, 0, -1],
    [0, 1, 0],
  ];
  final linear = matrix.expand<int>((row) =>
      row); //essentially combines the above 2d matrix into a single list
  //good for getting rid of 1 dimension
  print(linear);
}

//part 7: How to take advantage of the cascade operator
// Define a class named UrlBuilder
class UrlBuilder {
  // Declare a string variable named 'scheme' and initialize it with an empty string
  String scheme = '';
  // Declare a string variable named 'host' and initialize it with an empty string
  String host = '';
  // Declare a list of strings named 'routes' and initialize it with an empty list
  List<String> routes = [];

  // Override the toString method of the UrlBuilder class
  @override
  String toString() {
    // Create a list named 'paths' that includes 'host' and all elements of 'routes' if 'routes' is not empty
    final paths = [host, if (routes != []) ...routes];
    // Join all elements of 'paths' with '/' and assign the result to a string variable named 'path'
    final path = paths.join('/');
    // Return the string representation of the UrlBuilder object in the format 'scheme://path'
    return '$scheme://$path';
  }
}

/*
The UrlBuilder class is used to construct a URL string. It has three properties: 'scheme', 'host', and 'routes'. 
The 'scheme' represents the protocol (like 'http' or 'https'), 'host' represents the domain name, and 'routes' represents the path of the URL. 
The class overrides the toString method to return a string representation of the URL.
*/

// Define a function named 'cascadePlayground'
void cascadePlayground() {
  // Create a new instance of the UrlBuilder class and use cascade notation (..) to set its properties
  final url = UrlBuilder()
    ..scheme = 'https'
    ..host = 'dart.dev'
    ..routes = [
      'guides',
      'language',
      'language-tour#cascade-notation',
    ];
  // Print the string representation of the 'url' object
  print(url);

  // Create a list of integers named 'numbers' and use cascade notation (..) to insert a number at the beginning and sort the list
  final numbers = [42, 88, 53, 232, 55]
    ..insert(0, 8)
    ..sort((a, b) => a.compareTo(b));
  // Print the last element of the sorted 'numbers' list (which is the largest number)
  print('The largest number in the list is ${numbers.last}');
}

/*
The 'cascadePlayground' function demonstrates the use of cascade notation (..) in Dart. 
Cascade notation allows you to perform a series of operations on the same object. 
In this function, an instance of the UrlBuilder class is created and its properties are set using cascade notation. 
Then, a list of integers is created and modified using cascade notation. 
The function prints the string representation of the UrlBuilder object and the largest number in the list.
*/

//part 8: Using extensions
extension StringExtensions on String {
  //an extension on string
//it essentially "modifies" this String class without actually touching the real String class
//we can now call the toBool method from any instance of the string class, as we are doing below
  bool toBool() {
    return isNotEmpty;
  }
}

void testExtension() {
  String emptyString = "";
  String nonEmptyString = "Hello Extensions!";
  print(emptyString.toBool()); //--> false
  print(nonEmptyString.toBool()); //--> true
  //calling the toBool method from an instance of string, since we used an extension
}

//part 9: Introducing Dart Null Safety
void increaseValue(int? value) {
  // value = value ?? 0; //the null coalescing operator ?? checks if value is not null. if it not, original value is retained
  // //else, new value of 0 is assigned
  // value++;
  // print(value);

  //print(value != null ? value + 1 : 1); //a more succinct way to do the above but with ternary operators
  print((value ?? 0) +
      1); //an even more succinct way to do the above; checks if value is null, if it is, assigned a value of 0, and the result is incremented by 1
}

//part 10: Using Null Safety in classes
class Person {
  late String name;
  late String
      surname; //the late keyword tells dart that this may be null now but we give our assurances that this will not be null when it is actually used
  //if we break our word, we get a runtime error (exception)
  int? age; //age can be null
  Person(this.name, this.surname, {this.age});
  Person.fromMap(Map<String, dynamic> map) {
    // a named constructor
    name = map['name'];
    surname = map['surname'];
  }
}
