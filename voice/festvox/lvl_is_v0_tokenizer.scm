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
;;; Tokenizer for is
;;;
;;;  To share this among voices you need to promote this file to
;;;  to say festival/lib/lvl_is/ so others can use it.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Load any other required files

;; Punctuation for the particular language
(set! lvl_is_v0::token.punctuation "\"'`.,:;!?(){}[]")
(set! lvl_is_v0::token.prepunctuation "\"'`({[")
(set! lvl_is_v0::token.whitespace " \t\n\r")
(set! lvl_is_v0::token.singlecharsymbols "")

;;; Voice/is token_to_word rules 
(define (lvl_is_v0::token_to_words token name)
  "(lvl_is_v0::token_to_words token name)
Specific token to word rules for the voice lvl_is_v0.  Returns a list
of words that expand given token with name."
  (cond
   ((string-matches name "[1-9][0-9]+")
    (lvl_is::number token name))
   (t ;; when no specific rules apply do the general ones
    (list name))))

(define (lvl_is::number token name)
  "(lvl_is::number token name)
Return list of words that pronounce this number in is."

  (error "lvl_is::number to be written\n")

)

(define (lvl_is_v0::select_tokenizer)
  "(lvl_is_v0::select_tokenizer)
Set up tokenizer for is."
  (Parameter.set 'Language 'lvl_is)
  (set! token.punctuation lvl_is_v0::token.punctuation)
  (set! token.prepunctuation lvl_is_v0::token.prepunctuation)
  (set! token.whitespace lvl_is_v0::token.whitespace)
  (set! token.singlecharsymbols lvl_is_v0::token.singlecharsymbols)

  (set! token_to_words lvl_is_v0::token_to_words)
)

(define (lvl_is_v0::reset_tokenizer)
  "(lvl_is_v0::reset_tokenizer)
Reset any globals modified for this voice.  Called by 
(lvl_is_v0::voice_reset)."
  ;; None

  t
)

(provide 'lvl_is_v0_tokenizer)
