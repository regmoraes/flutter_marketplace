import 'package:graphql/client.dart';

import 'query/customer_offers.dart' as queries;

class OffersRepository {
  final GraphQLClient _client;

  OffersRepository(this._client) : assert(_client != null);

  Future<QueryResult> getOffers() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.queryCustomer),
      fetchResults: true,
    );

    return await _client.query(_options);
  }
}
