# The Call Stack

When we call a function 
As 




where 1: paste(path, collapse = " | ")
where 2: xpathApply.XMLInternalDocument(doc, path, fun, ..., namespaces = namespaces,
    sessionEncoding = sessionEncoding, addFinalizer = addFinalizer)
where 3: xpathApply(doc, path, fun, ..., namespaces = namespaces, sessionEncoding =
	sessionEncoding, addFinalizer = addFinalizer)
where 4: getNodeSet(doc, "//page")
where 5: getPages(doc)
where 6: lapply(getPages(doc), getTextByCols)
where 7: pdfText(doc)
where 8: unlist(text)
where 9: strsplit(unlist(text), "[[:space:][:punct:]]+")
where 10: unlist(strsplit(unlist(text), "[[:space:][:punct:]]+"))
where 11: getDocWords(doc)
where 12: isScanned2(doc)
where 13: getDocTitle("LatestDocs/PDF/1066657133/Nishiura-2016-Preliminary estimation of the
		ba.xml")
		
