showEnv =
function(e)
{
    while(!is.null(e) && !identical(e, emptyenv())) {
        print(e)
        e = parent.env(e)
    }
}
