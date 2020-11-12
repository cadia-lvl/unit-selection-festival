# Unit selection recipe for Icelandic 

This is a default unit selection recipe for The Festival Speech Synthesis System.
The voice inside `voice/` was built using `$FESTVOX/src/unitsel/setup_clunits` and then adapted to work for Icelandic. 

# Table of Contents

- [Installation](#installation)
- [Training](#training)
  * [Running with Docker](#running-with-docker)
- [License](#license)
- [Authors/Credit](#authors-credit)
  * [Acknowledgements](#acknowledgements)

# Installation

This recipe is built for The Festival Speech Synthesis System.
To train a voice model you will need:

* The Festival Speech Synthesis System
* The Edinburgh Speech Tools Library
* Festvox

# Training

Training a voice requires a voice corpus and a grapheme to phoneme model or a lexicon.
This recipe assumes you have both the audio data and a g2p model available in a directory called `ext/`
You can edit the run script to adapt it to your own data.

If you are using the Talrómur corpus training the voice is as simple as:

```Bash
cd voice
./run.sh ../ext/

# Synthesize by calling something like this:
# This only works within the voice directory
echo "Halló, ég kann að tala íslensku." | python3 normalize.py - - | ../festival/bin/text2wave -eval festvox/lvl_is_v0_clunits.scm -eval '(voice_lvl_is_v0_clunits)' > demo.wav
```  

## Running with Docker

If you wish you can train your voice in a Docker container.
To do this simply build the container using the included Dockerfile and run it:

```Bash
docker build . --tag lvl-us-is .
docker run -it --rm -v ${PWD}/ext/:/usr/local/src/ext -v ${PWD}/voice/:/usr/local/src/voice lvl-us-is:latest bash -c "cd voice/; ./run.sh ../ext/"
```

# License

This recipe is published under the [MIT](LICENSE) license.

# Authors/Credit
Reykjavik University

Þorsteinn Daði Gunnarsson <thorsteinng@ru.is>

## Acknowledgements

This project was funded by the Language Technology Programme for Icelandic 2019-2023. The programme, which is managed and coordinated by [Almannarómur](https://almannaromur.is/), is funded by the Icelandic Ministry of Education, Science and Culture.

