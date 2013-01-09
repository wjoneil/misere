Misère
======

Misère is an application that scores and tracks games of [500][1].

You can see Misère in action [here](http://misere.co.nz).

* Never forget how many points a bid of seven hearts is worth!
* No longer rely on anecdotal evidence about how much better you are at 500 than your siblings and cousins!
* Don't worry about forgetting the score because it's 1am and you're exhausted after been playing non-stop for five hours!

[1]: http://en.wikipedia.org/wiki/500_(card_game)

About
-----

500 is the inevitable card game dragged out for serious, no-holds-barred tournament play at practically every family gathering I attend. I was sick of keeping track of scores manually, and felt like there was a wealth of data about bids and scores waiting to be collated.

Current Limitations
-------------------

Players belong to a single User, so two friends can't both run Misère accounts where either account updates the "shared" player stats. It's possible if I reimplement the model using a join table, but I can't think of an elegant way for one user to share his players with another.


