import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marketplace/graphql/offers_repository.dart';
import 'package:mockito/mockito.dart';

class MockGraphQLClient extends Mock implements GraphQLClient {}

void main() {
  GraphQLClient graphQLClientClientMock;
  OffersRepository subject;

  group('Given a OffersRepository', () {
    setUp(() {
      graphQLClientClientMock = MockGraphQLClient();
      subject = OffersRepository(graphQLClientClientMock);
    });

    test('When calling getOffers Should execute CustomerOffers query',
        () async {
      await subject.getOffers();
      final QueryOptions queryOptionsArgument =
          verify(graphQLClientClientMock.query(captureAny)).captured.single;
      expect(queryOptionsArgument.operationName, 'CustomerOffers');
    });
  });
}
