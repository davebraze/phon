

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Find all homophones of the given phoneme character strings
#'
#' Homophones are words with the same pronunciation but different spelling.
#'
#' This function finds the phonemes (without stresses) for the given word, and
#' finds all other words with the same phonemes.
#'
#' @param phons Vector of phoneme strings e.g. c("K AE1 R IY0", "K EH1 R IY0")
#' @param keep_stresses keep the stresses attached to each phonmeme? Default: FALSE
#'
#' @return character vector of homophones.
#'
#' @examples
#' homophones_phonemes(phonemes('steak'))
#' homophones_phonemes("K AH R IY")
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
homophones_phonemes <- function(phons, keep_stresses = FALSE) {

  phons <- sanitize_phons(phons)
  dict  <- choose_dict(keep_stresses)

  if (!keep_stresses) {
    phons <- remove_stresses(phons)
  }


  idxs <- lapply(phons, function(x) { which(dict == x) })
  idxs <- sort(unique(unlist(idxs, use.names = FALSE)))

  names(dict[idxs])
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Find all homophones of the given word
#'
#' Homophones are words with the same pronunciation but different spelling.
#'
#' @param word single word
#' @param keep_stresses keep the stresses attached to each phonmeme? Default: FALSE
#'
#' @return Character vector of words which are homophones for the given word.
#'
#' @examples
#' homophones("steak")
#' homophones("carry")
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
homophones <- function(word, keep_stresses = FALSE) {
  dict  <- choose_dict(keep_stresses)
  phons <- dict[names(dict) == word]
  words <- homophones_phonemes(phons, keep_stresses)

  setdiff(words, word)
}

