!SLIDE 
# Regular expressions are a syntax
!SLIDE 
# Regular expressions are a (horrible|great) syntax
!SLIDE bullets incremental
# Some Perfectly Normal Syntax
* ^$ \A\Z
* [A-Za-z] ::alpha::
* oh (hai|hi) (\w+)
* fo(?:\w)
* /facepalm

!SLIDE
# Creating a syntax error

!SLIDE bullets
# State Machines
* The characters in the regex literal are the _transitions_
* Given the regex /abc/, "a", "b" and "c" are named transitions
* The characters of input are the _events_
* The states disappear into the background
!SLIDE 
# Control!
!SLIDE center
# Example
    @@@ Ruby
    /a/
* pretty picture
!SLIDE
# Ragel converts a series of machines into a table-driven* FSM that reads bytes one at a time until it reaches the end of input
