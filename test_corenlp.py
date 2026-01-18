from nlplogic.corenlp import get_phrases

def test_get_phrases():
    phrases = get_phrases("Starfleet Academy")
    assert "starfleet" in phrases