echo "You'll need to update Config.hs with whatever password you give the pvn user"
createuser --pwprompt pvn
createdb -Opvn -Eutf8 pvn
