!SLIDE 
# The Theory of Regular Languages

!SLIDE 
# Regular expressions are a syntax
!SLIDE 
# Regular expressions are a (horrible|great) syntax
!SLIDE
# /facepalm
!SLIDE bullets
# State Machines
* The characters in a regex are the _transitions_
* The characters of input are the _events_
* The states disappear into the background
!SLIDE 
# Control!
!SLIDE
# Example
* /a/
* pretty picture
!SLIDE
# Ragel converts a series of machines into a table-driven* FSM that reads bytes one at a time until it reaches the end of input
