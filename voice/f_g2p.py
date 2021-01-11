# Author: Judy Fong <lvl@judyyfong.xyz.> Reykjavik University
# Description: Create tsv version of phonemes and allow input from the command
# line

from fairseq_g2p import FairseqGraphemeToPhoneme as fs_g2p

def pron_to_tsv(prons):
    """
    pron_to_tsv gives the IPA phonetic transcriptions of the given words in a
    tab separated value format.
    """
    return "\n".join(
        "{w}\t{pron}".format(w=item["word"],
                             pron=res["pronunciation"])
        for item in prons
        for res in item["results"])


GRAMMATEK_LSTM = fs_g2p()


def main(word_list_file, model):
    with open(word_list_file, 'r') as word_list:
        words = [l.rstrip('\n') for l in word_list]

    mainApplyWords(words, model)


def mainApplyWords(words, model='standard'):
    print(pron_to_tsv(GRAMMATEK_LSTM.pronounce(words, model)))


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='''
        Create grapheme to phoneme tsv''')
    parser.add_argument('--model', help='the dialect model')
    parser.add_argument('-a', '--apply',
        help='apply grapheme to phoneme converstion to the word list file')
    parser.add_argument('-w', '--word',
        help='apply grapheme to phoneme conversion to word')
    args = parser.parse_args()
    if args.word:
        mainApplyWords([args.word], args.model)
    else:
        main(args.apply, args.model)
