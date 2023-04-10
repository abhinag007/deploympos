/*
class AllTransactionsModel {
  AllTransactionsModel({
    required this.transactions,
    required this.totalTransaction,
    required this.walletBalance,
  });
  late final List<Transactions> transactions;
  late final int totalTransaction;
  late final int walletBalance;

  AllTransactionsModel.fromJson(Map<String, dynamic> json) {
    transactions = List.from(json['transactions'])
        .map((e) => Transactions.fromJson(e))
        .toList();
    totalTransaction = json['totalTransaction'];
    walletBalance = json['walletBalance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transactions'] = transactions.map((e) => e.toJson()).toList();
    _data['totalTransaction'] = totalTransaction;
    _data['walletBalance'] = walletBalance;
    return _data;
  }
}

class Transactions {
  Transactions({
    required this.id,
    required this.uid,
    required this.userId,
    required this.customer,
    required this.amount,
    required this.tax,
    required this.currency,
    required this.status,
    required this.createdAt,
  });
  late final String id;
  late final String uid;
  late final String userId;
  late final Customer customer;
  late final int? amount;
  late final int tax;
  late final String? currency;
  late final String status;
  late final String createdAt;

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    userId = json['userId'];
    customer = Customer.fromJson(json['customer']);
    amount = json['amount'];
    tax = json['tax'];
    currency = json['currency'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uid'] = uid;
    _data['userId'] = userId;
    _data['customer'] = customer.toJson();
    _data['amount'] = amount;
    _data['tax'] = tax;
    _data['currency'] = currency;
    _data['status'] = status;
    _data['createdAt'] = createdAt;
    return _data;
  }
}

class Customer {
  Customer({
    required this.cardNo,
    required this.bankName,
  });
  late final String cardNo;
  late final String bankName;

  Customer.fromJson(Map<String, dynamic> json) {
    cardNo = json['cardNo'];
    bankName = json['bankName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cardNo'] = cardNo;
    _data['bankName'] = bankName;
    return _data;
  }
}
*/

class AllTransactionsModel {
  List<Transactions>? transactions;
  int? totalTransaction;
  int? walletBalance;

  AllTransactionsModel(
      {this.transactions, this.totalTransaction, this.walletBalance});

  AllTransactionsModel.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    totalTransaction = json['totalTransaction'];
    walletBalance = json['walletBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    data['totalTransaction'] = this.totalTransaction;
    data['walletBalance'] = this.walletBalance;
    return data;
  }
}

class Transactions {
  String? id;
  String? uid;
  String? userId;
  Customer? customer;
  int? amount;
  int? tax;
  String? currency;
  String? status;
  String? createdAt;

  Transactions(
      {this.id,
      this.uid,
      this.userId,
      this.customer,
      this.amount,
      this.tax,
      this.currency,
      this.status,
      this.createdAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    userId = json['userId'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    amount = json['amount'].toInt();
    tax = json['tax'];
    currency = json['currency'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['userId'] = this.userId;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['amount'] = this.amount;
    data['tax'] = this.tax;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Customer {
  String? cardNo;
  String? bankName;

  Customer({this.cardNo, this.bankName});

  Customer.fromJson(Map<String, dynamic> json) {
    cardNo = json['cardNo'];
    bankName = json['bankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardNo'] = this.cardNo;
    data['bankName'] = this.bankName;
    return data;
  }
}
