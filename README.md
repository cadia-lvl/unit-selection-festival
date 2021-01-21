# Unit selection recipe for Icelandic 

This is a default unit selection recipe for The Festival Speech Synthesis System.
The voice configuration inside `voice/` was built using `$FESTVOX/src/unitsel/setup_clunits` and then adapted to work for Icelandic data.


# Table of Contents

- [Installation](#installation)
- [Training](#training)
  * [Training with Docker](#training-with-docker)
- [Running](#running)
  * [Running with Docker](#running-with-docker)
- [License](#license)
- [Authors/Credit](#authors-credit)
  * [Acknowledgements](#acknowledgements)


# Installation

This recipe is built with The Festival Speech Synthesis System.
To train and run a voice model you will need to install:

* The Festival Speech Synthesis System
* The Edinburgh Speech Tools Library
* Festvox
* [Sequitur](https://github.com/sequitur-g2p/sequitur-g2p)


# Training

Training a voice requires a voice corpus, a [Sequitur](https://github.com/sequitur-g2p/sequitur-g2p) grapheme to phoneme model and an optional lexicon.
This documentaion assumes you are using the Talromur corpus and you have the data and a g2p model available in a directory called ext/.

`ext/` directory format:
```
data/audio/*.wav
data/index.tsv
ipd_clean_slt2018.mdl
```

You can edit the run script to adapt it to your own data.

If you are using the Talrómur corpus and have set up the `ext/` directory correctly training the voice is as simple as:


```Bash
cd voice
./run.sh ../ext/data ../ext/ipd_clean_slt2018.mdl
```  

If you want to use your own data replace the parameters to the run script with your data folder and your g2p model.


## Training with Docker

If you wishi, you can train your voice in a Docker container.
To do this simply build a container using the included configuration in `train.Dockerfile` and run it:

```Bash
docker build . --tag lvl-us-is-train -f train.Dockerfile
docker run -v ${PWD}/ext/data/:/usr/local/src/ext/data -v ${PWD}/ext/ipd_clean_slt2018.mdl:/usr/local/src/ext/ipd_clean_slt2018.mdl -v ${PWD}/voice/:/usr/local/src/voice lvl-us-is-train:latest
```


# Running

After training a model you can synthesize new audio.
The synthesis process does need the same grapheme to phoneme model as used for training in addition to the files and folders produced in the training process.


```Bash
# Synthesize by calling something like this:
# This only works within the voice directory
echo "Halló, ég kann að tala íslensku." | python3 normalize.py - - | ../festival/bin/text2wave -eval festvox/lvl_is_v0_clunits.scm -eval '(voice_lvl_is_v0_clunits)' > demo.wav
```  

## Running with Docker

If you are using Docker you can synthesize by building and running `runtime.Dockerfile`.

```Bash
docker build . --tag lvl-us-is-run -f runtime.Dockerfile
# The docker container uses the default input file: /opt/voice/input.txt
docker run lvl-us-is-run:latest > output.wav

# You can change input.txt to any file with a single normalized utterance
# If you want to change the input text, do something like this command
docker run -v ${PWD}/hvad_segir_thu.txt:/opt/voice/input.txt lvl-us-is-run:latest > hvad.wav
```


# License

This recipe is published under the [MIT](LICENSE) license.


# Authors/Credit
Reykjavik University

Þorsteinn Daði Gunnarsson <thorsteinng@ru.is>


## Acknowledgements

This project was funded by the Language Technology Programme for Icelandic 2019-2023. The programme, which is managed and coordinated by [Almannarómur](https://almannaromur.is/), is funded by the Icelandic Ministry of Education, Science and Culture.

