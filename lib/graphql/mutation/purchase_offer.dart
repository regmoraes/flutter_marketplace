const OFFER_ID = "offerId";

const purchaseOffer = r'''
mutation PurchaseOffer($offerId: ID!) {
    purchase(offerId: $offerId) {
        success
        errorMessage
        customer {
            balance
        }
    }
}
''';
