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
  config = { extra = { dollar = 8 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.dollar } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if G.GAME.current_round.hands_used == 1 and G.GAME.round_resets.blind_states == 'Defeated' and not context.blueprint then --needs to trigger when blind is defeated with only 1 hand
      return {
        ease_dollars(card.ability.extra.dollar),
        message = localize{type='variable',key='a_chips',vars={"k_upgraded"}}
      }
  end
end
}
--[[
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


SMODS.Joker {
  key = 'Whip_of_Thorns',
  loc_txt = {
    name = 'Whip of Thorns',
    text = {
      "destroys a random",
      "{C:attention}scoring{} card"
    }
  },
  rarity = 2,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { dollar = 6} },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.dollar } }
  end,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.after and not context.blueprint then 
      --for i = 1, #context.scoring_hand do
      --context.other_card == context.scoring_hand[i]
      pseudorandom_element(context.full_hand,pseudoseed('random_destroyIDFK')):start_dissolve()
      ease_dollars(card.ability.extra.dollar)
    end
  end
--end
}

SMODS.Joker {
  key = 'Gambler',
  loc_txt = {
    name = 'Gambler',
    text = {
      "always is a {C:money}rental{}",
      "{C:green}#4#{} in {C:green}20{} for {C:money}#1#{} dollars"
    }
  },
  rarity = 2,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { jackpot_dollar = 50, min_dollar = 3, odds = 20 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.jackpot_dollar, card.ability.extra.min_dollar, card.ability.extra.odds, (G.GAME.probabilities.normal or 1) } }
  end,
  blueprint_compat = true,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({
      func = function()
        card:set_rental(true)
        return true
          end
    }))
  end,

  calculate = function(self, card, context)
    if context.end_of_round then
      G.E_MANAGER:add_event(Event({
        func = function()
        card:juice_up()
          if pseudorandom('Gambler') < G.GAME.probabilities.normal / card.ability.extra.odds then
            ease_dollars(card.ability.extra.jackpot_dollar)
          end
      return true
          end
    }))
end
end
}

SMODS.Joker {
  key = 'Sleigh_Bells',
  loc_txt = {
    name = 'Sleigh Bells',
    text = {
      "+{C:mult}#2#{} mult per opened {C:attention}booster pack{}",
      "{C:interactive} [currently:{} {C:mult}#1#{} {C:interactive}]{}"
    }
  },
  rarity = 1,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { mult = 0, mult_gain = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.open_booster then
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
      return{
        message = localize{key='a_mult', k_upgraded},
        card = card
      }
    end
    if context.joker_main and card.ability.extra.mult >= 0 then
      return{
        message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
        mult_mod = card.ability.extra.mult,
        colour = G.C.MULT,
        card = card
      }
    end
  end
}

SMODS.Joker {
  key = 'Sleigh_Bells',
  loc_txt = {
    name = 'Sleigh Bells',
    text = {
      "+{C:mult}#1#{} mult per {C:attention}enhanced{}",
      "playing card currently in deck",
      "{C:interactive} [currently:{} {C:mult}#1#{} {C:interactive}]{}"
    }
  },
  rarity = 1,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { mult = 3, anta_driver_tally = 0} },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.santa_driver_tally } }
  end,
  blueprint_compat = true,
  update = function (self, card, dt)
    if context.before then
      card.ability.santa_driver_tally = 0
      for k, v in pairs(G.playing_cards) do
          if v.config.center ~= G.P_CENTERS.c_base then card.ability.extra.stanta_driver_tally = card.ability.extra.santa_driver_tally+1 end
      end
  end
end,
  calculate = function(self, card, context)
  if context.joker_main and card.ability.extra.santa_driver_tally >= 0 then
    return{
      message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult*card.ability.extra.santa_driver_tally}},
      mult_mod = card.ability.extra.mult*card.ability.extra.santa_driver_tally,
      colour = G.C.MULT,
      card = card
    }
  end
end
}

SMODS.Joker {
  key = 'Roundabout',
  loc_txt = {
    name = 'Roundabout',
    text = {
      "{X:mult}x1.5{} mult if hand is not {C:attention}straight{}"
    }
  },
  rarity = 2,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { Xmult = 1.5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and not next(context.poker_hands['Straight']) then
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        Xmult_mod = card.ability.extra.Xmult
      }
    end
  end
}

SMODS.Joker {
  key = 'Freeway',
  loc_txt = {
    name = 'Freeway',
    text = {
      "{C:mult}+5{} mult for every",
      "conconsecutive {C:attention}straight{} played"
    }
  },
  rarity = 2,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { mult = 0, mult_gain = 5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.before and next(context.poker_hands['Straight']) then
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
      return{
        message = 'k_upgraded!',
    }
    end
    if context.before and not next(context.poker_hands['Straight']) then
      card.ability.extra.mult = 0
      return{
          message = 'reset!',
      }
    end
    if context.joker_main and card.ability.extra.mult >= 0 then
      return {
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
        mult_mod = card.ability.extra.mult,
        card = card
      }
    end
  end
}

--[[
--am not very familliar with copying cards, if anyone wants they can fix it :)

SMODS.Joker {
  key = 'Barbershop_Quartet',
  loc_txt = {
    name = 'Barbershop Quartet',
    text = {
      "{C:green}1 in 4{} chance",
      "add a copy of",
      "played {C:attention}4{} to deck"
    }
  },
  rarity = 3,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { odds = 4 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.other_card:get_id() == 4 and context.induvidual then
      if pseudorandom('hehe') < G.GAME.probabilities.normal / card.ability.extra.odds then
        --coppied from dna
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
        _card:add_to_deck()
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        table.insert(G.playing_cards, _card)
        G.hand:emplace(_card)
        _card.states.visible = nil
        G.E_MANAGER:add_event(Event({
          func = function()
              _card:start_materialize()
              return true
          end
        })) 
        return {
          message = localize('k_copied_ex'),
          colour = G.C.CHIPS,
          card = self,
          playing_cards_created = {true}
      }
    end
  end
end
}


SMODS.Joker {
  key = 'Dos',
  loc_txt = {
    name = 'Dos',
    text = {
      "{X:mult}X0.2{} mult per destroyed {C:attention}face card{}",
      "{C:inactive}currently{} {X:mult}#1#{} {C:inactive}mult{}"
    }
  },
  rarity = 2,
  cost = 3,
  atlas = 'joker',
  pos = { x = 0, y = 0 },
  config = { extra = { Xmult = 0, Xmult_gain = 0.2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if not context.blueprint then
      for k, val in ipairs(context.removed) do
        if val:is_face() then  --only face cards give +0.2 xmult (need to change it to all cards)
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
          return{
            G.E_MANAGER:add_event(Event({
              func = function()
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}});
                return true
              end
            }))
          }
        end
      end
    end
    if context.joker_main then
      return{
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        Xmult_mod = card.ability.extra.Xmult,
        card = card
      }
    end
  end
}
--]]


--[[
SMODS.Seal {
  name = "modded-Seal",
  key = "blu",
  badge_colour = HEX("1d4fd7"),
config = {  },
  loc_txt = {
      -- Badge name (displayed on card description when seal is applied)
      label = 'Blu Seal',
      -- Tooltip description
      description = {
          name = 'Blu Seal',
          text = {
              '{C:mult}+#1#{} Mult',
              '{C:chips}+#2#{} Chips',
              '{C:money}$#3#{}',
              '{X:mult,C:white}X#4#{} Mult',
          }
      },
  },
  loc_vars = function(self, info_queue)
      return { vars = { } }
  end,
  atlas = "seal_atlas",
  pos = {x=0, y=0},
  calculate = function (self, context, card)
    --[[
    for i = 1, #G.play.cards do
			local CARD = G.play.cards[i]

			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					CARD:flip()
					CARD:set_ability(G.P_CENTERS.c_base, true, nil)
					CARD:set_edition(nil, true)
					CARD:set_seal(nil, true)
					play_sound("tarot2", percent)
					CARD:juice_up(0.3, 0.3)
					return true
				end,
			}))
		--end
  end


G.E_MANAGER:add_event(Event({
  trigger = "after",
  func = function()
    if context.individual --[[and context.cardarea == G.play then
    self:set_seal()
    card:juice_up()
  end
    return true
  end
}))
end
}
--]]




----------
---deck---
----------





----------------
---consumable---
----------------






----------
---seal---
----------




--------------
---vouchers---
--------------
--function Card:calculate_joker(context)

--G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1

--base voucher
--[[
SMODS.Voucher {
 key = 'voucher_1',
 loc_txt = {
   name = 'voucher_1',
   text = {
     "voucher 1"
   }
 },
config = {},
pos = { x = 0, y = 0 },
atlas = 'joker',
cost = 10,
unlocked = true,
discovered = true,
}



--branching
SMODS.Voucher {
  key = 'voucher_2',
  loc_txt = {
    name = 'voucher_2',
    text = {
      "voucher 2"
    }
  },
config = {},
pos = { x = 0, y = 0 },
atlas = 'joker',
cost = 10,
unlocked = true,
discovered = true,
requires = 'v_idea_voucher_1',
in_pool = function(self)
  if G.GAME.used_vouchers['v_idea_voucher_3'] then
      return false
  end
  return true
end,
}

SMODS.Voucher {
  key = 'voucher_3',
  loc_txt = {
    name = 'voucher_3',
    text = {
      "voucher 3"
    }
  },
config = {},
pos = { x = 0, y = 0 },
atlas = 'joker',
cost = 10,
unlocked = true,
discovered = true,
requires = 'v_idea_voucher_1',
in_pool = function(self)
  if G.GAME.used_vouchers['v_idea_voucher_2'] then
      return false
  end
  return true
end,

}

--]]



SMODS.Voucher {
  key = 'The_Apple',
  loc_txt = {
    name = 'The Apple',
    text = {
      "voucher 1",
      "testing really quick"
    }
  },
 pos = { x = 0, y = 0 },
 atlas = 'joker',
 cost = 10,
 unlocked = true,
 discovered = true,
 config = { extra = { ante = 1, hand_size = 1} },
 loc_vars = function(self, info_queue, card)
  return { vars = { card.ability.extra.ante, card.ability.extra.hand_size } }
end,
redeem = function (self, card)
  G.hand:change_size(card.ability.extra.hand_size) --adds size
  ease_ante(card.ability.extra.ante)
 end
}

 --branching
 SMODS.Voucher {
   key = 'The_Tree',
   loc_txt = {
     name = 'The Tree',
     text = {
       "voucher 2"
     }
   },
 pos = { x = 0, y = 0 },
 atlas = 'joker',
 cost = 10,
 unlocked = true,
 discovered = true,
 --requires = 'v_idea_The_Apple',
 config = { extra = { ante = 1, hands = 1} },
 loc_vars = function(self, info_queue, card)
  return { vars = { card.ability.extra.ante, card.ability.extra.hands } }
end,

 in_pool = function(self)
   if G.GAME.used_vouchers['v_idea_The_Snake'] then
       return false
   end
   return true
 end,

 redeem = function (self, card)
  ease_hands_played(card.ability.extra.hands)
  ease_ante(card.ability.extra.ante)
end--]]
 }

 SMODS.Voucher {
   key = 'The_Snake',
   loc_txt = {
     name = 'The Snake',
     text = {
       "voucher 3"
     }
   },
 pos = { x = 0, y = 0 },
 atlas = 'joker',
 cost = 10,
 unlocked = true,
 discovered = true,
 --requires = 'v_idea_The_Apple',
 config = { extra = { ante = 1, discards = 2} },
 loc_vars = function(self, info_queue, card)
  return { vars = { card.ability.extra.ante, card.ability.extra.discards } }
end,

 in_pool = function(self)
   if G.GAME.used_vouchers['v_idea_The_Tree'] then
       return false
   end
   return true
 end,

 redeem = function (self, card)
  ease_discard(card.ability.extra.discards)
  ease_ante(card.ability.extra.ante)
 end--]]
}

--]]









