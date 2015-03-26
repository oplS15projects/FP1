# Final Project Assignment 1: Exploration (FP1) 
DUE March 25, 2015 Wednesday (2015-03-25)

Full assignment specfication is [on Piazza.][piazza]

Write your report right in this file. Instructions are below. You can delete them if you like, or just leave them at the bottom.
You are allowed to change/delete anything in this file to make it into your report. It will be public, FYI.

This file is formatted with the [**markdown** language][markdown], so take a glance at how that works.

This file IS your report for the assignment, including code and your story.

Code is super easy in markdown, which you can easily do inline `(require net/url)` or do in whole blocks:
```
#lang racket

(require net/url)

(define myurl (string->url "http://www.cs.uml.edu/"))
(define myport (get-pure-port myurl))
(display-pure-port myport)
```

### My Library: (library name here)
Write what you did!
Remember that this report must include:
 
* a narrative of what you did
 
What I did: I decided I want to implement the Riot Games API somehow, so I started looking for a way to do that.  I don't really know anything about API's, other than they're used to pull information from a website or a game.  In this case, the Riot Games API pulls information from the League of Legends game.  I read about the API, and learned that it uses JSON; then I figured I needed a way to work with JSON in Racket, so I got a json library.  I also needed to pull the JSON from a webpage the API returned, so I guessed I needed that (require net/url) as well as (require json).  I managed to figure out how to pull out summoner names and levels, and wanted to try to work on getting more specific information, like player statistic for individual champions in the game, but I was having trouble using hash-ref, because the JSON was formatted so there were hashes inside of hashes inside of lists inside of hashes ad nauseam, so I thought I woudl be better off using dict-ref, so I imported that (require racket/dict).  I also needed a way to nicely format the strings and whatnot, so I used (require racket/format).  I wanted to also get stats about the ranked placement league the player was in, but that particular API was down, so I'll try that at another point.

* the code that you wrote
* 
#lang racket
(require (planet neil/json-parsing:2:0))
(require net/url)
(require json)
(require racket/dict)
(require racket/format)

;getting the JSON for a specific player's information from the Riot Games API
(define summoner-hash (string->url "https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/forcinit?api_key=8864143b-a987-45a8-b49d-53c0a7677100"))
(define sh (get-pure-port summoner-hash #:redirections 5))
(define summoner-hash-str (port->string sh))

;getting the JSON for a player's ranked placement
;*** API temporarily down***
(define summoner-league (string->url "https://na.api.pvp.net/api/lol/na/v2.5/league/by-summoner/35979437?api_key=8864143b-a987-45a8-b49d-53c0a7677100"))
(define sl (get-pure-port summoner-league #:redirections 5))
(define summoner-league-str (port->string sl))

;getting the JSON for a player's ranked stats
(define summoner-stats (string->url "https://na.api.pvp.net/api/lol/na/v1.3/stats/by-summoner/35979437/ranked?api_key=8864143b-a987-45a8-b49d-53c0a7677100"))
(define ss (get-pure-port summoner-stats #:redirections 5))
(define summoner-stats-str (port->string ss))



;convert the strings into JSON
(define summoner-league-json (string->jsexpr summoner-league-str))
(define summoner-hash-json (string->jsexpr summoner-hash-str))
(define summoner-stats-json (string->jsexpr summoner-stats-str))


;defines for getting info about a specific player
(define summoner (hash-ref summoner-hash-json 'forcinit))
(define summoner-name (hash-ref summoner 'name))
(define summoner-icon (hash-ref summoner 'profileIconId))
(define summoner-level (hash-ref summoner 'summonerLevel))

;defines for getting a player's ranked placement
;*** API temporarily down***
;(define league (hash-ref summoner-league-json )

;defines for getting a player's ranked stats
(define champions (hash-ref summoner-stats-json 'champions))
(define all-stats (hash-ref champions (car champions)))


;IGNORE: most of this was just used to test was was working and what wasn't
;(cond ((eq? (dict-ref (car champions) 'id) 0)
;       (dict-ref (car champions) stats)
;(hash->list (hash-ref summoner-stats-json)
;champions
;summoner
;stats
;summoner
;summoner-hash-json

;summoner-name
;summoner-icon
;summoner-level

(~a "Summoner name = " summoner-name  ";  Summoner level = " summoner-level ".")




* output from your code demonstrating what it produced

"Summoner name = F O R C I N it;  Summoner level = 30."


;;so far I only decided to test it with my in-game name, I'm not sure how I would go about rewriting the url with specific API id's yet, but I believe this is something I will incorporate into my final project

* any diagrams or figures explaining your work 
 
The narrative itself should be no longer than 350 words. Yes, you can add more files and link or refer to them. This is github, handling files is awesome and easy!

Ask questions publicly in the Piazza group.

### How to Do and Submit this assignment

1. To start, [**fork** this repository][forking].
1. You might want to [**Clone**][ref-clone] this repository to your computer
  2. (This assignment is just one README.md file, so you can edit it right in github without cloning if you like)
1. Modify the README.md file and [**commit**][ref-commit] changes to complete your solution.
1. [**Push**][ref-push]/sync the changes up to your GitHub (skip this if you didn't clone)
1. [Create a **pull request**][pull-request] on the original repository to turn in the assignment.

<!-- Links -->
[piazza]: https://piazza.com/class/i55is8xqqwhmr?cid=411
[markdown]: https://help.github.com/articles/markdown-basics/
[forking]: https://guides.github.com/activities/forking/
[ref-clone]: http://gitref.org/creating/#clone
[ref-commit]: http://gitref.org/basic/#commit
[ref-push]: http://gitref.org/remotes/#push
[pull-request]: https://help.github.com/articles/creating-a-pull-request
