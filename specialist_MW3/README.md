# 🎖️ Specialist MW3 — Mod Standalone pour HMW

Deux scripts inspirés du mode Spécialiste de Call of Duty Modern Warfare 3.  
A placer directement dans `user_scripts/mp/` — HMW les charge automatiquement au démarrage.  
**Utilise un seul fichier à la fois** — ne mets pas les deux en même temps, ils se confondent.

---

## 📄 specialist_MW3.gsc — Atouts uniquement

### Ce que ca fait
A chaque palier de kills sans mourir, le joueur debloque un atout specifique.  
Au palier final, tous les atouts restants sont donnes d'un coup avec un effet visuel.

### Paliers par defaut
| Kills | Recompense |
|-------|------------|
| 2 kills | Pillard (`specialty_scavenger`) |
| 4 kills | Marathon (`specialty_longersprint`) |
| 6 kills | Poids leger (`specialty_h2lightweight`) |
| 8 kills | Tous les atouts restants |

### Comment modifier
Ouvre le fichier et cherche le bloc `PALIERS D'ATOUTS` dans la fonction `give_hard_point_item_for_streak()` :

```
case 2:
    self thread give_specific_perk(player_streak, "specialty_scavenger");  // Pillard
    break;
case 4:
    self thread give_specific_perk(player_streak, "specialty_longersprint"); // Marathon
    break;
case 6:
    self thread give_specific_perk(player_streak, "specialty_h2lightweight"); // Poids leger
    break;
```

- **Changer un atout** : remplace le nom GSC entre guillemets (ex: `"specialty_scavenger"`)
- **Changer un palier de kills** : remplace le chiffre apres `case` (ex: `case 2:` -> `case 3:`)
- **Changer le palier final** : dans `init()`, modifie `level.specialistitems["all_perks"]["cost"] = 8;`
- **Changer les atouts donnes au palier final** : modifie la liste `level.specialist_perks` dans `init()`

La liste complete des noms GSC disponibles est en commentaire en haut du fichier.

---

## 📄 specialist_MW3_streaks.gsc — Atouts + Killstreaks + Nuke

### Ce que ca fait
Meme systeme d'atouts que le fichier precedent, avec en plus :
- Un killstreak donne automatiquement a certains paliers de kills
- La nuke se debloque tous les 25 kills sans mourir (puis 50, 75, etc. en boucle)
- Le drone ameliore se donne tous les 15 kills sans mourir (en boucle)

### Paliers par defaut
| Kills | Recompense |
|-------|------------|
| 2 kills | Pillard (`specialty_scavenger`) |
| 4 kills | Marathon (`specialty_longersprint`) |
| 6 kills | Poids leger (`specialty_h2lightweight`) |
| 8 kills | Tous les atouts restants |
| 15 kills | Drone ameliore (`advanced_uav_mp`) — se repete en boucle |
| 25 kills | Nuke (`nuke_mp`) — se repete en boucle |

### Comment modifier les atouts
Identique au fichier `specialist_MW3.gsc` — voir section ci-dessus.

### Comment modifier le drone ameliore
Cherche le bloc `CONFIGURATION KILLSTREAK DRONE AMELIORE` dans `adv_uav_loop_thread()` :

```
while (cur >= self.adv_uav_last_award + 15)   // Modifie 15 pour changer le palier
```

Pour changer le killstreak donne, modifie dans `give_adv_uav()` :

```
adv = "advanced_uav_mp";   // Remplace par le killstreak de ton choix
```

### Comment modifier la nuke
La nuke utilise automatiquement le cout natif du jeu (25 kills par defaut dans HMW).  
Tu ne peux pas changer ce palier directement — il suit le cout natif de la nuke dans le jeu.

---

## 📋 Liste des atouts disponibles

| Nom GSC | Nom en jeu |
|---------|------------|
| `specialty_longersprint` | Marathon |
| `specialty_fastreload` | Passe-passe |
| `specialty_scavenger` | Pillard |
| `specialty_bling` | Bling-Bling |
| `specialty_oma` | Machine de guerre |
| `specialty_spygame` | Oeil de lynx |
| `specialty_quickdraw` | Bonne gachette |
| `specialty_h2lightweight` | Poids leger |
| `specialty_hardline` | Determination |
| `specialty_radarimmune` | Assassin |
| `specialty_explosivedamage` | Bouclier anti-explosion |
| `specialty_extendedmelee` | Commando |
| `specialty_bulletaccuracy` | Visee solide |
| `specialty_holdbreath` | Tireur d'elite |
| `specialty_detectexplosive` | Rapport Pro |
| `specialty_quieter` | Silence de mort |
| `specialty_fastmantle` | Accroche rapide |
| `specialty_extraammo` | Munitions supplementaires |
| `specialty_bulletdamage` | Stopping Power |
| `specialty_armorpiercing` | Balle perforante |
| `specialty_lightweight` | Poids leger (base) |
| `specialty_fastsprintrecovery` | Recuperation sprint |
| `specialty_rollover` | Roulade |
| `specialty_dangerclose` | Danger rapproche |
| `specialty_falldamage` | Chute amortie |
| `specialty_localjammer` | Brouilleur local |
| `specialty_delaymine` | Mine retardee |
| `specialty_heartbreaker` | Briseur de coeur |
| `specialty_selectivehearing` | Oreille selective |

## 📋 Liste des killstreaks disponibles

| Nom GSC | Nom en jeu |
|---------|------------|
| `uav_mp` | Drone |
| `advanced_uav_mp` | Drone ameliore |
| `counter_uav_mp` | Drone de brouillage |
| `airdrop_mp` | Ravitaillement |
| `airdrop_mega_mp` | Ravitaillement massif |
| `predator_mp` | Missile Predator |
| `sentry_mp` | Tourelle |
| `helicopter_mp` | Helicoptere d'attaque |
| `helicopter_flare_mp` | Helico. avec leurres |
| `helicopter_gunner_mp` | Helico. arme |
| `ac130_mp` | AC-130 |
| `stealth_bomber_mp` | Bombardier furtif |
| `emp_mp` | IEM |
| `nuke_mp` | Nuke |

---

*Cree par Kayzer — Kayzer Menu / HMW*
