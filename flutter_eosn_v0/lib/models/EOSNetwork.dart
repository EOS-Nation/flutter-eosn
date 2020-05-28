class EOSNetwork {
  final String name;
  final String nodeURL;
  final String nodeVersion;
  EOSNetwork(this.name, this.nodeURL, this.nodeVersion);
}

final Map<String, EOSNetwork> eosNetworks = {
  'jungle2': EOSNetwork('Jungle2', 'https://jungle2.cryptolions.io', 'v2'),
  'jungle3': EOSNetwork('Jungle3', 'https://jungle2.cryptolions.io', 'v2'),
  'mainnet': EOSNetwork('Mainet', 'https://jungle2.cryptolions.io', 'v2'),
};
