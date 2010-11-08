!SLIDE 
# Some Ragel

!SLIDE bullets incremental
# Basic Structure

* %%
* main

!SLIDE bullets incremental center
# Simple Machine Definitions

    @@@ Ruby
    'text'
    "text"
    [tex]
    'a'..'z'
    any, white, lower, alnum, digit

!SLIDE bullets incremental
# Regular Language Operators

* Union: expr | expr
* Intersection: expr & expr
* Difference: expr - expr
* Concatenation: expr . expr
* Kleene Star, One or more, Optional, Negation (*,+,?,!)

!SLIDE bullets incremental
# Actions!

* Entry: < 
* All Transitions: $
* Finishing: @
* Leaving: %

!SLIDE bullets center
# Don't use inline actions

    @@@ Ruby
    '\n'+ @{ puts "I have a newline" }

!SLIDE bullets
# Do name your actions
    @@@ Ruby
    action CountNewlines {
      @newlines += 1
    }

    EOL = '\n'+ @CountNewlines

!SLIDE bullets
# Guards and Nondeterminism

* finish-guarded:  :>>
* entry-guarded: :>
* left-guarded: <:
* longest-match kleene-star: **