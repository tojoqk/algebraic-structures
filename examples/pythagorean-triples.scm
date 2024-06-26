(import (srfi 41)
        (prefix (algebraic-structures stream monad) stream:)
        (prefix (algebraic-structures stream alternative) stream:))

(define (pythagorean-triples)
  (stream:do (b <- (stream-from 1))
             (a <- (stream-range 1 b))
             (let c^2 = (+ (* a a) (* b b)))
             (let-values (c r) = (exact-integer-sqrt c^2))
             (stream:guard (zero? r))
             (stream (list a b c))))
