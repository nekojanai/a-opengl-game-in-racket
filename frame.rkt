#lang racket/gui

(provide game-frame%)

(define game-frame%
  (class frame%
    (super-instantiate ()
      (label "A Game")
      (min-width 640)
      (min-height 480)
      (style '(no-resize-border fullscreen-button)))
    (send this create-status-line)))