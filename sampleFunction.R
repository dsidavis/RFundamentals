getTextByCols =
function(p, threshold = .1, asNodes = FALSE)
{
    if(length(p) == 0)
       return(character())
    
    txtNodes = getNodeSet(p, ".//text")
    bb = getBBox2(txtNodes)
    bb = as.data.frame(bb)
    bb$text = sapply(txtNodes, xmlValue)

    tt = table(bb$left)
      # Subtract 2 so that we start slightly to the left of the second column to include those starting points
      # or change cut to be include.lowest = TRUE
    breaks = as.numeric(names(tt [ tt > nrow(bb)*threshold])) - 2

    if(asNodes) {
        split(txtNodes, cut(bb$left, c(0, breaks[-1], Inf)))
    } else {
        cols = split(bb, cut(bb$left, c(0, breaks[-1], Inf)))
        cols = sapply(cols, function(x) paste(x$text[ order(x$top) ], collapse = "\n"))
    }
}

