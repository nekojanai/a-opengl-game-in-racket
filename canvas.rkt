#lang racket
(require racket/gui
         sgl
         sgl/gl)

(provide viewport game-canvas%)

(define viewport #f)

(define game-canvas%
  (class canvas%

    (define initialized #f)

    (init-field [on-draw void]
                [on-mouse void]
                [on-keyboard void])

    (inherit with-gl-context swap-gl-buffers get-gl-client-size)
    ;; define override method to paint
    (define/override (on-paint)
      (with-gl-context (lambda ()
                         (when initialized (on-draw))
                         (swap-gl-buffers))))
    ; define override method to handle mouse events
    (define/override (on-event event)
      (on-mouse event))
    ; define override method to handle keyboard events
    (define/override (on-char event)
      (on-keyboard event))
    ; define override method to handle window resize
    (define/override (on-size width height)
      (with-gl-context
          (lambda ()
            (set! initialized #t)
            (define-values (gl-width gl-height) (get-gl-client-size))
            (game-configure gl-width gl-height)
            )))
    (super-instantiate () (style '(gl)))))

(define (game-configure width height)
  (gl-viewport 0 0 width height)
  (set! viewport (make-vector 4 0))
  (vector-set! viewport 2 width)
  (vector-set! viewport 3 height)
  (gl-matrix-mode GL_PROJECTION)
  (gl-load-identity)
  (if (< width height)
      (let ([h (/ height width)])
        (glFrustum -1.0 1.0 (- h) h 5.0 60.0))
      (let ((h (/ width height)))
        (gl-frustum (- h) h -1.0 1.0 5.0 60.0)))
  ;; modelview matrix
  (gl-matrix-mode GL_MODELVIEW)
  (gl-load-identity)
  (gl-translate 0.0 0.0 -40.0))