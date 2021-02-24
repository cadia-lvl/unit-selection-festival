;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                     ;;;
;;;                     Carnegie Mellon University                      ;;;
;;;                  and Alan W Black and Kevin Lenzo                   ;;;
;;;                      Copyright (c) 1998-2000                        ;;;
;;;                        All Rights Reserved.                         ;;;
;;;                                                                     ;;;
;;; Permission is hereby granted, free of charge, to use and distribute ;;;
;;; this software and its documentation without restriction, including  ;;;
;;; without limitation the rights to use, copy, modify, merge, publish, ;;;
;;; distribute, sublicense, and/or sell copies of this work, and to     ;;;
;;; permit persons to whom this work is furnished to do so, subject to  ;;;
;;; the following conditions:                                           ;;;
;;;  1. The code must retain the above copyright notice, this list of   ;;;
;;;     conditions and the following disclaimer.                        ;;;
;;;  2. Any modifications must be clearly marked as such.               ;;;
;;;  3. Original authors' names are not deleted.                        ;;;
;;;  4. The authors' names are not used to endorse or promote products  ;;;
;;;     derived from this software without specific prior written       ;;;
;;;     permission.                                                     ;;;
;;;                                                                     ;;;
;;; CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK        ;;;
;;; DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING     ;;;
;;; ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT  ;;;
;;; SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE     ;;;
;;; FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES   ;;;
;;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN  ;;;
;;; AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,         ;;;
;;; ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF      ;;;
;;; THIS SOFTWARE.                                                      ;;;
;;;                                                                     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Phoneset for lvl_is
;;;

(defPhoneSet
  lvl_is
  (
   (vc consonant vowel diph silence 0)
   (cplace bilabial dental linguolabial palatal velar glottal 0)
   (ctype plosive fricative nasal lateral trill 0)
   (cvox voiced voiceless 0)
   (vfrontness front central back 0)
   (vcloseness close nearclose closemid mid openmid nearopen open 0)
   (vroundness unrounded rounded 0)
   (dfrontness2 front central back 0)
   (dcloseness2 close nearclose closemid mid openmid nearopen open 0)
   (droundness2 unrounded rounded 0)
   (vlength long short 0)
   )
  (
   (p   consonant bilabial  plosive       voiceless 0 0 0 0 0 0 0)
   (p_h  consonant bilabial  plosive       voiceless 0 0 0 0 0 0 0)
   (m   consonant bilabial  nasal         voiceless 0 0 0 0 0 0 0)
   (m_0  consonant bilabial  nasal         voiced 0 0 0 0 0 0 0)
   (f   consonant dental    fricative     voiceless 0 0 0 0 0 0 0)
   (v   consonant dental    fricative     voiceless 0 0 0 0 0 0 0)
   (t   consonant linguolabial plosive       voiceless 0 0 0 0 0 0 0)
   (t_h  consonant linguolabial plosive       voiceless 0 0 0 0 0 0 0)
   (D   consonant linguolabial fricative     voiceless 0 0 0 0 0 0 0)
   (T   consonant linguolabial fricative     voiceless 0 0 0 0 0 0 0)
   (n   consonant linguolabial nasal         voiceless 0 0 0 0 0 0 0)
   (n_0  consonant linguolabial nasal         voiced 0 0 0 0 0 0 0)
   (l   consonant linguolabial lateral       voiceless 0 0 0 0 0 0 0)
   (l_0  consonant linguolabial lateral       voiced 0 0 0 0 0 0 0)
   (r   consonant linguolabial trill         voiceless 0 0 0 0 0 0 0)
   (r_0  consonant linguolabial trill         voiced 0 0 0 0 0 0 0)
   (s   consonant linguolabial fricative     voiceless 0 0 0 0 0 0 0)
   (c   consonant palatal   plosive       voiceless 0 0 0 0 0 0 0)
   (c_h  consonant palatal   plosive       voiceless 0 0 0 0 0 0 0)
   (j   consonant palatal   fricative     voiceless 0 0 0 0 0 0 0)
   (C  consonant palatal   fricative     voiceless 0 0 0 0 0 0 0)
   (J  consonant palatal   nasal         voiceless 0 0 0 0 0 0 0)
   (J_0 consonant palatal   nasal         voiced 0 0 0 0 0 0 0)
   (k   consonant velar     plosive       voiceless 0 0 0 0 0 0 0)
   (k_h  consonant velar     plosive       voiceless 0 0 0 0 0 0 0)
   (x   consonant velar     fricative     voiceless 0 0 0 0 0 0 0)
   (G  consonant velar     fricative     voiceless 0 0 0 0 0 0 0)
   (N  consonant velar     nasal         voiceless 0 0 0 0 0 0 0)
   (N_0 consonant velar     nasal         voiced 0 0 0 0 0 0 0)
   (h   consonant glottal   fricative     voiceless 0 0 0 0 0 0 0)
   (i   vowel 0 0 0 front     close    unrounded 0         0    0       short)
   (i:  vowel 0 0 0 front     close    unrounded 0         0    0       long)
   (I   vowel 0 0 0 front     nearclose unrounded 0         0    0       short)
   (I:  vowel 0 0 0 front     nearclose unrounded 0         0    0       long)
   (Y   vowel 0 0 0 front     nearclose rounded 0         0    0       long)
   (Y:  vowel 0 0 0 front     nearclose rounded 0         0    0       long)
   (Yi  vowel 0 0 0 front     nearclose rounded 0         0    0       short)
   (9  vowel 0 0 0 front     openmid  rounded 0         0    0       short)
   (9: vowel 0 0 0 front     openmid  rounded 0         0    0       long)
   (E   vowel 0 0 0 central   openmid  unrounded 0         0    0       short)
   (E:  vowel 0 0 0 central   openmid  unrounded 0         0    0       long)
   (u   vowel 0 0 0 back      close    rounded 0         0    0       short)
   (u:  vowel 0 0 0 back      close    rounded 0         0    0       long)
   (O   vowel 0 0 0 back      openmid  rounded 0         0    0       short)
   (O:  vowel 0 0 0 back      openmid  rounded 0         0    0       long)
   (a   vowel 0 0 0 back      open     unrounded 0         0    0       short)
   (a:  vowel 0 0 0 back      open     unrounded 0         0    0       long)
   (Oi  diph  0 0 0 back      openmid  rounded front     close unrounded long)
   (ou  diph  0 0 0 back      openmid  rounded back      close rounded short)
   (ou: diph  0 0 0 back      openmid  rounded back      close rounded long)
   (ai  diph  0 0 0 back      open     unrounded front     close unrounded short)
   (ai: diph  0 0 0 back      open     unrounded front     close unrounded long)
   (au  diph  0 0 0 back      open     unrounded back      close rounded short)
   (au: diph  0 0 0 back      open     unrounded back      close rounded long)
   (9i  diph  0 0 0 back      open     unrounded front     nearclose rounded short)
   (9i: diph  0 0 0 back      open     unrounded front     nearclose rounded long)
   (ei  diph  0 0 0 central   openmid  unrounded front     close unrounded short)
   (ei: diph  0 0 0 central   openmid  unrounded front     close unrounded long)
   (pau silence 0 0 0 0 0 0 0 0 0 0)
  )
)

(PhoneSet.silences '(pau))

(define (lvl_is_v0::select_phoneset)
  "(lvl_is_v0::select_phoneset)
Set up phone set for lvl_is."
  (Parameter.set 'PhoneSet 'lvl_is)
  (PhoneSet.select 'lvl_is)
)

(define (lvl_is_v0::reset_phoneset)
  "(lvl_is_v0::reset_phoneset)
Reset phone set for lvl_is."
  t
)

(provide 'lvl_is_v0_phoneset)
