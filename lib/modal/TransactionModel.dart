class TransactionModel {
  TransactionModel({
    required this.transactionId,
  });
  late final String transactionId;

  TransactionModel.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transactionId'] = transactionId;
    return _data;
  }
}
