ArmeConfig = ArmeConfig or {}

ArmeConfig.LienBoutique = "https://prisel.koredia.com/"

-- local knife = "Oui"
-- local fun = "Oui2"
-- local pistol = "Oui3"
-- local lourde = "Oui4"
-- local shotgun = "Oui5"
-- local sniper = "oui6"

local knife = Material("materials/prisel_newboutiquematerials/knifes.png")
local fun = Material("materials/prisel_newboutiquematerials/unicorn.png")
local pistol = Material("materials/prisel_newboutiquematerials/pistols.png")
local lourde = Material("materials/prisel_newboutiquematerials/lourdes.png")
local shotgun = Material("materials/prisel_newboutiquematerials/shotgun.png")
local sniper = Material("materials/prisel_newboutiquematerials/snipers.png")
local favorite = Material("materials/prisel_newboutiquematerials/favorite.png")
local boutique = Material("materials/prisel_newboutiquematerials/boutique.png")
local takefavo = Material("materials/prisel_newboutiquematerials/love.png")

ArmeConfig.Category = {
    [1] = {["name"] = "corps a corps", ["icon"] = knife},
    [2] = {["name"] = "arme legere", ["icon"] = pistol},
    [3] = {["name"] = "armes favorites", ["icon"] = favorite},
    [4] = {["name"] = "arme lourde", ["icon"] = lourde},
    [5] = {["name"] = "fusil a pompe", ["icon"] = shotgun},
    [6] = {["name"] = "lien boutique", ["icon"] = boutique},
    [7] = {["name"] = "sniper", ["icon"] = sniper},
    [8] = {["name"] = "fun et autres", ["icon"] = fun},
    [9] = {["name"] = "prendre armes favorites", ["icon"] = takefavo}

}

ArmeConfig.WeaponList = {

    tfa_tar21 = {
        name = "TAR 21",
        wep = "tfa_tar21",
        category = "arme lourde",
        model = "models/weapons/tfa_w_imi_tar21.mdl",
        rareter = "Rare",
    },

    tfa_nmrih_wrench = {
        name = "Clé à molette",
        wep = "tfa_nmrih_wrench",
        category = "corps a corps",
        model = "models/weapons/tfa_nmrih/w_me_wrench.mdl",
        rareter = "Mythique",
    },

    csgo_karambit_lore = {
        name = "Karambit en OR",
        wep = "csgo_karambit_lore",
        category = "corps a corps",
        model = "models/weapons/w_csgo_karambit.mdl",
        rareter = "Commun",
    },

    tfa_deagle = {
        name = "Desert Eagle",
        wep = "tfa_deagle",
        category = "arme legere",
        model = "models/weapons/w_pist_deagle.mdl",
        rareter = "Commun",
    },

    tfa_tec9 = {
        name = "TEC-9",
        wep = "tfa_tec9",
        category = "arme lourde",
        model = "models/weapons/tfa_w_intratec_tec9.mdl",
        rareter = "Rare"
    },

    tfa_acr = {
        name = "ACR",
        wep = "tfa_acr",
        category = "arme lourde",
        model = "models/weapons/tfa_w_masada_acr.mdl",
        rareter = "Rare"
    },

    tfa_minigun = {
        name = "Minigun",
        wep = "tfa_minigun",
        category = "arme lourde",
        model = "models/weapons/tfa_w_m134_minigun.mdl",
        rareter = "Epic"
    },

    deika_blundergat = {
        name = "Quadrabarrel",
        wep = "deika_blundergat",
        category = "fusil a pompe",
        model = "models/weapons/w_blundergat.mdl",
        rareter = "Mythique",
    },

    awpdragon = {
        name = "Dragon Lore",
        wep = "awpdragon",
        category = "sniper",
        model = "models/csgo/weapons/w_snip_awp_dragon_lore.mdl",
        rareter = "Rare",
    },

    tfa_m24 = {
        name = "M24",
        wep = "tfa_m24",
        category = "sniper",
        model = "models/weapons/w_snip_m24_6.mdl",
        rareter = "Commun",
    },

    tfa_f2000 = {
        name = "F2000",
        wep = "tfa_f2000",
        category = "arme lourde",
        model = "models/weapons/tfa_w_fn_f2000.mdl",
        rareter = "Rare",
    },

    tfa_ares_shrike = {
        name = "Ares Shrike",
        wep = "tfa_ares_shrike",
        category = "arme lourde",
        model = "models/weapons/w_ares_shrike.mdl",
        rareter = "Commun",
    },

    tfa_ak47 = {
        name = "AK-47",
        wep = "tfa_ak47",
        category = "arme lourde",
        model = "models/weapons/tfa_w_ak47_tfa.mdl",
        rareter = "Rare",
    },

    tfa_winchester73 = {
        name = "73 Winchester Carabine",
        wep = "tfa_winchester73",
        category = "fusil a pompe",
        model = "models/weapons/tfa_w_winchester_1873.mdl",
        rareter = "Mythique",
    },

    tfa_smgp90 = {
        name = "P90",
        wep = "tfa_smgp90",
        category = "arme lourde",
        model = "models/weapons/w_smg_p90.mdl",
        rareter = "Commun",
    },

    tfa_scar = {
        name = "SCAR-H",
        wep = "tfa_scar",
        category = "arme lourde",
        model = "models/weapons/tfa_w_fn_scar_h.mdl",
        rareter = "Mythique",
    },

    tfa_nmrih_machete = {
        name = "Machette",
        wep = "tfa_nmrih_machete",
        category = "corps a corps",
        model = "models/weapons/tfa_nmrih/w_me_machete.mdl",
        rareter = "Commun",
    },

    pyrozooka = {
        name = "Pyrozooka",
        wep = "pyrozooka",
        category = "fun et autres",
        model = "models/zerochain/pyrozooka/w_pyrozooka.mdl",
        rareter = "Mythique",
    },

    weapon_vape = {
        name = "Vapoteuse",
        wep = "weapon_vape",
        category = "fun et autres",
        model = "models/creamdoritos/vape.mdl",
        rareter = "Commun",
    },

    med_kit = {
        name = "Medic Kit",
        wep = "med_kit",
        category = "fun et autres",
        model = "models/items/healthkit.mdl",
        rareter = "Commun",
    },

    tfa_prisel_snipertazer = {
        name = "Sniper Tazer",
        wep = "tfa_prisel_snipertazer",
        category = "sniper",
        model = "models/weapons/tfa_ins2/c_codol_freedom.mdl",
        rareter = "Epic",
    },

    tfa_nmrih_chainsaw = {
        name = "Tronçonneuse",
        wep = "tfa_nmrih_chainsaw",
        category = "corps a corps",
        model = "models/weapons/tfa_nmrih/v_me_chainsaw.mdl",
        rareter = "Mythique",
    },

    destiny_invective = {
        name = "Fusil du Général Lahcen",
        wep = "destiny_invective",
        category = "fusil a pompe",
        model = "models/invective.mdl",
        rareter = "Epic",
    },

    tfa_nmrih_bcd = {
        name = "Marteau",
        wep = "tfa_nmrih_bcd",
        category = "corps a corps",
        model = "models/weapons/tfa_nmrih/w_tool_barricade.mdl",
        rareter = "Commun",
    },

    tfa_glock = {
        name = "Glock 18",
        wep = "tfa_glock",
        category = "arme legere",
        model = "models/weapons/tfa_w_dmg_glock.mdl",
        rareter = "Rare",
    },

    csgo_flip_lore = {
        name = "Flip Lore",
        wep = "csgo_flip_lore",
        category = "corps a corps",
        model = "models/weapons/w_csgo_flip.mdl",
        rareter = "Commun",
    },

    csgo_daggers_ultraviolet = {
        name = "Draggers Ultraviolet",
        wep = "csgo_daggers_ultraviolet",
        category = "corps a corps",
        model = "models/weapons/w_csgo_push.mdl",
        rareter = "Commun",
    },

    csgo_daggers_webs = {
        name = "Draggers Webs",
        wep = "csgo_daggers_webs",
        category = "corps a corps",
        model = "models/weapons/w_csgo_push.mdl",
        rareter = "Commun",
    },

    csgo_m9_lore = {
        name = "M9 Lore",
        wep = "csgo_m9_lore",
        category = "corps a corps",
        model = "models/weapons/w_csgo_m9.mdl",
        rareter = "Commun",
    },

    csgo_bayonet_lore = {
        name = "Bayonet Lore",
        wep = "csgo_bayonet_lore",
        category = "corps a corps",
        model = "models/weapons/w_csgo_bayonet.mdl",
        rareter = "Commun",
    },

    csgo_bayonet_bright_water = {
        name = "Bayonet Bright Water",
        wep = "csgo_bayonet_bright_water",
        category = "corps a corps",
        model = "models/weapons/w_csgo_bayonet.mdl",
        rareter = "Commun",
    },

    csgo_talon = {
        name = "Epic Talon",
        wep = "csgo_talon",
        category = "corps a corps",
        model = "models/weapons/horizon/w_csgo_talon.mdl",
        rareter = "Epic",
    },

    tfa_nmrih_bat = {
        name = "Batte de baseball",
        wep = "tfa_nmrih_bat",
        category = "corps a corps",
        model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl",
        rareter = "Mythique",
    },

    tfa_dbarrel = {
        name = "Double Barrel",
        wep = "tfa_dbarrel",
        category = "fusil a pompe",
        model = "models/weapons/w_double_barrel_shotgun.mdl",
        rareter = "Rare",
    },

    gsmartwatch = {
        name = "Montre connecté",
        wep = "gsmartwatch",
        category = "fun et autres",
        model = "models/sterling/gsmart_watch.mdl",
        rareter = "Epic",
    },

    climb_swep2 = {
        name = "Freerun ( Parkour )",
        wep = "climb_swep2",
        category = "fun et autres",
        model = "models/weapons/w_crowbar.mdl",
        rareter = "Commun",
    },

    lockpick = {
        name = "Crocheteur",
        wep = "lockpick",
        category = "fun et autres",
        model = "models/weapons/w_crowbar.mdl",
        rareter = "Commun",
    },

    bkeypads_cracker = {
        name = "Keypad Cracker 2.0 ",
        wep = "bkeypads_cracker",
        category = "fun et autres",
        model = "models/bkeypads/cracker.mdl",
        rareter = "Rare",
    },

    tfa_thompson = {
        name = "Tommy Gun",
        wep = "tfa_thompson",
        category = "arme lourde",
        model = "models/weapons/w_tommy_gun.mdl",
        rareter = "Mythique",
    },

    weapon_kidnapper = {
        name = "Assomeur",
        wep = "weapon_kidnapper",
        category = "fun et autres",
        model = "models/weapons/c_stunstick.mdl",
        rareter = "Rare",
    },

    tfa_sten = {
        name = "STEN",
        wep = "tfa_sten",
        category = "arme lourde",
        model = "models/weapons/w_sten.mdl",
        rareter = "Mythique",
    },

    tfa_nmrih_lpipe = {
        name = "Tuyeau en acier",
        wep = "tfa_nmrih_lpipe",
        category = "corps a corps",
        model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl",
        rareter = "Rare",
    },

    swep_pickpocket = {
        name = "PickPocket",
        wep = "swep_pickpocket",
        category = "fun et autres",
        model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl",
        rareter = "Commun",
    },

    keypad_cracker = {
        name = "Keypad Cracker",
        wep = "keypad_cracker",
        category = "fun et autres",
        model = "models/bkeypads/cracker.mdl",
        rareter = "Commun",
    },

    weapon_catgun = {
        name = "Cat Gun",
        wep = "weapon_catgun",
        category = "fun et autres",
        model = "models/weapons/w_catgun_ragdoll.mdl",
        rareter = "Commun",
    },

    vc_wrench = {
        name = "Kit de réparation",
        wep = "vc_wrench",
        category = "fun et autres",
        model = "models/vc-mod/v_wrench.mdl",
        rareter = "Commun",
    },

}