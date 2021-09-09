(defun mlemosf/org-latex-project/get-tex-class ()
  "Utiliza o ivy para selecionar a classe do template para o arquivo LaTeX"
  (let* (
      (format-list '("ieee-article" "one-page-abstract" "abnt"))
      (format (ivy-read "Selecione o formato:" format-list))
  ) format))

(defun mlemosf/org-latex-project/create-org-file (filename filepath title author class)
  "Cria um arquivo org com nome FILENAME, titúlo TITLE, autor AUTHOR e com a classe LaTex CLASS"
  (let (
        (article-buf (get-buffer-create filename))
        )
    (set-buffer article-buf)
    (insert (format "#+TITLE: %s\n" title))
    (insert (format "#+AUTHOR: %s\n" author))
    (insert (format "#+LATEX_CLASS: %s\n" class))
    (insert "#+LATEX_COMPILER: pdflatex\n")
    (insert "#+OPTIONS: toc:nil\n")
    (insert "#+STARTUP: content\n")
    (insert "\n\\bibliographystyle{plain}\n\\bibliography{references}")
    (write-file (format "%s/%s.org" filepath filename))
    (kill-buffer article-buf)))

(defun mlemosf/org-latex-project/create-bibtex-file (filepath)
  "Cria um arquivo bibtex vazio na pasta FILEPATH"
  (let (
        (references-buf (get-buffer-create "references.bib")))
    (set-buffer references-buf)
    (write-file (format "%s/references.bib" filepath))
    (kill-buffer references-buf)))

(defun mlemosf/org-bibtex-project/new-project ()
  "Cria um novo projeto LaTeX"
    (interactive)
    (let* (
         (project-name (read-string "Digite o nome do projeto: "))
         (path (read-string "Digite o caminho do arquivo: "))
         (format (mlemosf/org-latex-project/get-tex-class))
         (title (read-string "Digite o título do trabalho: "))
         (author (read-string "Nome do autor: "))
         (fullpath (format "%s/%s" path project-name)))
    (make-directory fullpath)
    (mlemosf/org-latex-project/create-org-file project-name fullpath title author format)
    (mlemosf/org-latex-project/create-bibtex-file fullpath)
    (message "Projeto criado com sucesso")))
