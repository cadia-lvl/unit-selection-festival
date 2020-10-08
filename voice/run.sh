# Make some dirs we need
$FESTVOXDIR/src/general/make_dirs

# Power normalize and fromat wavs (16kHz, 16bit)
bin/get_wavs $1/audio/*.wav

# Set up the prompts that we will train on.
# ---

# Create transcriptions for everything
python3 normalize.py $1/index.tsv txt.complete.data --scm

# Add random noise to audio (see script for more info)
bin/add_noise txt.complete.data

# Filter out prompts with numbers or unsupported litters (c, w, q and z)
grep -v '"[^"]*[0-9cwqz]' txt.complete.data > txt.nonum.data

# For large databases this can take some time to run as there is a squared aspect 
# to this based on the number of instances of each unit type.
# So lets start with only 1000 tokens, this number can be increased for better sound
head -n 100 txt.nonum.data > etc/txt.done.data

# Create a lexicon
# ---

#Create list of all words in prompts
python3 normalize.py $1/index.tsv "-" | grep -o "[^ ]*" | sort | uniq > vocabulary.txt

# Add additional vocabulary
# This is highly recomended but needs additional resources you can find online
# mv vocabulary.txt audio-vocabulary.txt
# cut -f1 framburdarordabok.txt > additional-vocabulary.txt
# cat audio-vocabulary.txt additional-vocabulary.txt | sort | uniq > vocabulary.txt

# Create phoneme transcriptions
g2p.py --model ../ext/ipd_clean_slt2018.mdl --apply vocabulary.txt --encoding utf-8 > lexicon.txt

# Create a compiled lexicon from text lexicon
python3 build_lexicon.py aipa-map.tsv lexicon.txt festvox/lexicon.scm

# Do the thing
bin/do_build
