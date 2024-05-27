#lang racket

(provide on-key)

(define (on-key event MAIN_GAME MAIN_FRAME MAIN_TIMER)
  (send MAIN_FRAME set-status-text
        (format "KEYBOARD EVENT: ~s \n"
                (send event get-key-code)))
  (let* ([c (send event get-key-code)])
    (cond
      [(eq? c 'escape)
       (send MAIN_FRAME show #f)]
      [(eq? c #\p
            (if (eq? (get-field gamestate MAIN_GAME) 'PLAYING)
                ((set-field! gamestate MAIN_GAME 'PAUSED)
                 (send MAIN_TIMER pause))
                void))])))