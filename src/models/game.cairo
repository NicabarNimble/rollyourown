use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
struct Game {
    #[key]
    game_id: u32,
    game_mode: GameMode,
    start_time: u64,
    max_players: usize,
    num_players: usize,
    max_turns: usize,
    is_finished: bool,
    creator: ContractAddress,
}

#[derive(Copy, Drop, Serde, PartialEq)]
enum GameMode {
    Test,
    Unlimited
}


#[generate_trait]
impl GameImpl of GameTrait {
    #[inline(always)]
    fn tick(self: Game) -> bool {
        let info = starknet::get_block_info().unbox();

        if info.block_timestamp < self.start_time {
            return false;
        }
        if self.is_finished {
            return false;
        }

        true
    }
}


use dojo::database::schema::{
    Enum, Member, Ty, Struct, SchemaIntrospection, serialize_member, serialize_member_type
};


impl GameModeIntrospectionImpl of SchemaIntrospection<GameMode> {
    #[inline(always)]
    fn size() -> usize {
        1
    }

    #[inline(always)]
    fn layout(ref layout: Array<u8>) {
        layout.append(8);
    }

    #[inline(always)]
    fn ty() -> Ty {
        Ty::Enum(
            Enum {
                name: 'GameMode',
                attrs: array![].span(),
                children: array![
                    ('Limited', serialize_member_type(@Ty::Tuple(array![].span()))),
                    ('Unlimited', serialize_member_type(@Ty::Tuple(array![].span()))),
                ]
                    .span()
            }
        )
    }
}

