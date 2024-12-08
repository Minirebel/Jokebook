--- STEAMODDED HEADER
--- MOD_NAME: Jokebook: the Balatro community mod.
--- MOD_ID: The_idea's
--- MOD_AUTHOR: [Minirebel & the balatro comunity]
--- MOD_DESCRIPTION: Give me ANY idea and I’ll make a .... out of it
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- Prefix: idea
----------------------------------------------
------------MOD CODE -------------------------

-----------
---atlas---
-----------

SMODS.Atlas {
    key = "joker",
    path = "Fake_Stone.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "seal",
    path = "Fake_Stone.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Deck",
    path = "Fake_Stone.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "consumable",
    path = "Fake_Stone.png",
    px = 71,
    py = 95
}

-----------
---joker---
-----------

SMODS.Joker {
    key = 'False_Promises',
    loc_txt = {
      name = 'False Promises',
      text = {
        "{C:chips}Common{} Jokers give",
        "{C:white, X:mult}X#1#{} Mult"
      }
    },
    rarity = 2,
    cost = 3,
    atlas = 'joker',
    pos = { x = 0, y = 0 },
    config = { extra = { Xmult = 1.1 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult } }
    end,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.other_joker then
          --common
          if context.other_joker.config.center.rarity == 1 and card ~= context.other_joker then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.other_joker:juice_up(0.5, 0.5)
                    return true
                end
            })) 
            return {
                message = localize{type='variable',key='a_chips',vars={card.ability.extra.Xmult}},
                Xmult_mod = card.ability.extra.Xmult
            }
        end
    end
end
}

SMODS.Joker {
    key = '3D',
    loc_txt = {
      name = '3D',
      text = {
        "{C:chips}+#1#{} Jokers give",
        "{C:white, X:mult}X#1#{} Mult"
      }
    },
    rarity = 2,
    cost = 3,
    atlas = 'joker',
    pos = { x = 0, y = 0 },
    config = { extra = { chips = 15 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chips } }
    end,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
          if context.other_card:get_id() == 11 or context.other_card:get_id() == 8 then
              return {
                  chips = card.ability.extra.chips,
                  card = card
              }
            end
        end
      end
}

SMODS.Joker {
    key = 'Gecko',
    loc_txt = {
      name = 'Gecko',
      text = {
        "Each played {C:attention}6 {}&{C:attention} 9{}",
        "gives {C:mult}+4{} mult and",
        "{C:chips}+20{} chips when scored",
        "currently #1#"
      }
    },
    config = { extra = { mult = 0 } },
    rarity = 1,
    atlas = 'joker',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play and not context.blueprint then
        if context.other_card:get_id() == 6 or context.other_card:get_id() == 8 then
        card.ability.extra.mult = card.ability.extra.mult + 1
        end
    end
      if context.joker_main then
        return {
          mult_mod = card.ability.extra.mult,
          message = localize{type='variable',key='a_chips',vars={card.ability.extra.mult}},
          card = card
        }
      end
    end
}

SMODS.Joker {
  key = 'how_it_crumbles',
  loc_txt = {
    name = 'How it crumbles',
    text = {
      "always score 10%",
      "of blind requirement"
    }
  },
  rarity = 2,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { } },
  loc_vars = function(self, info_queue, card)
    return { vars = { } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
    return {
      message = localize{type='variable',key='a_chips',vars={G.GAME.blind.chips*0.1}},
      chips_mod = G.GAME.blind.chips*0.1
    }
  end
end
}

--[[
SMODS.Joker {
  key = 'Fox',
  loc_txt = {
    name = 'Fox',
    text = {
      "always score 10%",
      "of blind requirement",
      "#1#"
    }
  },
  rarity = 2,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { mult = 0 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if G.GAME.current_round.hands_played == 1 and G.GAME.round_resets.blind_states == 'Defeated' and not context.blueprint then --needs to trigger when blind is defeated with only 1 hand
      return {
        card.ability.extra.mult + 7,
        message = localize{type='variable',key='a_chips',vars={"k_upgraded"}}
      }
  end
  if context.joker_main then
    return {
      mult_mod = card.ability.extra.mult,
      message = localize{type='variable',key='a_chips',vars={card.ability.extra.mult}},
      card = card
    }
  end
end
}

--tf is wrong with him?!?!?
SMODS.Joker {
  key = 'Jackpot',
  loc_txt = {
    name = 'Jackpot',
    text = {
      "always score 10%",
      "of blind requirement",
      "#1#"
    }
  },
  rarity = 2,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { money = 7, odds = 7 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
  if context.induvidual and context.cardarea == G.play then
    if context.other_card:get_id() == 7 then
      if pseudorandom('Jackpot') < G.GAME.probabilities.normal / card.ability.extra.odds then
        ease_dollars(card.ability.extra.money)
      end
    end
  end
end
}
"When a 7 is played, 1/7 chance for +$7 (maybe less)"
]]
----------
---deck---
----------





----------------
---consumable---
----------------






----------
---seal---
----------




