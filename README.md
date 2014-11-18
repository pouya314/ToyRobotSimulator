TITLE & DESCRIPTION
===================
Toy Robot Simulator

The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units. There are no other obstructions on the table surface. The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

ENVIRONMENTS
============
This application was developed on Mac OS X, version 10.9.5, however it should run on all Unix-like operating systems. The code has been run on the following environments which were found to be compatible:
- Ubuntu 14.04 x86_64
- Microsoft windows 8

SYSTEM DEPENDENCIES & CONFIGURATION
===================================
You need to have ruby installed on your system before installing and running the application. During development rbenv was used to install and manage ruby versions. The specific (local) ruby version used to develop this application was `2.1.2`.

To check your version, run:
`$ rbenv local`

To learn how to install ruby visit my blog post ([here](http://blog.parsalabs.com/blog/2013/08/27/setting-up-a-ruby-on-rails-4-development-environment-on-a-clean-mac-os-x-installation/)). It will show you, step-by-step, how to setup a complete ruby and rails environment on Mac OS X.

You will also need to install bundler by running this in your terminal:
`gem install bundler`

INSTALLATION INSTRUCTIONS
=========================
After cloning the repository to your local development machine, `cd` to the root directory and invoke `$ bundle install`. This will grab all dependencies specified in `Gemfile` and install them. Once this is done, the application is ready to run.

USAGE 
=====
To run the application, invoke `$ ruby -I lib bin/robogame` at the root directory.

More about how to play the game, in the overview section below.

TESTING INSTRUCTIONS
====================
To execute the application’s test suite, invoke `$ ruby test/test_app.rb` at the root directory.

OVERVIEW
========
This application is designed to read in commands of the following form: 
- PLACE X,Y,F
- MOVE
- LEFT
- RIGHT
- REPORT

PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST. The origin (0,0) can be considered to be the SOUTH WEST most corner. The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed. MOVE will move the toy robot one unit forward in the direction it is currently facing. LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot. REPORT will announce the X,Y and F of the robot. A robot that is not on the table must ignore the MOVE, LEFT, RIGHT ￼and REPORT commands. The toy robot will not fall off the table during movement. This also includes the initial placement of the toy robot. Any move that would cause the robot to fall will be ignored.

Example Input($stdin) and Output($stdout):

a)
- PLACE 0,0,NORTH
- MOVE
- REPORT
- Output: 0,1,NORTH

b)
- PLACE 0,0,NORTH
- LEFT
- REPORT
- Output: 0,0,WEST

c)
- PLACE 1,2,EAST
- MOVE
- MOVE
- LEFT
- MOVE
- REPORT
- Output: 3,3,NORTH

Code Structure
==============
Code is divided into 3 segments/folders: 
- `bin/` => contains the simple launcher of the app
- `lib/robogame/` => contains business objects and logic
- `test/` => contains test cases and suite.

#### Launcher
`bin/robogam` file is the launcher of the app. It simply causes the application to run, by invoking our runner.

#### Runner
`lib/robogame/runner.rb` provides a command line interface between the end user and the core of the application logic. It's responsible for taking user input, sending a message to the game object to play based on that input, and finally display the output result or any error that might have occured during execution of the game.

#### Game Simulator
`lib/robogame/simulator.rb` This module contains the following important components:
- Game object that plays an orchestrating role. It gets the user input from runner, then creates/initialises the main objects/actors of the game, namely tabletop, robot, and command parser. And finally passes the user input to the parser to begin the process.
- this module also houses our different types of parsers (for different actions) so introducing a new command (e.g. to fly) is a matter of creating a new class here, and registering it as a new valid command in the settings file.
- Generic parser is in charge of delegating to sub types/classes that will do parsing of specific commands. (Parsing = validation + required action)
- Specific command parsers then delegate the job required to be done to robot/table objects that belong to the simulator module.

#### Table & Robot
`lib/robogame/table.rb` and `lib/robogame/robot.rb` contain definitions for state and behavior of table and robot objects.

#### Validations
all `lib/robogame/*_validations.rb` files contain validation code for their respective classes.

#### Settings
`lib/robogame/settings.rb` is where application settings and constants live.

#### Errors
`lib/robogame/errors.rb` is where we have defined application-specific exceptions.

Overall flow
============
Runner takes input from user and passes it to the instance of Game class. Game initializes all components necessary for game to continue (parser, robot and table) and passes the command (user input) to the parser, which is of a generic type. This generic parser class performs generic validations on the user input first, and then dynamically creates an instance of a more specific command parser (based on the function) and passes on the information to it for further processing. Specific parser object also runs the user input through further validation (specific to that function), and if everything goes well, delegates the task to robot/table objects to be performed. Robot and Table objects also do some validations before taking any action, and eventually return the result. The result/output will be passed all the way back to the runner for display purpose before prompting the user to input the next command. If anything goes wrong during any of the validation procedures, an exception will be raised which will also be shown to the user by runner. And this cycle goes on and on until user enters QUIT command, that causes the app to halt and exit.

Some Design Decisions
=====================
### Decoupling code through an AOP-like approach
Initially, validation logic was scattered in method definitions. This made me think about ways to weaken such dependencies between domain objects and their validations. I learned about AOP and the idea of evaluating code at/before/after/around a given join-point. Gems such as 'aquarium' provide this functionality. However, later on I realised that ruby >=2 comes with a feature called "prepend" which enables the achievement of pretty much the same thing, but without dependency on external gems (which sometimes can go unmaintained or abandoned for a long time). Of course, one caveat is that it won't work with ruby versions 1.9 or lower, but we should always strive to run the latest and greatest ruby anyway. Here, prepend fits our needs very well because validation is done pre-method-execution. But for things like persistence, logging, notifications, etc we might have to use gems that enable us to do AOP. Anyways, prepend was used to clean up validation code from classes, and put them into their own separate modules. Names of functions in a validation module correspond directly to method names in the class that prepends the module.

### Polymorphism through duck typing 
Another part of the code I was not happy about was an unpleasant switch statement which was used to make decision about what needs to be done based on user's input. Not only that, but also because different command types were not distinguished (through different classes) validation code contained so many ugly if/else statements. The solution that came to my mind was polymorphism but achieved through duck-typing. The strategy is to have a GenericParser that takes in the command and runs it through the Generic Validations that are shared among all types of commands, then dynamically create an object of a more specific type of command and send the parse message to it. This way, the specific parsing (and validation) for each specific command will happen in its own class. And the common/generic stuff stays in GenericParser. From extensibility point of view, with this approach, a new developer will be able to add a new command by just introducing a new class and encapsulating all parsing and validation code in it, without having to hunt for && update any switch statement anywhere. Also, if a subset of commands require a same unique validation, it can be done in a common superclass from which all such commands are inherited. 

Note, however, that I have slightly changed the standard implementation of duck-typing, i.e. instead of sending the finalised object type to the generic class, I'm letting it decide (dynamically) what type of object it should send the `.parse()` message to.

LICENSE
=======
The MIT License (MIT)

Copyright (c) 2014 Pouya Arvandian

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
