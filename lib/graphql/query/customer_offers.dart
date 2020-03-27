String queryCustomer = r'''
query CustomerOffers { 
  viewer {
    id
    name
    balance
    offers {
      id
      price
      product {
        id
        name
        description
        image
      }
    }
  }
}
''';
