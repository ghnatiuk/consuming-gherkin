!SLIDE 
# Consuming Gherkin
## One Byte at a Time

!SLIDE
# Who we are
## Greg Hnatiuk & Mike Sassak

!SLIDE smaller
# Step
    I18N_Step = ("Given " | "When " | "Then ") \ 
      >start_keyword %end_keyword;

    Step = space* I18N_Step %begin_content ^EOL+ \ 
      %store_step_content :> EOL+;

!SLIDE center bullets incremental
# Ragel
* A tool for building parsers...
* ...by specifying state machines...
* ...with regular expressions.

!SLIDE bullets incremental
# Some people, when confronted with a problem, think "I know, I'll use regular expressions." 

!SLIDE center
# "Now they have two problems."
![atreyu](atreyu.png)
