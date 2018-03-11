# Cleo Tech Test

[Introduction](#introduction) | [Quickstart](#quickstart) | [Approach](#approach) | [Challenges](#challenges) | [Notes](#notes)

## Introduction

This is a tech test for [Cleo](https://www.meetcleo.com/), modeling a vending machine in Ruby. Ruby aside, the only technology used is the [RSpec](http://rspec.info/) testing framework. The brief for the project was to build a vending machine that could:
 - Return an item, once the correct amount of change in the correct denominations is inserted
 - Return change if insufficient money is provided
 Request more money if insufficient has been inserted
 - Take an initial load of products and change, with change in denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2.
 - Reload either products or change at a later point
 - Keep track of the products and change it contains


## Quickstart

*Running the application*    
Running the application is simple. First make sure you have Ruby installed. Then, clone this repository, and run:

```
ruby main.rb
```

This will launch you into the application. From there, the program will print instructions at each stage of interaction with the application.

*Running the tests*   
You will need to install dependencies (specifically, RSpec) before running the tests. Make sure you have [Bundler](http://bundler.io/) installed, and then run:

```
bundle install
```

Then, run RSpec to run the tests:

```
rspec                                ## runs the entire test suite
rspec spec/file.rb                   ## runs a specific test file
```


## Approach

When considering how I would approach this project, one of the first things that occurred to me was the complexity that would likely be involved. This came not so much in the logic of the application, which actually proved fairly simple to code, with a few exceptions (mentioned [below](#challenges)), but more in terms of the multiplicity of classes and the architecture of the application: which classes would be required, and how would they interact and talk to each other? In order to establish this, I carried out a series of planning exercises before beginning to write code, going from breaking the specification down into user stories to translating this into a program structure using [CRC cards](https://en.wikipedia.org/wiki/Class-responsibility-collaboration_card). This process helped to bring a lot of clarity to my own thinking around how this application would look.

In terms of developing the application itself, I took a bottom-up approach. That is to say, I started off by creating the classes for the smallest objects in the hierarchy(the `Coin` and `Product` classes), working up the chain into the `Change` and `Merchandise` classes (which would store and pass messages onto the objects they contain), up to the top-level `Machine` class. As I was building the `Machine` class, it quickly became apparent that there was much too much taking place in this class (partly due to my tendency to try to map computer objects too closely to their real-world counterparts). I therefore decided to extract all communication from the vending machine to the user to a `Printer` class, the sole responsibility of which would be to print statements to the user, as well as creating `Reload` and `Dispense` classes to handle carry out the logic of each function. This then left `Machine` as a class with the sole responsibility of receiving and processing input from the user.

All development took place in a test-driven manner which, alongside the test coverage tool, [SimpleCov](https://github.com/colszowka/simplecov), allowed me to ensure that the application was fully tested. Moreover, working in this way allowed me to focus my development, working on small features at a time to created a cohesive application.


## Challenges

As mentioned above, one of my biggest challenges when tackling this project was working out its structure. I found that I needed more classes than I had originally planned for, making this one of the biggest command-line projects I have worked on. Wrapping my head around what this would look like in code was my first major challenge - solved, as I have already spoken about, by my planning process. That I had not covered every eventuality in this planning process also presented another challenge for me, as I needed to extract classes from the `Machine` class, whilst simultaneously maintaining test code coverage. The solution to this was simply to work very systematically, extracting individual methods (and their corresponding tests) at a time and correcting errors as needed.

In terms of the logic of the application, the biggest challenge was to return the correct amount of change in the correct, and sensible, denominations. My implementation of this relies on the coins in the `Change` class being indexed in descending order, as the method to calculate change loops through these coins, checking if the value of each coin is less than or equal to the remaining change due. This solution ensures that the vending machine always returns change in the fewest coins possible (something that the self-checkout machines at Spitalfields Sainsbury's Local would do well to learn from - if anyone from Sainsbury's technology is reading this I will code this for free). The downside to this solution is that it produced a long method with an ungainly loop and lots of variables, making it difficult to refactor - I have done so to some extent, but the implementation still feels somewhat inelegant.


## Notes

*Coin units*   
Currently, the machine only accepts coins in units of pence (i.e. £100 is represented instead as 100p). In a deployed, production version of this project, this would need to be implemented, but in terms of producing a functioning application in this scenario, this addition felt unnecessary, given that the machine works as it should.

*Method privacy*   
One part of this code that I am not entirely comfortable with is the privacy of methods, especially within higher-level classes such as `Machine` that deal with user interaction, in which they have essentially one method that then calls other methods in response to user input. In this, some of the other routing methods are public, even though they should not be directly called by the user. This occurred as a result of working on small bits of code throughout the TDD process, and then moving things together later. However, moving these methods to private would lead to long, inelegant setups needed in test blocks in order to test for every eventuality. However, given the way the application works, using a looped menu method in the command line, it is not possible for the user to actually call any of these methods whilst using the application. On balance, I feel like leaving methods scoped as they are is preferable to longer, inelegant setup code in tests, even though the current implementation is not perfect.

*Isolating tests*   
In the spec files for the `Dispense` and `Reload` classes, the respective objects under tests are both initialised with real `Change` and `Merchandise` objects, rather than doubles. I am not entirely happy with this, as this means that these spec files are not completely isolated. However, RSpec doubles are not available in example groups, and so creating doubles and injecting them is not possible. I have solved this by mocking any methods called by either of these objects during the tests, and so the only real method either of these classes call is the `new` method - which is a part of Ruby, and so can be assumed to work correctly. I found this solution preferable to instantiating `Reload` or `Dispense` with doubles in every `it` block, which would have led to lots of repetition in the codebase.


-----------
If you have any suggestions or feedback on either this project or its documentation, please [open an issue](https://github.com/peterwdj/cleo-tech-test/issues/new).
