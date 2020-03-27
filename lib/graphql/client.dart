import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/graphql/offers_api_token.dart';

final HttpLink _httpLink = HttpLink(
  uri: 'https://staging-nu-needful-things.nubank.com.br/query',
);

final AuthLink _authLink = AuthLink(
  getToken: () async => 'Bearer $API_BEARER_TOKEN',
);

final Link link = _authLink.concat(_httpLink);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: InMemoryCache(),
    link: link,
  ),
);
