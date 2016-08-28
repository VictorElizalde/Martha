# Martha
Gem that documents code/software for a better organisation and understanding of it by developers.

## Table of contents
- [Installation](#installation)
- [Usage](#usage)
- [What it actually do?](#what-it-actually-do)
- [Contributing](#contributing)
- [Credits](#author-and-contributor-list)
- [Issues](#issues)

## Installation
Pre-install:
- Windows Users: Install ruby environment, we recommend [RubyInstaller](http://rubyinstaller.org/downloads/) and after install [Development Kit](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit) and now you can use Ruby's gems.

- Install gems:
```console
% gem install pry
```
```console
% gem install nokogiri
```
Install:
To install the gem you can just run the following command:

```console
% gem install martha
```
## What it actually do?
Command:
```console
% martha reveal <NAME_FILE>
```
And your code is documented. Easy

Programming Languages Supported:
- Ruby
- C++

## Usage

You only need to use the martha command:

```console
% martha reveal <NAME_FILE>
```

## Issues
- The gem recognizes when a function was commented whit the special characters ("//Function") next to the headers. If you delete this, the function will write a new comment under of the old comment.

## Contributing
Everyone is freely to collaborate and submit pull request if needed.
You can add more support for new programming languages.

##Author and Contributor List
-------------------
- Victor Hugo Elizalde Muñoz
- Oscar Michel Herrera
- Mauricio Iván Cortés García
