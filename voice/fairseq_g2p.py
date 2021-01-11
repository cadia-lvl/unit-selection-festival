"""
This module converts words to a format usable by the FairseqGraphemeToPhoneme
class and contains t he FairseqGraphemeToPhoneme class.
The FairseqGraphemeToPhoneme class uses fairseq models to get the phonetic
transcriptions of words.
These models are based off the sigmorph Icelandic g2p models.
"""
# Copyright (c) Judy Y. Fong <lvl@judyyfong.xyz>
#
# This g2p source code is licensed under the GPL-2.0 License found in the
# LICENSE file in the root directory of this source tree.

import os
import fairseq
import torch
from fairseq.models.transformer import TransformerModel


# Function to change 'hlaupa' to 'h l a u p a' etc
def words2spaced(normal_words):
    """
    Change normal words to words with spaces between letters

         e.g. hlaupa to h l a u p a
    """
    separated = []
    for word in normal_words:
        separated.append(' '.join(char for char in word))
    return separated


class FairseqGraphemeToPhoneme:
    """
    The Fairseq_graphemetophoneme class uses fairseq models to get the phonetic
    transcriptions of words.
    These models are based off othe sigmorph Icelandic g2p models.
    """
    def __init__(self):
        self.possible_dialects = ['standard', 'north', 'north_east', 'south']
        self.dialect_models = {}

        model_dir = os.getenv("G2P_MODEL_DIR", "/app/fairseq_g2p/")
        """ Select the paths based on dialect """
        for dialect in self.possible_dialects:
            data_dir = model_dir + '/data-bin/' + dialect
            checkpoint_file = model_dir + '/checkpoints/' + dialect + \
                '-256-.3-s-s/checkpoint_last.pt'
            self.dialect_models[dialect] = \
                TransformerModel.from_pretrained(data_dir, checkpoint_file)

    def examples(self):
        """
        Print out examples of the output from fairseq g2p models from grammatek
        """
        # Process phrase to work with g2p functioon
        # TODO: remove punctuation because it affects the output
        # phrase = 'Velkomin til íslands.'
        # phrase = 'Velkomin til íslands'
        phrase = 'What is up Charlie Zinger Queen'
        # Change a phrase to a list of words with .split()
        phrase_spaced = words2spaced(phrase.split())

        # Process words to work with g2p function
        h_l_a_u_p_a = words2spaced(['hlaupa'])
        processed = words2spaced(
            ['Hlaupa', 'derp', 'orð', 'hrafn', 'daginn', 'Akureyri', 'banki']
        )

        # works with c, w, q, and z
        # g2p works with lowercased and capital letters
        # NOTE: punctuation just gives random output so shouldn't allow it to
        # be passed to self.dialect_models[dialect].translate()
        dialect = "standard"
        print(self.dialect_models[dialect].translate(h_l_a_u_p_a))
        # ['l_0 9i: p a']
        print(self.dialect_models[dialect].translate(processed))
        # ['l_0 9i: p a', 't E r_0 p']
        print(self.dialect_models[dialect].translate(phrase_spaced))
        # ['c E l k_h O m I n', 't_h I: l', 'i s t l a n t s']

        print('\nnorth')
        print(self.dialect_models["north"].translate(processed))
        print('\nnorth east')
        print(self.dialect_models["north_east"].translate(processed))
        print('\nsouth')
        print(self.dialect_models["south"].translate(processed))

    # ['hlaupa','orð', 'derp']
    def pronounce(self, word_list, dialect='standard'):
        """
        Take in a normal word list and return pronunciation objects
        Apply phonemes based on dialect
        """
        w_o_r_d_l_i_s_t = words2spaced(word_list)
        if dialect in self.possible_dialects:
            word_phones = \
                self.dialect_models[dialect].translate(w_o_r_d_l_i_s_t)
            fairseq_response = []
            for (phones, word) in zip(word_phones, word_list):
                fairseq_response.append({
                    "word": word,
                    "results": [
                        {"pronunciation": phones}
                    ]
                })
            return fairseq_response
        raise ValueError("There is no matching dialect g2p model.")
