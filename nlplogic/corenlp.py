from textblob import TextBlob
import wikipedia

def search_wikipedia(name):
    print(f"Searching for name: {name}")
    return wikipedia.search(name)

def summarize_wikipedia(name):
    text = wikipedia.summary(name)
    print (f"findng wiki summary for name: {name}")
    return text

def get_text_blob(text):
    print (f"converting summary to blob: {text}")
    blob = TextBlob(text)
    return blob

def get_phrases(name):
    text = summarize_wikipedia(name)
    if not text:
        print ("no text")
        return []
    blob = get_text_blob(text)
    phrases = blob.noun_phrases
    return phrases

query1 = "Starfleet Academy"