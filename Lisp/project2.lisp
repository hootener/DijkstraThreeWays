;;; Description:  Implements Dijkstra's algorithm using The Lisp langauge.  Contains 
;;; several test cases for consideration. As well as sample output (graph-output-start-1).
;;; This implementation removes previously visited nodes from the search space to provide
;;; a performance gain.
;;; Input files are formatted with the first number representing the size of the graph.
;;; The following triples represent econnections and the edge weight of the connection.

;;; dijkstra is the main entry point.
;;; user types (dijkstra) at the Lisp command prompt to run the program.



;;; use "defvar" to create global variables if needed
(defvar default-file-name "/Users/eli/Desktop/LispDijkstra/graph.txt")




;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Supplied functions
;;;
;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; loads a graph
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun get-graph ()
  (format t "~%Enter the name of the file containing the graph, or ")
  (format t "~%press enter for the default file (~A): " default-file-name)
  (let ((filename (read-line)))
     (if (string= (string-trim " " filename) "")
	 (convert-file-format (get-graph-from-file default-file-name))
         (convert-file-format (get-graph-from-file filename)))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; loads a graph from the given file
;; it expects the graph to be in the format of a single S-expression:
;; a list containing the number of nodes followed by triplets representing
;; the edges 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun get-graph-from-file (file)
  (let ((in (open file :if-does-not-exist nil)))
    (when in  (return-from get-graph-from-file (read in)))
    (when (not in) (format t "~%Unable to open file ~A" file))
    )
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; convert a file s-expression into a graph format
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun convert-file-format (lst)
  (cons (car lst)  ;; save the number of nodes
	(convert-to-triplets (cdr lst))))  ;; convert rest of list to triplets



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; convert a list of items into a list of lists (where each
;; sublist is a triplet from the original list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(defun convert-to-triplets (lst)  ;; old iterative version
 ; (do ((lst2 lst (cdddr lst2))
;       (result nil (append result (list (list (first lst2) (second lst2) (third lst2))))))
;      ((null lst2) result)))


;(defun convert-to-triplets (lst)  ;; recursive version (blows stack space for large graphs)
;  (if (null lst) nil
;    (cons (list (first lst) (second lst) (third lst))
;	  (convert-to-triplets (cdddr lst)))))

; the following builds the triplet list in the reverse order of the file, but is fast
(defun convert-to-triplets (lst) ;; iterative version
(do ((lst2 lst (cdddr lst2))
(result nil (cons (list (first lst2) (second lst2) (third lst2)) result)))
((null lst2) result)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gets the starting node from the user
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun get-start-node ()
  (format t "~%Enter the start node, or press enter to use zero: ")
  (let ((number (read-line)))
     (if (string= (string-trim " " number) "")
	 0  ;; default start node is zero
         (parse-integer number))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; print the solution list out in a nicely formatted manner.
;; nodes with a distance of -1 are reported as unreachable.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun print-distances (lst)
  (format t "~%~%Node~7TDist")
  (format t   "~%----~7T----")
  (do
      ((lst2 lst (cdr lst2)))
      ((null lst2) nil)
    (let* 
	((pair (car lst2))
	 (node (first pair))
	 (dist (second pair)))
      (if (equal dist -1)
	  (format t   "~%~A~7TUnreachable" node)
	  (format t   "~%~A~7T~A" node dist)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; main entry point to the shortest paths solver.
;; times the solution function.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun dijkstra ()
  (let ((graph (get-graph))
	(start-node (get-start-node)))
    (if graph 
	(progn
	  ;(format t "~%Here is the initial graph:")
	  ;(format t "~%~A " graph)
	  (print-distances (time (shortest-paths-solver graph start-node))))
        (format t "~%There is no graph to process.")))
  'DONE
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; driver routine
;;
;; It is your job to write this and necessary helper functions
;;
;; The parameter 'graph' is the input graph (a list whose first
;; element is the number of nodes, followed by triplet lists
;; indicating the edges). 
;; The parameter 'start' is the designated start node.
;;
;; This function should solve the short paths problem and return
;; a list of lists, where each sublist is a pair: the destination
;; node and the shortest distance to that node. If a node in the
;; graph is unreachable from the start node, you can either
;; represent its distance as -1, or simply not include it in the
;; result list. The list returned can have its elements in any
;; order; it does not have to be sorted by node number or by
;; distance.
;;
;; DO NOT change the name/signature of this function, as our
;; testing script depends upon it.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;helper function, makes a tuple from a start,end, and distance
(defun make-tuple (start end dist)
  (cond
   ((or (or (null start) (null end)) (null dist)) nil)
   (T (append (append (list start) (list end)) (list dist)))
  )
)

(defun shortest-paths-solver (graph start)
  (let* ((visited (list (make-tuple start start 0))) ;;visited - the list of visited tuples.
        (shortest visited) ;;the shortest path tuples. Includes the start tuple
        (nodeCount (car graph)))
    (setq graph (cdr graph))
    (loop while (and (not (equal (length visited) 0)) (not (equal (length shortest) nodeCount))) do ;;loop condition. Loops until visited is empty
      ;(break)
      (setq visited (append visited (set-distances (get-children graph start) (car (last (flatten shortest)))))) ;;update visited with children at start node, set-distances of the children to be the distance from the start node.
      (setq visited (remove-visited-nodes start visited)) ;;remove tuples that have the visited node
      (setq shortest (append shortest (list (get-minimum-tuple visited)))) ;;get the smallest value from visited push it onto shortest paths. Might consider a collect statement here. The cdr of visited is used so the start node isn't considered as a shortest path
      (setq graph (remove-visited-nodes start graph)) ;;remove tuples that have the visited node
      (setq start (cadar (last shortest))) ;;update start so the newly discovered node is used in the next iteration of the loop.
      ;(setq visited (remove-visited-nodes start visited))
      
      ;;for debugging
      ;(format t "~%Visited:")
      ;(format t "~%~A " visited)
      ;(format t "~%Shortest:")
      ;(format t "~%~A " shortest)
      ;(format t "~%Next Start:")
      ;(format t "~%~A " start)
      ;(format t "~%Graph:")
      ;(format t "~%~A " graph)

    )
    (make-shortest-paths shortest) ;;take the list of shortest tuples and turn them into pairs. 
    )
)


;;returns the child nodes of node and their distances in a list of tuples.
(defun get-children (graph node)
  (cond
   ((atom graph) nil) ;;something went wrong
   ((null node) nil) ;;something else went wrong
   ((atom (car graph)) (get-children (cdr graph) node)) ;;skip atoms - this will skip the first length atom in graph...and any other weird atoms
   ((equal node (caar graph)) (append (list (car graph)) (get-children (cdr graph) node))) ; car of graph is a child of node, keep it
   (T (get-children (cdr graph) node)) ;;node isn't equal, skip it.
  )
)

;;adjusts the distances of the list of tuples in tupleLst by dist
(defun set-distances (tupleLst dist)
  (cond
   ((or (null tupleLst) (null dist)) nil)
   ((or (atom tupleLst) (listp dist)) nil)
   (T (append (list (set-tuple-distance (car tupleLst) dist)) (set-distances (cdr tupleLst) dist)))
  )
)

;;helper-function: modifies the distance element of a single tuple and returns it.
(defun set-tuple-distance (lst dist)
  (cond
   ((or (null lst) (null dist)) nil)
   ((null (cdr lst)) (list (+ (car lst) dist)))
   (T (cons (car lst) (set-tuple-distance (cdr lst) dist)))
  )
)
   
;;get-minimum-tuple returns the minimum distance tubple in a list of tuples.
(defun get-minimum-tuple (lst)
  (cond
   ((null lst) nil)
   ((atom lst) nil) ;;shouldn't be an atom
   ((= (length lst) 1) (car lst))
   ((and (not (equal 0 (caddar lst))) (< (caddar lst) (car(cddadr lst)))) (get-minimum-tuple (append (list (car lst)) (cddr lst)))) ;if the length of the first tuple is less than the second, skip the second and so on.
   (T (get-minimum-tuple (cdr lst)))
  )
)

;;remove-tuple - returns a list of tuples with the passed tuple removed
(defun remove-tuple (tuple lst)
  (cond
   ((or (null tuple) (null lst)) nil)
   ((or (atom tuple) (atom lst)) nil)
   ((equal tuple (car lst)) (cdr lst))
   (T (append (list (car lst)) (remove-tuple tuple (cdr lst))))
  )
)

;;remove-visited-nodes removes tuples from a list based if the destination entry in the tuple matches
;;the passed in visited atom. Returns lst with the visited tuples removed
(defun remove-visited-nodes (item lst)
  (cond
   ((or (null item) (null lst)) nil)
   ((equal item (cadar lst)) (remove-visited-nodes item (cdr lst)))
   (T (append (list (car lst)) (remove-visited-nodes item (cdr lst))))
  )
)

;;make-shortest-paths takes a list of tuples and removes the start node from each. Returns this list.
(defun make-shortest-paths (lst)
  (cond
   ((null lst) nil)
   (T (append (list (make-shortest-pair (car lst))) (make-shortest-paths (cdr lst))))
  )
)

;;need function that removes tuples from the list if they have a destination node that matches a node
;;already in the shortest path list.


;;helper function - flatten makes all entries in a list (including nesting atoms in sub lists) top level items.
;;If a nil entry is in the list, it is removed.
(defun flatten (lst)
  (cond
   ((null lst) nil)
   ((atom lst) lst)
   ((null (car lst)) (flatten (cdr lst)))
   ((atom (car lst)) (cons (car lst) (flatten (cdr lst))))
   (T (append (flatten (car lst)) (flatten (cdr lst)))
   )
  )
)

;;helper - make-shortest-pair takes a tuple, removes the start node, and returns the destination node and distance.
(defun make-shortest-pair (tuple)
  (cond
   ((null tuple) nil)
   ((atom tuple) nil)
   (T (cdr tuple))
  )
)

