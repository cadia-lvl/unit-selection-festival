# Make some dirs we need
$FESTVOXDIR/src/general/make_dirs
DATADIR=$1
# Set up the prompts that we will train on.
# ---

# TODO: filter out prompts with unsupported letters
# then use that for creating txt.complete.data and vocabulary.txt

# Create transcriptions for everything
python3 normalize.py $DATADIR/index.tsv txt.complete.data --scm


# Filter out prompts with numbers or unsupported letters (c, w, q and z)
grep -v '"[^"]*[0-9cwqz]' txt.complete.data > txt.nonum.data

# For large databases this can take some time to run as there is a squared aspect 
# to this based on the number of instances of each unit type.
# So lets start with only 100 tokens, this number can be increased for better sound
head -n 1000 txt.nonum.data > etc/txt.done.data
# We've only successfully trained on ~2000 prompts. Training on ~2000 prompts
# needed to be done overnight.
# Using all the tokens uncomment the line below if you want to use all of the tokens
# cp -p txt.nonum.data etc/txt.done.data

# Create a lexicon
# ---

#Create list of all words in prompts
python3 normalize.py $1/index.tsv "-" | grep -o "[^ ]*" | sort | uniq > vocabulary.txt

# Add additional vocabulary
# This is highly recommended but needs additional resources you can find online
# mv vocabulary.txt audio-vocabulary.txt
# cut -f1 framburdarordabok.txt > additional-vocabulary.txt
# cat audio-vocabulary.txt additional-vocabulary.txt | sort | uniq > vocabulary.txt

echo $2
# Create phoneme transcriptions
if [[ $2 =~ \.mdl$ ]]; then
  g2p.py --model $2 --apply vocabulary.txt --encoding utf-8 > lexicon_seq.txt
else
  python3 f_g2p.py --model $2 --apply vocabulary.txt > lexicon.txt
fi

# TODO: NOTE this might not be needed anymore since x-sampa already are ascii
# readable phonemes
# Create a compiled lexicon from text lexicon
python3 build_lexicon.py sampa-map.tsv lexicon.txt festvox/lexicon.scm

# Power normalize and format wavs (16kHz, 16bit)
# bin/get_wavs $DATADIR/audio/*.wav
awk -v data_dir=$DATADIR '{print data_dir"/audio/"$2".wav"}' etc/txt.done.data | xargs bin/get_wavs

# Add random noise to audio (see script for more info)
bin/add_noise etc/txt.done.data

# This is needed to accommodate for the language-specific feature set
cp festival/clunits/mcep.desc festival/clunits/mcep.desc-backup
cp festival/clunits/mceptraj.desc festival/clunits/mceptraj.desc-backup
cp festival/dur/etc/dur.feats festival/dur/etc/dur.feats-backup
cp festival/dur/etc/statedur.feats festival/dur/etc/statedur.feats-backup


$FESTVOXDIR/src/prosody/setup_prosody
$FESTVOXDIR/src/clustergen/setup_cg lvl is v0

# This is needed to accommodate for the language-specific feature set
mv festival/clunits/mcep.desc-backup festival/clunits/mcep.desc
mv festival/clunits/mceptraj.desc-backup festival/clunits/mceptraj.desc
mv festival/dur/etc/dur.feats-backup festival/dur/etc/dur.feats
mv festival/dur/etc/statedur.feats-backup festival/dur/etc/statedur.feats

# Do the thing
./bin/do_build build_prompts
./bin/do_build label
./bin/do_build build_utts

# ./bin/do_clustergen parallel f0
# ./bin/do_clustergen parallel mcep
# ./bin/do_clustergen parallel voicing
# ./bin/do_clustergen parallel combine_coeffs_v

# ./bin/traintest etc/txt.done.data
# cp etc/txt.done.data etc/text.done.data.full
# cat etc/txt.done.data.train >etc/txt.done.data

# # ./bin/do_clustergen generate_statenames
# ./bin/do_clustergen generate_filters
# ./bin/do_clustergen cluster
# ./bin/do_clustergen dur
