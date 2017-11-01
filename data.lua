return {
    rooms = {
        alley = {
            sprite = "sprites/bg_alley.jpg",
            objects = {
                door = {
                    sprite = "sprites/door.png",
                    x = 146,
                    y = 166,
                    state = "locked",
                    locked = {
                        move = {
                            text = "it appears to be locked"
                        },
                        inspect = {
                            text = "looks like a door, its locked"
                        },
                        use = {
                            item = "key",
                            state = "unlocked",
                            worked = "you used the key on the door",
                            text = "doesn't work here"
                        }
                    },
                    unlocked = {
                        move = { 
                            text = "bar"
                        },
                        inspect = {
                            text = "looks like a door, I unlocked it"
                        }
                    }
                },
                person = {
                    sprite = "sprites/person.png",
                    x = 422,
                    y = 285,
                    state = "talk1",
                    default = {
                        inspect = {
                            text = "looks like a person"
                        },
                    },
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
                        inspect = {
                            text = "just a sign now"
                        }
                    }
                    
                }
            }
        },
        bar = { 
            sprite = "sprites/bg_bar.png"
        }
    }
}