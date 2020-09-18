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
;;; Lexicon, LTS and Postlexical rules for lvl_is
;;;

(lex.create "lvl_is")
(lex.set.phoneset "lvl_is")
(lex.set.compile.file "festvox/lexicon.scm")
(lex.set.lts.method "g2p")
(lex.select "lvl_is")

(define (debug obj)
  (format stderr "Debug: %l\n" obj)
)

(set! str_phone_map
  (load "festvox/lvl_is_v0_aipa.scm" t)
)

(define (str_to_phoneme ord)
  (set! ret (cadr (assoc ord str_phone_map)))
  (if (not ret)
    (format t "Warning: Phoneme for unicode ordinal %d not found\n" ord))
  ret)

(define (g2ppy word)
  "Call g2p model to get phoneme transcription.
This is very inefficient since the method is called for every word seperetly."
  (system
    (format
      nil
      "g2p.py --model ../ext/ipd_clean_slt2018.mdl --encoding utf-8 -w %s | awk '{print \"\\\"\"$0\"\\\"\"}' > ttmp.scm\n"
      word
    )
  )
  (set! pp (load "ttmp.scm" t))
  (string-after (car pp) "\t")
)

(define (string-split str delim)
  (set! out (list))
  (while (not (string-equal (string-after str delim) ""))
    (set! out (append out (list (string-before str delim))))
    (set! str (string-after str delim))
  )
  (append out (list str))
)

(define (strs_to_phoneme phoneme_strs)
  "Given a string of phonemes seperated by a space
return a list of the phoneme symbols"
  (set! phones (string-split phoneme_strs " "))
  (set! phones_out (list))
  (while (nth 0 phones)
    (set! next (car phones))
    (set! phones (cdr phones))
    (set! phones_out (append phones_out (list (str_to_phoneme next))))
  )
  phones_out
)

(define (g2p word features)
  "g2p
Call g2p.py for unknown words."
    (set! str_phone_list (g2ppy word))
    (set! 
      phones 
      (strs_to_phoneme str_phone_list)
    )
    (list word features (list (list phones 1)))
)

(define (lvl_is_v0::select_lexicon)
  "(lvl_is_v0::select_lexicon)
Set up the lexicon for lvl_is."
  (lex.select "lvl_is")
)
(define (lvl_is_v0::reset_lexicon)
  "(lvl_is_v0::reset_lexicon)
Reset lexicon information."
  t
)
(provide 'lvl_is_v0_lexicon)
