#lang racket/base
(require racket/gui "frame.rkt" "canvas.rkt" "game.rkt" "keyboard.rkt" "mouse.rkt")
;; ----------------------------------------------------------------------------------------------
;; GLOBALS
;; ----------------------------------------------------------------------------------------------
(define timer-interval 30)
;; is one of 'PLAYING 'MENU 'PAUSED

;; ----------------------------------------------------------------------------------------------
;; LOOP
;; ----------------------------------------------------------------------------------------------
;; continously being called by timer
(define control-game
  (queue-callback
   (lambda x (send MAIN_WINDOW on-paint))
   #f))

;; ----------------------------------------------------------------------------------------------
;; MAIN
;; ----------------------------------------------------------------------------------------------
(define MAIN_GAME (new game%))

(define MAIN_FRAME (new game-frame%))

(define MAIN_TIMER (new timer%
                        [notify-callback control-game]
                        [interval        timer-interval]
                        [just-once?      #f]))

(define MAIN_WINDOW (new game-canvas%
                         [on-draw     draw-triangle]
                         [on-keyboard (lambda (event) (on-key event MAIN_GAME MAIN_FRAME MAIN_TIMER))]
                         [on-mouse    (lambda (event) (on-mouse event MAIN_FRAME))]
                         [parent      MAIN_FRAME]))

(send MAIN_FRAME show #t)

