' Set objArgs = WScript.Arguments
' messageText = objArgs(0)
' MsgBox messageText

' Définir le message à afficher
strMessage = "C'est plus interessant que les jeux de cuisine ?"

' Définir les boutons et le titre de la boîte de message
intBoutons = vbYesNo 
strTitre = "Tu trouves ?"

' Afficher la boîte de message et récupérer la réponse de l'utilisateur
intReponse = MsgBox(strMessage, intBoutons, strTitre)
