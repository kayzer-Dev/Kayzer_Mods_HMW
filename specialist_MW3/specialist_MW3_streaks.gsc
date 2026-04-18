// --- ATOUTS (perks) - Nom GSC = Nom en jeu ---

// --- Atouts Bleus :
// specialty_longersprint     = Marathon
// specialty_fastreload       = Passe-passe
// specialty_scavenger        = Pillard
// specialty_bling            = Bling-Bling
// specialty_oma              = Machine de guerre
// specialty_spygame          = Oeil de lynx

// --- Atouts Rouges :
// specialty_quickdraw        = Bonne gachette
// specialty_h2lightweight    = Poids leger
// specialty_hardline         = Determination
// specialty_radarimmune      = Assassin
// specialty_explosivedamage  = Bouclier anti-explosion

// --- Atouts Jaunes :
// specialty_extendedmelee    = Commando
// specialty_bulletaccuracy   = Visee solide
// specialty_holdbreath       = Tireur d'elite
// specialty_detectexplosive  = Rapport Pro
// specialty_quieter          = Silence de mort

// --- Autres atouts disponibles :
// specialty_fastmantle       = Accroche rapide
// specialty_extraammo        = Munitions supplementaires
// specialty_bulletdamage     = Stopping Power
// specialty_armorpiercing    = Balle perforante
// specialty_lightweight      = Poids leger (base)
// specialty_fastsprintrecovery = Recuperation sprint
// specialty_rollover         = Roulade
// specialty_dangerclose      = Danger rapproche
// specialty_falldamage       = Chute amortie
// specialty_localjammer      = Brouilleur local
// specialty_delaymine        = Mine retardee
// specialty_heartbreaker     = Briseur de coeur
// specialty_selectivehearing = Oreille selective

// --- KILLSTREAKS - Nom GSC = Nom en jeu ---
// uav_mp                = Drone
// advanced_uav_mp       = Drone ameliore
// counter_uav_mp        = Drone de brouillage
// airdrop_mp            = Ravitaillement
// airdrop_mega_mp       = Ravitaillement massif
// predator_mp           = Missile Predator
// sentry_mp             = Tourelle
// helicopter_mp         = Helicoptere d'attaque
// helicopter_flare_mp   = Helico. avec leurres
// helicopter_gunner_mp  = Helico. arme
// ac130_mp              = AC-130
// stealth_bomber_mp     = Bombardier furtif
// emp_mp                = IEM
// nuke_mp               = Nuke

init()
{
    replacefunc(maps\mp\gametypes\_hud_message::shownotifymessage, ::show_notify_message);
    replacefunc(maps\mp\gametypes\_hud_message::initnotifymessage, ::init_notify_message);
    
    replacefunc(maps\mp\gametypes\_hardpoints::givehardpointitemforstreak, ::give_hard_point_item_for_streak);

    precacheshader("specialty_marathon");
    precacheshader("specialty_marathon_pro");
    precacheshader("specialty_longersprint");
    precacheshader("specialty_lightweight");
    precacheshader("specialty_fastreload");
    precacheshader("specialty_fastreload_pro");
    precacheshader("specialty_scavenger");
    precacheshader("specialty_scavenger_pro");
    precacheshader("specialty_bling");
    precacheshader("specialty_blingpro");
    precacheshader("specialty_oma");
    precacheshader("specialty_oma_pro");
    precacheshader("specialty_bulletdamage");
    precacheshader("specialty_bulletdamage_pro");
    precacheshader("specialty_h2lightweight");
    precacheshader("specialty_h2lightweight_pro");
    precacheshader("specialty_hardline");
    precacheshader("specialty_hardline_pro");
    precacheshader("specialty_radarimmune");
    precacheshader("specialty_radarimmune_pro");
    precacheshader("specialty_explosivedamage");
    precacheshader("specialty_explosivedamage_pro");
    precacheshader("specialty_commando");
    precacheshader("specialty_commando_pro");
    precacheshader("specialty_bulletaccuracy");
    precacheshader("specialty_bulletaccuracy_pro");
    precacheshader("specialty_scrambler");
    precacheshader("specialty_scrambler_pro");
    precacheshader("specialty_ninja");
    precacheshader("specialty_ninja_pro");
    precacheshader("specialty_detectexplosive");
    precacheshader("specialty_detectexplosive_pro");
    // precacheshader("specialty_pistoldeath");
    // precacheshader("specialty_pistoldeath_pro");
    precacheshader("combathigh_overlay");

    // ========================================================
    // CONFIGURATION DES ATOUTS - Modifie les atouts ci-dessous
    // Consulte la liste en haut du fichier pour les noms GSC
    // ========================================================
    level.specialist_perks = [
        "specialty_longersprint",
        "specialty_fastmantle",
        "specialty_fastreload",
        "specialty_quickdraw",
        "specialty_scavenger",
        "specialty_extraammo",
        // "specialty_bling",
        // "specialty_secondarybling",
        "specialty_bulletdamage",
        "specialty_armorpiercing",
        "specialty_lightweight",
        "specialty_fastsprintrecovery",
        "specialty_hardline",
        "specialty_rollover",
        "specialty_radarimmune",
        "specialty_spygame",
        "specialty_explosivedamage",
        "specialty_dangerclose",
        "specialty_extendedmelee",
        "specialty_falldamage",
        "specialty_bulletaccuracy",
        "specialty_holdbreath",
        "specialty_localjammer",
        "specialty_delaymine",
        "specialty_heartbreaker",
        "specialty_quieter",
        "specialty_detectexplosive",
        "specialty_selectivehearing"
        // "specialty_pistoldeath",
        // "specialty_laststandoffhand"
    ];

    // ========================================================
    // CONFIGURATION PALIER FINAL
    // Modifie "cost" pour changer le nombre de kills requis
    // pour debloquer tous les atouts restants
    // ========================================================
    level.specialistitmes = [];
    level.specialistitems["all_perks"]["cost"]  = 8;
    level.specialistitems["all_perks"]["icon"]  = "specialty_oma";
    level.specialistitems["all_perks"]["sound"] = "mp_snd_bomb_planted";
    level.specialistitems["perk_earned_sound"]  = "earn_perk";

    level thread waittill_connected_thread();
}

reset_action_slots()
{
    maps\mp\_utility::_setactionslot(1, "");

    for(slot = 0; slot <= 4; slot++)
        self setweaponhudiconoverride("actionslot" + slot, "none");
}

waittill_connected_thread()
{
    level endon("game_ended");

    for(;;)
    {
        level waittill("connected", player);

        player thread waittill_player_spawned_thread();
    }
}

waittill_player_spawned_thread()
{
    self endon("disconnect");
    level endon("game_ended");

    for(;;)
    {
        self waittill("spawned_player");

        if (isdefined(self.specialist_all_perks_icon))
            self.specialist_all_perks_icon destroy();
        
        if (isdefined(self.got_all_perks))
            self.got_all_perks = undefined;

        self thread reset_action_slots();
    
        // Advanced UAV tous les 15 kills (boucle, sans mourir)
        if (!isdefined(self.adv_uav_loop_started))
        {
            self.adv_uav_loop_started = true;
            self thread adv_uav_loop_thread();
        }
        // Reset du palier donné à chaque spawn (au cas où)
        self.adv_uav_last_award = 0;

        // Nuke re-débloquable en boucle (sans mourir)
        if (!isdefined(self.nuke_loop_started))
        {
            self.nuke_loop_started = true;
            self thread nuke_loop_thread();
        }
        // Reset du palier Nuke donné à chaque spawn
        self.nuke_last_award = 0;
}
}

specialist_notifymessage(title, points, icon)
{
    notifydata              = spawnstruct();
    notifydata.titletext    = title;
    notifydata.notifytext   = points + " Point Streak!";
    notifydata.iconname     = icon;
    notifydata.duration     = 2.0;
    notifydata.resetondeath = true;
    notifydata.sound        = points == self.points_required_for_all_perks ? level.specialistitems["all_perks"]["sound"] : level.specialistitems["perk_earned_sound"];

    thread maps\mp\gametypes\_hud_message::notifymessage(notifydata);
}

combat_high_overlay()
{
    combat_high_overlay             = newclienthudelem(self);
    combat_high_overlay.x           = 0;
    combat_high_overlay.y           = 0;
    combat_high_overlay.alignx      = "left";
    combat_high_overlay.aligny      = "top";
    combat_high_overlay.horzalign   = "fullscreen";
    combat_high_overlay.vertalign   = "fullscreen";
    combat_high_overlay.sort        = -10;
    combat_high_overlay.archived    = true;
    combat_high_overlay setshader("combathigh_overlay", 640, 480);
    
    combat_high_overlay.alpha = 0.0;
    combat_high_overlay fadeovertime(1.0);
    combat_high_overlay.alpha = 0.85;

    wait 1.0;
    
    combat_high_overlay fadeovertime(2.0);
    combat_high_overlay.alpha = 0.0;

    wait 2.0;

    combat_high_overlay destroy();
}

give_all_perks(points)
{
	for(i = 0; i < level.specialist_perks.size; i++)
		maps\mp\_utility::giveperk(level.specialist_perks[i], 0);
    
    self thread combat_high_overlay();
    self thread specialist_notifymessage("All Specialist Perks", points, level.specialistitems["all_perks"]["icon"]);

    self.specialist_all_perks_icon              = self maps\mp\gametypes\_hud_util::createicon(level.specialistitems["all_perks"]["icon"], 18, 18);
    self.specialist_all_perks_icon.alpha        = 1.0;
    self.specialist_all_perks_icon.sort         = 1;
    self.specialist_all_perks_icon.foreground   = true;
    self.specialist_all_perks_icon.archived     = true;
    self.specialist_all_perks_icon maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", undefined, 230);

    self.specialist_all_perks_icon thread maps\mp\gametypes\_hud_util::flashthread();

    say("^2" + self.name + "^7 just got all specialist perks!");
}

give_random_perk(points)
{
    self endon("disconnect");
    level endon("game_ended");

    self.random_perk = level.specialist_perks[randomint(level.specialist_perks.size)];

    if (maps\mp\_utility::_hasperk(self.random_perk))
    {
        while(maps\mp\_utility::_hasperk(self.random_perk))
        {
            self.random_perk = level.specialist_perks[randomint(level.specialist_perks.size)];
            wait .1;
        }
    }

    maps\mp\_utility::giveperk(self.random_perk, 0);

    perk_notify_title   = maps\mp\perks\_perks::perktablelookuplocalizedname(self.random_perk);
    perk_notify_icon    = maps\mp\perks\_perks::perktablelookupimage(self.random_perk);

    switch(points)
    {
        case 2:
            self setweaponhudiconoverride("actionslot3", perk_notify_icon);
            break;
        case 4:
            self setweaponhudiconoverride("actionslot1", perk_notify_icon);
            break;
        case 6:
            self setweaponhudiconoverride("actionslot4", perk_notify_icon);
            break;
        default: break;
    }

    self thread specialist_notifymessage(perk_notify_title, points, perk_notify_icon);
}




get_perk_icon_name(perk)
{
    // On force des icônes "de base" (évite les carrés blancs si la table PRO / aliases n'existe pas).
    if (perk == "specialty_scavenger")
        return "specialty_scavenger";

    // Marathon : le perk effectif est longersprint, mais l'icône base est souvent marathon
    if (perk == "specialty_longersprint")
        return "specialty_marathon";

    // Lightweight : selon les builds HMW/H2M l'icône base est souvent "specialty_lightweight"
    if (perk == "specialty_h2lightweight")
        return "specialty_lightweight";

    return perk;
}

give_specific_perk(points, perk)
{
    self endon("disconnect");
    level endon("game_ended");

    // Donne un atout précis (non-aléatoire).
    // Note: si le joueur a déjà cet atout via sa classe, giveperk n'ajoutera rien de nouveau.
    maps\mp\_utility::giveperk(perk, 0);

    perk_notify_title   = maps\mp\perks\_perks::perktablelookuplocalizedname(perk);

    perk_icon_name     = get_perk_icon_name(perk);
    perk_notify_icon   = perk_icon_name;

    switch(points)
    {
        case 2:
            self setweaponhudiconoverride("actionslot3", perk_notify_icon);
            break;
        case 4:
            self setweaponhudiconoverride("actionslot1", perk_notify_icon);
            break;
        case 6:
            self setweaponhudiconoverride("actionslot4", perk_notify_icon);
            break;
        default: break;
    }

    self thread specialist_notifymessage(perk_notify_title, points, perk_notify_icon);
}



give_hard_point_item_for_streak()
{
	if (isbot(self))
		return;

	player_streak   = self.pers["cur_kill_streak"];

    nuke_cost       = level.hardpointitems["nuke_mp"];
    all_perks_cost  = level.specialistitems["all_perks"]["cost"];
    
    if (self maps\mp\_utility::_hasperk("specialty_hardline"))
    {
        nuke_cost--;
        // all_perks_cost reste inchangé (palier "tous les atouts" forcé)
    }

    self.points_required_for_all_perks = all_perks_cost;

    if (player_streak == all_perks_cost)
    {
        self.got_all_perks = true;
        self thread give_all_perks(player_streak);
        return;
    }

    // ========================================================
    // PALIERS D'ATOUTS - Modifie les case et les atouts ici
    // case 2 -> 2 kills  -> atout donne au palier 1
    // case 4 -> 4 kills  -> atout donne au palier 2
    // case 6 -> 6 kills  -> atout donne au palier 3
    // Consulte la liste en haut du fichier pour les noms GSC
    // ========================================================
    if (player_streak <= 8 && !(player_streak % 2) && !isdefined(self.got_all_perks))
    {
        switch(player_streak)
        {
            case 2:
                self thread give_specific_perk(player_streak, "specialty_scavenger");
                break;
            case 4:
                self thread give_specific_perk(player_streak, "specialty_longersprint");
                break;
            case 6:
                // "Lightweight Pro" (H2M) est souvent référencé comme specialty_h2lightweight_pro
                self thread give_specific_perk(player_streak, "specialty_h2lightweight");
                break;
            default:
                self thread give_random_perk(player_streak);
                break;
        }
        return;
    }

    if (player_streak == nuke_cost)
    {
        self setweaponhudiconoverride("actionslot4", "nuke_mp");
        maps\mp\_utility::_setactionslot(4, "nuke_mp");
        thread maps\mp\gametypes\_hardpoints::givehardpoint("nuke_mp", player_streak);
    }
}

init_notify_message()
{
    title_font_scale    = 2.0;
    text_font_scale     = 1.0;
    icon_size           = 16;
    font                = "objective";
    align               = "TOP";
    relative            = "BOTTOM";
    y_offset            = 120;
    x_offset            = 0;

    self.notifytitle = maps\mp\gametypes\_hud_util::createfontstring(font, title_font_scale);
    self.notifytitle maps\mp\gametypes\_hud_util::setpoint(align, undefined, x_offset, y_offset);
    self.notifytitle.hidewheninmenu = 1;
    self.notifytitle.archived = 0;
    self.notifytitle.alpha = 0;
    self.notifytext = maps\mp\gametypes\_hud_util::createfontstring(font, text_font_scale);
    self.notifytext maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
    self.notifytext maps\mp\gametypes\_hud_util::setpoint(align, relative, 0, -5);
    self.notifytext.hidewheninmenu = 1;
    self.notifytext.archived = 0;
    self.notifytext.alpha = 0;
    self.notifytext2 = maps\mp\gametypes\_hud_util::createfontstring(font,text_font_scale);
    self.notifytext2 maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
    self.notifytext2 maps\mp\gametypes\_hud_util::setpoint(align, relative, 0, 0);
    self.notifytext2.hidewheninmenu = 1;
    self.notifytext2.archived = 0;
    self.notifytext2.alpha = 0;
    self.notifyicon = maps\mp\gametypes\_hud_util::createicon("white", icon_size, icon_size);
    self.notifyicon maps\mp\gametypes\_hud_util::setparent(self.notifytext2);
    self.notifyicon maps\mp\gametypes\_hud_util::setpoint(align,relative,0,0);
    self.notifyicon.hidewheninmenu = 1;
    self.notifyicon.archived = 0;
    self.notifyicon.alpha = 0;
    self.notifyoverlay = maps\mp\gametypes\_hud_util::createicon("white", icon_size, icon_size);
    self.notifyoverlay maps\mp\gametypes\_hud_util::setparent(self.notifyicon);
    self.notifyoverlay maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,0);
    self.notifyoverlay.hidewheninmenu = 1;
    self.notifyoverlay.archived = 0;
    self.notifyoverlay.alpha = 0;
    self.doingsplash = [];
    self.doingsplash[0] = undefined;
    self.doingsplash[1] = undefined;
    self.doingsplash[2] = undefined;
    self.doingsplash[3] = undefined;
    self.splashqueue = [];
    self.splashqueue[0] = [];
    self.splashqueue[1] = [];
    self.splashqueue[2] = [];
    self.splashqueue[3] = [];
}

show_notify_message( notifyData )
{
    self endon( "disconnect" );

    if ( maps\mp\_utility::is_true( notifyData.resetondeath ) )
        self endon( "death" );

    assert( isDefined( notifyData.slot ) );
    slot = notifyData.slot;

    if ( level.gameEnded )
    {
        if ( isDefined( notifyData.type ) && notifyData.type == "rank" )
        {
            self setClientDvar( "ui_promotion", 1 );
            self.postGamePromotion = true;
        }

        if ( self.splashQueue[ slot ].size )
            self thread maps\mp\gametypes\_hud_message::dispatchNotify( slot );

        return;
    }

    self.doingsplash[slot] = notifyData;

    if ( maps\mp\_utility::is_true( notifyData.resetondeath ) )
        thread maps\mp\gametypes\_hud_message::resetondeath();

    thread maps\mp\gametypes\_hud_message::resetoncancel();
    maps\mp\gametypes\_hud_message::waitrequirevisibility( 0 );

    if ( isdefined( notifyData.duration ) )
        duration = notifyData.duration;
    else if ( level.gameended )
        duration = 2.0;
    else
        duration = 4.0;

    if ( isdefined( notifyData.sound ) )
        self playlocalsound( notifyData.sound );

    if ( isdefined( notifyData.leadersound ) )
        maps\mp\_utility::leaderdialogonplayer( notifyData.leadersound );

    var_3 = notifyData.glowcolor;
    var_4 = self.notifytitle;

    if ( isdefined( notifyData.titletext ) )
    {
        self.notifytitle.font = "objective";
        self.notifytitle.fontScale = 1.5;

        if ( isdefined( notifyData.titlelabel ) )
            self.notifytitle.label = notifyData.titlelabel;
        else
            self.notifytitle.label = &"";

        if ( isdefined( notifyData.titlelabel ) && !isdefined( notifyData.titleisstring ) )
            self.notifytitle setvalue( notifyData.titletext );
        else
            self.notifytitle settext( notifyData.titletext );

        if ( isdefined( var_3 ) )
            self.notifytitle.glowcolor = var_3;

        self.notifytitle.alpha = 1;
        self.notifytitle fadeovertime( duration * 1.0 );
        self.notifytitle.alpha = 0;
    }

    if ( isdefined( notifyData.textglowcolor ) )
        var_3 = notifyData.textglowcolor;

    if ( isdefined( notifyData.notifytext ) )
    {
        self.notifytext.font = "objective";
        self.notifytext.fonScale = 1.0;
        if ( isdefined( notifyData.textlabel ) )
            self.notifytext.label = notifyData.textlabel;
        else
            self.notifytext.label = &"";

        if ( isdefined( notifyData.textlabel ) && !isdefined( notifyData.textisstring ) )
            self.notifytext setvalue( notifyData.notifytext );
        else
            self.notifytext settext( notifyData.notifytext );

        if ( isdefined( var_3 ) )
            self.notifytext.glowcolor = var_3;

        self.notifytext.alpha = 1;
        self.notifytext fadeovertime( duration * 1.0 );
        self.notifytext.alpha = 0;
        var_4 = self.notifytext;
    }

    if ( isdefined( notifyData.notifytext2 ) )
    {
        self.notifytext2 maps\mp\gametypes\_hud_util::setparent( var_4 );

        if ( isdefined( notifyData.text2label ) )
            self.notifytext2.label = notifyData.text2label;
        else
            self.notifytext2.label = &"";

        self.notifytext2 settext( notifyData.notifytext2 );

        if ( isdefined( var_3 ) )
            self.notifytext2.glowcolor = var_3;

        self.notifytext2.alpha = 1;
        self.notifytext2 fadeovertime( duration * 1.0 );
        self.notifytext2.alpha = 0;
        var_4 = self.notifytext2;
    }

    if ( isdefined( notifyData.iconname ) )
    {
        self.notifyicon maps\mp\gametypes\_hud_util::setparent( var_4 );

        self.notifyicon setshader( notifyData.iconname, 36, 36);

        self.notifyicon.alpha = 0;

        if ( isdefined( notifyData.iconoverlay ) )
        {
            self.notifyicon fadeovertime( 0.15 );
            self.notifyicon.alpha = 1;
            notifyData.overlayoffsety = 0;
            self.notifyoverlay maps\mp\gametypes\_hud_util::setparent( self.notifyicon );
            self.notifyoverlay maps\mp\gametypes\_hud_util::setpoint( "CENTER", "CENTER", 0, notifyData.overlayoffsety );
            self.notifyoverlay setshader( notifyData.iconoverlay, 511, 511 );
            self.notifyoverlay.alpha = 0;
            self.notifyoverlay.color = game["colors"]["orange"];
            self.notifyoverlay fadeovertime( 0.4 );
            self.notifyoverlay.alpha = 0.85;
            self.notifyoverlay scaleovertime( 0.4, 32, 32 );
            maps\mp\gametypes\_hud_message::waitrequirevisibility( duration );
            self.notifyicon fadeovertime( 0.75 );
            self.notifyicon.alpha = 0;
            self.notifyoverlay fadeovertime( 0.75 );
            self.notifyoverlay.alpha = 0;
        }
        else
        {
            self.notifyicon fadeovertime( 1.0 );
            self.notifyicon.alpha = 1;
            maps\mp\gametypes\_hud_message::waitrequirevisibility( duration );
            self.notifyicon fadeovertime( 0.75 );
            self.notifyicon.alpha = 0;
        }
    }
    else
        maps\mp\gametypes\_hud_message::waitrequirevisibility( duration );

    self notify( "notifyMessageDone" );
    self.doingsplash[slot] = undefined;

    if ( self.splashqueue[slot].size )
        thread maps\mp\gametypes\_hud_message::dispatchnotify( slot );
}


// ============================================================================
// Advanced UAV tous les 15 kills (boucle, sans avoir besoin de mourir)
// - Utilise advanced_uav_mp
// - Force l'actionslot 3 (remplace l'ancienne récompense du slot 3 si besoin)
// ============================================================================
adv_uav_loop_thread()
{
    self endon("disconnect");
    level endon("game_ended");

    if (!isdefined(self.adv_uav_last_award))
        self.adv_uav_last_award = 0;

    for (;;)
    {
        if (!isdefined(self.pers) || !isdefined(self.pers["cur_kill_streak"]))
        {
            wait 0.05;
            continue;
        }

        cur = self.pers["cur_kill_streak"];

        // Si la série retombe (mort, reset, etc.), on repart à zéro
        if (cur < self.adv_uav_last_award)
            self.adv_uav_last_award = 0;

        // Palier tous les 15 kills : 15 / 30 / 45 / ...
        // ========================================================
        // Modifie "+ 15" pour changer le palier du drone ameliore
        // Exemple : "+ 10" = drone ameliore tous les 10 kills
        // ========================================================
        while (cur >= self.adv_uav_last_award + 15)
        {
            self.adv_uav_last_award += 15;
            self give_adv_uav(self.adv_uav_last_award);
        }

        wait 0.05;
    }
}

give_adv_uav(streakValue)
{
    if (isbot(self))
        return;

    // Nom confirmé par toi
    // ========================================================
    // Modifie "advanced_uav_mp" pour changer le killstreak donne
    // Consulte la liste des killstreaks en haut du fichier
    // ========================================================
    adv = "advanced_uav_mp";

    // Sécurité : si jamais ce hardpoint n'existe pas dans cette version, on ne fait rien.
    if (!isdefined(level.hardpointitems) || !isdefined(level.hardpointitems[adv]))
        return;

    // Boucle : on force toujours le slot 3, comme ça tu peux le "re-débloquer" même sans mourir.
    self setweaponhudiconoverride("actionslot3", adv);
    maps\mp\_utility::_setactionslot(3, adv);

    thread maps\mp\gametypes\_hardpoints::givehardpoint(adv, streakValue);
}


// ============================================================================
// Nuke re-débloquable (boucle)
// - Donne la nuke à chaque palier (ex: 25 / 50 / 75 / ...) selon le coût courant
// - Respecte Hardline (si tu l'as, le coût baisse de 1 comme dans ton script)
// - Force l'actionslot 4
// ============================================================================

nuke_loop_thread()
{
    self endon("disconnect");
    level endon("game_ended");

    if (!isdefined(self.nuke_last_award))
        self.nuke_last_award = 0;

    for (;;)
    {
        if (!isdefined(self.pers) || !isdefined(self.pers["cur_kill_streak"]))
        {
            wait 0.05;
            continue;
        }

        cur = self.pers["cur_kill_streak"];

        // Si la série retombe (mort, reset, etc.), on repart à zéro
        if (cur < self.nuke_last_award)
            self.nuke_last_award = 0;

        cost = get_current_nuke_cost();
        if (!isdefined(cost) || cost <= 0)
        {
            wait 0.1;
            continue;
        }

        // Déclenche au palier exact : cost / cost*2 / cost*3 / ...
        // On mémorise le dernier palier donné pour éviter les doubles.
        if (cur >= cost && !(cur % cost) && cur != self.nuke_last_award)
        {
            self.nuke_last_award = cur;
            self give_nuke_loop(cur);
        }

        wait 0.05;
    }
}

get_current_nuke_cost()
{
    if (!isdefined(level.hardpointitems) || !isdefined(level.hardpointitems["nuke_mp"]))
        return undefined;

    nuke_cost = level.hardpointitems["nuke_mp"];

    // Même règle que ton script
    if (self maps\mp\_utility::_hasperk("specialty_hardline"))
        nuke_cost--;

    return nuke_cost;
}

give_nuke_loop(streakValue)
{
    if (isbot(self))
        return;

    // Sécurité : si le hardpoint n'existe pas, on ne fait rien.
    if (!isdefined(level.hardpointitems) || !isdefined(level.hardpointitems["nuke_mp"]))
        return;

    // Boucle : on force toujours le slot 4
    self setweaponhudiconoverride("actionslot4", "nuke_mp");
    maps\mp\_utility::_setactionslot(4, "nuke_mp");

    thread maps\mp\gametypes\_hardpoints::givehardpoint("nuke_mp", streakValue);
}