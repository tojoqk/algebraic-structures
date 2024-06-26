(functor ((algebraic-structures foldable) (F (fold)))
    (fold
     length
     count
     any
     every
     member?)
  (import (except scheme length)
          (only F fold)
          (only (chicken base) add1 call/cc assert))

  (define (length xs)
    (fold (lambda (_ acc) (add1 acc))
          0
          xs))

  (define (count p? xs)
    (fold (lambda (e acc)
            (if (p? e)
                (add1 acc)
                acc))
          0
          xs))

  (define (any pred xs)
    (call/cc
     (lambda (return)
       (fold (lambda (e acc)
               (cond ((pred e) => return)
                     (else acc)))
             #f
             xs))))

  (define (every pred xs)
    (call/cc
     (lambda (return)
       (fold (lambda (e acc)
               (or (pred e) (return #f)))
             #t
             xs))))

  (define (member? x xs #!optional (= equal?))
    (call/cc
     (lambda (return)
       (fold (lambda (e _)
               (if (= e x)
                   (return #t)
                   #f))
             #f
             xs)))))
