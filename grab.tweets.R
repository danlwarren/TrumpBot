setwd("~/GitHub/TrumpBot")
library(ngram)
library(twitteR)

options(httr_oauth_cache=T)

apikey <- "fD92z0TeeisqolZDIOxN6bhc1"
apisecret <- "cx2weAt8Xg17IBSdfc6UPuxCBBw2Cf7MjSPjIyd0iPNH8GwxVD"
token <- "4805050178-bHyM5ZfP2u7NMXECZ5j7IVd79463kZpEPZlb2ru"
tokensecret <- "W3PY7YIsz9fJw5B5PJ6cF93fVp3uuJqP4mRmuEgV1nWyz"
setup_twitter_oauth(apikey, apisecret, token, tokensecret)

trump.tweets <- twListToDF(userTimeline('realDonaldTrump', n=3200))$text

trump.tweets

# Function to strip off trailing ... and url from fb posts
strip.fb <- function(x){
   this.tweet <- gsub('\\.\\.\\..*', "", x)
   this.tweet <- gsub('http.*', "", this.tweet)
} 

new.tweets <- c()
for(i in trump.tweets){
   new.tweets <- c(new.tweets, strip.fb(i))
}

write(new.tweets, file="trumptweets.txt")


# NOTE: You need to re-encode these in Sublime to UTF-8