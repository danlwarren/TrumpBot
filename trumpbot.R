setwd("~/GitHub/TrumpBot")
library(ngram)
library(twitteR)

options(httr_oauth_cache=T)

apikey <- "fD92z0TeeisqolZDIOxN6bhc1"
apisecret <- "cx2weAt8Xg17IBSdfc6UPuxCBBw2Cf7MjSPjIyd0iPNH8GwxVD"
token <- "4805050178-bHyM5ZfP2u7NMXECZ5j7IVd79463kZpEPZlb2ru"
tokensecret <- "W3PY7YIsz9fJw5B5PJ6cF93fVp3uuJqP4mRmuEgV1nWyz"
setup_twitter_oauth(apikey, apisecret, token, tokensecret)

infile <- file("trump.txt")
diarrhea.in <- readLines(infile)

infile2 <- file("trumptweets.txt")
tweets.in <- readLines(infile2)

diarrhea.in <- c(diarrhea.in, tweets.in)

diarrhea.in <- paste(diarrhea.in, collapse = " ")

trump.ngram <- ngram(diarrhea.in, 2)

while(1){
   trump.babble <- babble(trump.ngram)
   
   # Break out sentences
   sentences <- c()
   sentence.starts <- as.vector(gregexpr("[?.!] +[A-Z]", trump.babble)[[1]])
   for(i in 1:(length(sentence.starts) - 1)){
      this.sentence <- substr(trump.babble, sentence.starts[i]+2, sentence.starts[i+1])
      if(nchar(this.sentence) <= 140){
         sentences <- c(sentences, this.sentence)
      }
   }
   if(length(sentences < 1)){
      out.sentence <- sample(sentences, 1)
      print(out.sentence)
      tweet(out.sentence)   
   }
   Sys.sleep(300)
}