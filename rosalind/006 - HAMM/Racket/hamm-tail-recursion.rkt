;; the first three lines of this file were inserted by drracket. they record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname hamm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require spd/tags)

(@htdd nucleotide)
;; nucleotide is one of #\a #\t #\g #\c
;; interp. the four components of a dna sequence

#;
(define (fn-for-nt nt)
  (cond [(char=? nt #\a) (...)]
        [(char=? nt #\t) (...)]
        [(char=? nt #\g) (...)]
        [(char=? nt #\c) (...)]))

(@htdd listofnucleotide)
;; listofnucleotide is one of:
;; - empty
;; - (cons nucleotide listofnucleotide)

#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
          (... (fn-for-nucleotide (first lon))
               (fn-for-lon (rest lon)))]))

(@htdf hamming-distance)
(@signature (listof nucleotide) (listof nucleotide) -> natural)
;; produce the hamming distance of two sequences
;; assume: given sequences are equal in length

(check-expect
  (hamming-distance "gagcctactaacgggat"
                    "catcgtaatgacggcct")
  7)

(@template 2-one-of (listof Nucleotide) Nucleotide accumulator encapsulated)
(define (hamming-distance seq1 seq2)
  (local [(define SEQ1 (string->list seq1))
          (define SEQ2 (string->list seq2))
          
          (define (hamming-distance seq1 seq2 hd)
            (cond [(and (empty? seq1) (empty? seq2)) hd]
                  [else
                    (hamming-distance (rest seq1) (rest seq2)
                                      (check-nt (first seq1)
                                                (first seq2)
                                                hd))]))

          (define (check-nt nt1 nt2 hd)
            (if (char=? nt1 nt2)
              hd
              (+ 1 hd)))]

    (hamming-distance SEQ1 SEQ2 0)))