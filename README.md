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

DESIGN
======
TODO

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
