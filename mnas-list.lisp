;;;; mnas-list.lisp

(in-package #:mnas-list)

;;; "mnas-list" goes here. Hacks and glory await!

(defun unique (list &key key test test-not)
  "Возвращает список, содержащий уникальные элементы;
Примеры использования:
;;;;(unique (list 1 2 3 4 5 2 3 4 5 6 3 4 5 6 7 8 ))
;;;;=>(8 7 6 5 4 3 2 1)
;;;;(unique (list \"1\" \"2\" \"3\" \"4\" \"5\" \"2\" \"3\" \"4\" \"5\" \"6\" \"3\" \"4\" \"5\" \"6\" \"7\" \"8\"))
;;;;=>(\"8\" \"7\" \"6\" \"5\" \"4\" \"3\" \"6\" \"5\" \"4\" \"3\" \"2\" \"5\" \"4\" \"3\" \"2\" \"1\")
;;;;(unique (list \"1\" \"2\" \"3\" \"4\" \"5\" \"2\" \"3\" \"4\" \"5\" \"6\" \"3\" \"4\" \"5\" \"6\" \"7\" \"8\") :test #'string=)
;;;;=>(\"8\" \"7\" \"6\" \"5\" \"4\" \"3\" \"2\" \"1\")
;;;;(unique (list \"1\" \"2\" \"3\" \"4\" \"5\" \"2\" \"3\" \"4\" \"5\" \"6\" \"3\" \"4\" \"5\" \"6\" \"7\" \"8\") :test-not #'string/=)
;;;;=>(\"8\" \"7\" \"6\" \"5\" \"4\" \"3\" \"2\" \"1\")
"
  (let ((rez nil))
    (mapcar #'(lambda (el) 
		(cond 
		  ((and (boundp 'key)       (boundp 'test))           (setf rez (adjoin el rez :key key :test test    )))
		  ((and (not (boundp 'key)) (boundp 'test))           (setf rez (adjoin el rez          :test test    )))
		  ((and (boundp 'key)       (not (boundp 'test)))     (setf rez (adjoin el rez :key key               )))
		  ((and (boundp 'key)       (boundp 'test-not))       (setf rez (adjoin el rez :key key :test test-not)))
		  ((and (not (boundp 'key)) (boundp 'test-not))       (setf rez (adjoin el rez          :test test-not)))
		  ((and (boundp 'key)       (not (boundp 'test-not))) (setf rez (adjoin el rez :key key               )))
		  ((and (not (boundp 'key))  
			(not (boundp 'test)) 
			(not (boundp 'test-not)))                     (setf rez (adjoin el rez   ))))
		)
	    list)
    rez))

	 
(defun list-string-sequence (lst)
  "Введено для использования с пакетом LTK.
Пример использования:
;;;; (list-string-sequence '(1 2 3 4 5 6 \"sdf\" 23.5))
;;;; => \"1 2 3 4 5 6 \"sdf\" 23.5\"
;;;; (configure combo :values (list-string-sequence '(1 2 3 4 5 \"Foo\" 2.45)))
"
  (string-right-trim ")" (string-left-trim "(" (format nil "~S" lst))))


