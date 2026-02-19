# 📦 FiveM Car Coffre System (Coffre Véhicule)

Script FiveM permettant aux joueurs de monter dans le coffre d’un véhicule et d’en sortir avec animation, écran noir immersif et interaction via ox_target.

Idéal pour les serveurs RP (scènes criminelles, kidnapping, infiltration, etc.).

---

## 🚀 Fonctionnalités

- ✅ Monter dans le coffre d’un véhicule  
- ✅ Sortir du coffre  
- ✅ Animation immersive  
- ✅ Écran noir lorsque le joueur est dans le coffre  
- ✅ Désactivation des contrôles  
- ✅ Vérification si le véhicule est verrouillé  
- ✅ Fermeture automatique du coffre  
- ✅ Sortie automatique si le véhicule est supprimé  
- ✅ Notifications via ox_lib  
- ✅ Interaction via ox_target  

---

## 📦 Dépendances

- 🔹 **ox_lib**  
  👉 https://github.com/overextended/ox_lib  

- 🔹 **ox_target**  
  👉 https://github.com/overextended/ox_target  

- 🔹 FXServer (FiveM)

⚠️ Assurez-vous que `ox_lib` et `ox_target` sont installés et démarrés avant le dossier.

---

## 📥 Installation

### 1️⃣ Télécharger le dossier

Placez le dossier dans votre `resources/`

---

### 2️⃣ Ajouter au server.cfg

Ajoutez les lignes suivantes dans votre `server.cfg` :

```cfg
ensure ox_lib
ensure ox_target
ensure coffre_car
```

