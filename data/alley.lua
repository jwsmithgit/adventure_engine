return {
    sprite = "sprites/bg_alley.jpg",
    objects = {
        door = {
            sprite = "sprites/door.png",
            x = 146,
            y = 166,
            state = "locked",
            locked = {
                move = "it appears to be locked",
                inspect =  "looks like a door, its locked",
                use = {
                    item = "key",
                    state = "unlocked",
                    text = "you used the key on the door"
                }
            },
            unlocked = {
                move = "bar",
                inspect = "looks like a door, I unlocked it"
            }
        },
        person = {
            sprite = "sprites/person.png",
            x = 422,
            y = 285,

            inspect = "looks like a person",
            state = "talk1",
            talk1 = { 
                talk = {
                    text = "hey there, i am a person",
                    state = "talk2"
                }
            },
            talk2 = { 
                talk = {
                    text = "why are you still talking to me" 
                }
            },
        },
        sign = {
            sprite = "sprites/sign.png",
            x = 301,
            y = 222,
            state = "key",
            key = {
                inspect = "looks like a sign, hey, there's a key on the back",
                take = {
                    text = "you obtained the key",
                    item = "key",
                    state = "no_key"
                }
            },
            no_key = {
                inspect = "just a sign now"
            }
            
        }
    },
    sounds = {
        space = {
            sound = "/sounds/116781__tobbarebble__space-investigation-atmosphere.wav",
            loop = true
        },
        spaceship = {
            sound = "/sounds/397948__inspectorj__spaceship-fly-by-a.wav",
            delay = 2,
            loop_delay = 2
        }
        --[[computer = {
            sound = "/sounds/85193__jaraxe__weird-scifi-computer-sound3.wav",
            delay = 5,
            loop = true,
        }
        ]]
    },
    scripts = {
        enter = {
            big_script = {
                requisites = {
                    {object = "person", varaible = "state", value = "talk2"}, --check single value
                    {object = "player", variable = "inventory", value = "key"} -- check value in list
                },
                {object = "person", action = "talk", options = {text = "hello"}, "wait"}, -- person says something
                {object = "person", action = "move", options = {destx = 100, desty = 200}, wait = true}, -- person moves
                {object = "person", action = "hide", wait = true},
                {object = "person", action = "show", wait = true},
                {object = "person", action = "destroy", wait = true},
                {object = "person", action = "create", wait = true},
                
            },
            small_script = {{object = "person", action = "talk", options = {text = "hello"}, wait = true}} -- person says something}
        },
        call = {{object = "person", action = "talk", options = {text = "hello"}, wait = true}}
    }
}
