import 'package:graphql/client.dart';
import 'package:marketplace/domain/purchase.dart';

import 'mutation/purchase_offer.dart' as mutations;
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

  Future<QueryResult> purchaseOffer(String offerId) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.purchaseOffer),
      variables: <String, String>{
        Purchase.OFFER_ID: offerId,
      },
    );

    return await _client.mutate(_options);
  }
}
