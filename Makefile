install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt
	python -m textblob.download_corpora # for the text blob stuff

test:
	python -m pytest -v test_hello.py --cov=wikiphrases --cov=nlplogic test_corenlp.py

format:
	black *.py
lint:
	pylint --disable=R,C hello.py

all: install lint test