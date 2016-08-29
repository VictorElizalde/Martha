<p align="center"> <IMG SRC="http://orig13.deviantart.net/da3a/f/2016/241/7/3/147240327271421_by_sirgalahad31416-dafpy5d.png" ALT="Texto alternativo a la imagen"></p>
# Martha
Gem that documents code/software for a better organization and understanding of it by developers.

## Table of contents
- [Installation](#installation)
- [Usage](#usage)
- [What it actually does?](#what-it-actually-does)
- [Before and After Martha](#before-and-after-martha)
- [Warning](#warning)
- [Contributing](#contributing)
- [Credits](#author-and-contributor-list)

## Installation
Pre-install:
- Windows Users: Install ruby environment, we recommend [RubyInstaller](http://rubyinstaller.org/downloads/) and then install [Development Kit](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit) and with that you can use Ruby's gems.

- Install gems pry and nokigiri:
```console
% gem install pry
```
```console
% gem install nokogiri
```
Install:
- To install the gem you can just run the following command in the folder you will be working **(If you install it in your terminal root it won't work)**:

```console
% gem install martha
```
## What it actually does?

Martha checks your entire file and recognizes the number of functions in it. She will tell you the amount of method(s)/fuction(s) she found and ask you to fill three fields of information for each method(s)/function(s). Then, she will overwrite your file with the comments for each method(s)/function(s) respectively.

Programming Languages Supported:
- Ruby
- C++
- More languages will be supported soon.

## Usage

You only need to use the martha command reveal:

```console
% martha reveal <FILE_NAME>
```

She will detect all the undocumented method(s)/function(s) and will ask you to fill the information of Input Description, Output Description and Method Description for each method(s)/function(s). 

The rest is obtained automatically by Martha herself, she will tell you that she finished documenting your code and your file will be overwritten with the comments of each methos(s)/function(s) respectively. 

And your code is documented. Easy.

- Example
```console
% martha reveal main.cpp
Hello I'm Martha!

With whom I have the pleasure?

Your Name: Victor Elizalde
```

- Write your name in "Your Name:" , because she needs to know the author for the following documented method(s)/function(s) and will put it at the end of each comment. This is done because if someone documents a method/function badly, the author will be written in there.
```console
I found 3 undocumented method(s)/function(s)

For the following method/function:

         int Puntaje(string strPalabras, int sum)

Input Description (What does it receives?)

     Your Answer: String with the key word from the matrix and the sum of prime numbers.
     
Output Description (What does it returns?)

     Your Answer: The number of letters in a sentence.
     
Description (What does the method does?)

       Your Answer: It finds out the missing letter from the alphabet and returns it.
```
- Be very descriptive in your comments. Don't just write what type of variable you receive and return, write what information the variable has. 
- This inteface will repeat for the 3 method(s)/function(s).

```console
Finished documenting method(s)/function(s)
```
- When all method(s)/function(s) are documented, Martha will let you know she finished and now your code is documented. Easy.

##Before and After Martha

- Before
```C++
#include <iostream>
using namespacestd;

struct Coor{
  int x;
  int y;
};

int Sum(int a, int b)
{
  return a + b;
}

Coor Position(int a, int b)
{
  Coor s;
  s.x = a;
  s.y = b;
  return s;
}
```

- After
```C++
#include <iostream>
using namespacestd;

struct Coor{
  int x;
  int y;
};

/*
Title: Sum
Input: int a, int b
Input Description: 2 numbers that will be added
Output: int
Output Description: The sum of the 2 numbers received
Description: It sums 2 numbers 'a' and 'b'
Author: Victor Elizalde
*/
int Sum(int a, int b) //function
{
  return a + b;
}

/*
Title: Position
Input: int a, int b
Input Description: coordinate 'x' and 'y'
Output: Coor
Output Description: object with coordinates assigned
Description: it receives coordinates and assigns them to an object Coor
Author: Victor Elizalde
*/
Coor Position(int a, int b) //function
{
  Coor s;
  s.x = a;
  s.y = b;
  return s;
}

```


## Warning
- The gem recognizes when a function was commented with the special characters "//Function"(for cpp) and "#method"(for ruby) next to the headers. If you delete this, the function will write a new comment under of the old comment. So please keep that flag to avoid multiple 
comments for one method/function.

## Contributing
Everyone is free to collaborate and submit pull request if needed.
You can add support for new programming languages.

##Author and Contributor List
-------------------
- Victor Hugo Elizalde Muñoz
- Oscar Michel Herrera
- Mauricio Iván Cortés García
