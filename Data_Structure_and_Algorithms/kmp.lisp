(defun kmp-match (str p &optional (start 0) (next nil))
  (if (or (= (length p) 0) (> start (- (length str) (length p))))
    nil
    (let ((next-array (or next (loop for i from 2 below (length p) ;TODO 这里的2存在问题
                                     with arr = (make-array (length p) :fill-pointer 2 :initial-element 0)
                                     do (vector-push (if (equal (char p (1- i)) (char p (aref arr (1- i)))) 
                                                       (1+ (aref arr (1- i))) 
                                                       0)
                                                arr)
                          finally (return arr)))))
      (loop for i from start below (length str)
            and c across p
            until (not (equal c (char str i)))
            finally (if (>= (- i start)  (length p))
                      (return start)
                      (return (kmp-match str p (+ start (1+ (aref next-array (- i start)))) next-array)))))))
