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
Limitations

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

-----------
If you have any suggestions or feedback on either this project or its documentation, please [open an issue](https://github.com/peterwdj/cleo-tech-test/issues/new).
