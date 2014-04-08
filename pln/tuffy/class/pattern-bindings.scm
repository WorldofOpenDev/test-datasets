;;;; Pattern matcher binding utilities for class and rc1000 problems

;; find-* and count-* queries are defined for the following entity types:
;;
;;     categories
;;     people
;;     papers
;;     categorized-papers
;;     uncategorized-papers
;;     referral-sources
;;     referral-targets

; ---------------------------------------------------------------------------
; find-categories
; count-categories
;
; Categories are entities that participate in the category(paper, category)
; relation as the second argument

(define find-categories-duped
  (BindLink
    (ListLink
        (VariableNode "$paper")
        (VariableNode "$category"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "category")
        (ListLink
          (VariableNode "$paper")
          (VariableNode "$category")))
      (VariableNode "$category"))))

(define (find-categories)
    (delete-duplicates (cog-outgoing-set (cog-bind find-categories-duped))))

(define (count-categories)
    (length (find-categories)))

; ---------------------------------------------------------------------------
; find-people
; count-people
;
; People are entities that participate in the wrote(person, paper) relation
; as the first argument

(define find-people-duped
  (BindLink
    (ListLink
        (VariableNode "$person")
        (VariableNode "$paper"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "wrote")
        (ListLink
          (VariableNode "$person")
          (VariableNode "$paper")))
      (VariableNode "$person"))))

(define (find-people)
    (delete-duplicates (cog-outgoing-set (cog-bind find-people-duped))))

(define (count-people)
    (length (find-people)))

; ---------------------------------------------------------------------------
; find-papers
; count-papers
;
; Papers are entities that participate in the wrote(person, paper) relation
; as the second argument

(define find-papers-duped
  (BindLink
    (ListLink
        (VariableNode "$person")
        (VariableNode "$paper"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "wrote")
        (ListLink
          (VariableNode "$person")
          (VariableNode "$paper")))
      (VariableNode "$paper"))))

(define (find-papers)
    (delete-duplicates (cog-outgoing-set (cog-bind find-papers-duped))))

(define (count-papers)
    (length (find-papers)))

; ---------------------------------------------------------------------------
; find-categorized-papers
; count-categorized-papers
;
; Categorized papers are entities that participate in the
; category(paper, category) relation as the first argument
(define find-categorized-papers-duped
  (BindLink
    (ListLink
        (VariableNode "$paper")
        (VariableNode "$category"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "category")
        (ListLink
          (VariableNode "$paper")
          (VariableNode "$category")))
      (VariableNode "$paper"))))

(define (find-categorized-papers)
    (delete-duplicates
        (cog-outgoing-set (cog-bind find-categorized-papers-duped))))

(define (count-categorized-papers)
    (length (find-categorized-papers)))

; ---------------------------------------------------------------------------
; find-uncategorized-papers
; count-uncategorized-papers
;
; Uncategorized papers are the set difference of all papers and categorized
; papers

(define (find-uncategorized-papers)
    (lset-difference equal? (find-papers) (find-categorized-papers)))

(define (count-uncategorized-papers)
    (length (find-uncategorized-papers)))

; ---------------------------------------------------------------------------
; find-referral-sources
; count-referral-sources
;
; Referral sources are entities that participate in the refers(paper, paper)
; relation as the first argument

(define find-referral-sources-duped
  (BindLink
    (ListLink
        (VariableNode "$paper1")
        (VariableNode "$paper2"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "refers")
        (ListLink
          (VariableNode "$paper1")
          (VariableNode "$paper2")))
      (VariableNode "$paper1"))))

(define (find-referral-sources)
    (delete-duplicates
        (cog-outgoing-set (cog-bind find-referral-sources-duped))))

(define (count-referral-sources)
    (length (find-referral-sources)))

; ---------------------------------------------------------------------------
; find-referral-targets
; count-referral-targets
;
; Referral targets are entities that participate in the refers(paper, paper)
; relation as the second argument

(define find-referral-targets-duped
  (BindLink
    (ListLink
        (VariableNode "$paper1")
        (VariableNode "$paper2"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "refers")
        (ListLink
          (VariableNode "$paper1")
          (VariableNode "$paper2")))
      (VariableNode "$paper2"))))

(define (find-referral-targets)
    (delete-duplicates
        (cog-outgoing-set (cog-bind find-referral-targets-duped))))

(define (count-referral-targets) (length (find-referral-targets)))
