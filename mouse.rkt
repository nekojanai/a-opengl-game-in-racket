#lang racket

(provide on-mouse)

(define (on-mouse event frame)
  (send frame set-status-text
        (format "MOUSE EVENT: ~s \n"
                (send event get-event-type))))