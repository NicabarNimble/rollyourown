use starknet::ContractAddress;
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

#[starknet::interface]
trait ITrade<TContractState> {
    fn buy(
        self: @TContractState, game_id: u32, location_id: felt252, drug_id: felt252, quantity: usize
    );

    fn sell(
        self: @TContractState, game_id: u32, location_id: felt252, drug_id: felt252, quantity: usize
    );
}


#[starknet::contract]
mod trade {
    use starknet::ContractAddress;
    use starknet::get_caller_address;
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use rollyourown::models::drug::Drug;
    use rollyourown::models::player::{Player, PlayerTrait};
    use rollyourown::models::location::Location;
    use rollyourown::models::game::{Game, GameTrait};
    use rollyourown::models::risks::{Risks, RisksTrait};
    use rollyourown::models::market::{Market, MarketTrait};

    use super::ITrade;

    #[storage]
    struct Storage {
        world_dispatcher: ContractAddress,
    }

    #[starknet::interface]
    trait ISystem<TContractState> {
        fn world(self: @TContractState) -> IWorldDispatcher;
    }

    impl ISystemImpl of ISystem<ContractState> {
        fn world(self: @ContractState) -> IWorldDispatcher {
            IWorldDispatcher { contract_address: self.world_dispatcher.read() }
        }
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Bought: Bought,
        Sold: Sold
    }

    #[derive(Drop, starknet::Event)]
    struct Bought {
        game_id: u32,
        player_id: ContractAddress,
        drug_id: felt252,
        quantity: usize,
        cost: u128
    }

    #[derive(Drop, starknet::Event)]
    struct Sold {
        game_id: u32,
        player_id: ContractAddress,
        drug_id: felt252,
        quantity: usize,
        payout: u128
    }


    #[external(v0)]
    impl GameImpl of ITrade<ContractState> {
        // 1. Verify the caller owns the player.
        // 2. Get current price for location for quantity.
        // 3. Ensure user can afford it.
        // 4. Perform the trade.
        // 5. Update the location's inventory.
        // 6. Update the player's inventory.
        fn buy(
            self: @ContractState,
            game_id: u32,
            location_id: felt252,
            drug_id: felt252,
            quantity: usize
        ) {
            let player_id = get_caller_address();

            let game = get!(self.world(), game_id, (Game));
            assert(game.tick(), 'cannot progress');

            let mut player = get!(self.world(), (game_id, player_id).into(), Player);
            assert(player.location_id == location_id, 'player is not at location');
            assert(player.can_continue(), 'player cannot trade');
            assert(player.drug_count + quantity <= player.bag_limit, 'no bag space');

            let mut market = get!(self.world(), (game_id, location_id, drug_id).into(), Market);

            let cost = market.buy(quantity);
            assert(cost < player.cash, 'not enough cash');

            let mut drug = get!(self.world(), (game_id, player_id, drug_id).into(), Drug);

            // update market
            market.cash += cost;
            market.quantity -= quantity;

            // update player
            player.cash -= cost;
            player.drug_count += quantity;

            // update drug
            drug.game_id = game_id;
            drug.player_id = player_id;
            drug.drug_id = drug_id;
            drug.quantity += quantity;

            set!(self.world(), (market, player, drug));
            emit!(self.world(), Bought { game_id, player_id, drug_id, quantity, cost });
        }


        fn sell(
            self: @ContractState,
            game_id: u32,
            location_id: felt252,
            drug_id: felt252,
            quantity: usize
        ) {
            let player_id = get_caller_address();

            let game = get!(self.world(), game_id, Game);
            assert(game.tick(), 'cannot progress');

            let mut player = get!(self.world(), (game_id, player_id).into(), Player);
            assert(player.location_id == location_id, 'player is not at location');

            let mut drug = get!(self.world(), (game_id, player_id, drug_id).into(), Drug);
            assert(drug.quantity >= quantity, 'not enough drugs to sell');

            let mut market = get!(self.world(), (game_id, location_id, drug_id).into(), Market);
            let payout = market.sell(quantity);

            // update market
            market.quantity += quantity;
            market.cash -= payout;

            // update player
            player.cash += payout;
            player.drug_count -= quantity;

            // update drug
            drug.quantity -= quantity;

            set!(self.world(), (market, player, drug));
            emit!(self.world(), Sold { game_id, player_id, drug_id, quantity, payout });
        }
    }
}

