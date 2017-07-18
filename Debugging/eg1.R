# The issue here is any(lw) > 10 rather than any(lw > 10)
#
# And before that, had linewidth rather than lineWidth.

#
# Source ReadPDF/R/getTitle.R
# Then source this function.
# getDocTitle(getX("09583"))
#

splitElsevierTitle =
    function(nodes, page)
    {
        browser()
            y = as.numeric(sapply(nodes, xmlGetAttr, "top"))
            lines = getNodeSet(page, ".//line")
            lw = as.numeric(sapply(lines, xmlGetAttr, "linewidth"))
            if(any(lw) > 10) {
                        i = which.max(lw)
                        yl = as.numeric(strsplit(xmlGetAttr(lines[[i]], "bbox"), ",")[[1]])[2]
                                nodes = nodes[y > yl]
                    }

         paste(names(nodes), collapse = " ")

    }
