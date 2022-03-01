(define (cddr s) (cdr (cdr s)))

(define (cadr s) (car (cdr s)))

(define (caddr s) (car (cdr (cdr s))))

(define (sign num)
  (cond 
    ((= num 0) 0)
    ((< num 0) -1)
    (else      1)))

(define (square x) (* x x))

(define (pow x y)
  (cond 
    ((= y 0)   1)
    ((= y 1)   x)
    ((even? y) (pow (square x) (/ y 2)))
    ((odd? y)  (* x (pow x (- y 1))))))

(define (unique s)
  (define (remove a)
    (lambda (b) (not (equal? a b))))
  (if (null? s)
      nil
      (cons (car s)
            (unique (filter (remove (car s)) (cdr s))))))

(define (replicate x n)
  (define (helper a b)
    (if (= b 0)
        a
        (helper (cons x a) (- b 1))))
  (helper nil n))

(define (accumulate combiner start n term)
  (if (= n 0)
      start
      (combiner (term n)
                (accumulate combiner start (- n 1) term))))

(define (accumulate-tail combiner start n term)
  (define (helper sum p)
    (if (> p n)
        sum
        (helper (combiner sum (term p)) (+ p 1))))
  (helper start 1))

(define-macro
 (list-of map-expr for var in lst . filter-expr)
 `(map (lambda (,var) ,map-expr)
      ,(if (null? filter-expr)
          lst
          `(filter (lambda (,var) ,(car (cdr filter-expr)))
                  ,lst))))
