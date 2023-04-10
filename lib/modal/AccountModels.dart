class AccountModels {
  AccountModels({
    required this.id,
    required this.uid,
    required this.pictureUrl,
    required this.email,
    required this.passwordChangeRequired,
    required this.address,
    required this.tours,
    required this.mobileSync,
    required this.mobileNumber,
    required this.settings,
    required this.createdAt,
    required this.isAdmin,
    required this.receiptEmail,
    required this.tin,
    required this.businessName,
    required this.businessType,
    required this.receipt,
    required this.bank,
  });
  late final String id;
  late final int uid;
  late final String pictureUrl;
  late final String email;
  late final bool passwordChangeRequired;
  late final String address;
  late final Tours tours;
  late final bool mobileSync;
  late final String mobileNumber;
  late final Settings settings;
  late final String createdAt;
  late final bool isAdmin;
  late final bool receiptEmail;
  late final String tin;
  late final String businessName;
  late final String businessType;
  late final Receipt receipt;
  late final Bank bank;

  AccountModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    pictureUrl = json['pictureUrl'];
    email = json['email'];
    passwordChangeRequired = json['passwordChangeRequired'];
    address = json['address'];
    tours = Tours.fromJson(json['tours']);
    mobileSync = json['mobileSync'];
    mobileNumber = json['mobileNumber'];
    settings = Settings.fromJson(json['settings']);
    createdAt = json['createdAt'];
    isAdmin = json['isAdmin'];
    receiptEmail = json['receiptEmail'];
    tin = json['tin'];
    businessName = json['businessName'];
    businessType = json['businessType'];
    receipt = Receipt.fromJson(json['receipt']);
    bank = Bank.fromJson(json['bank']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uid'] = uid;
    _data['pictureUrl'] = pictureUrl;
    _data['email'] = email;
    _data['passwordChangeRequired'] = passwordChangeRequired;
    _data['address'] = address;
    _data['tours'] = tours.toJson();
    _data['mobileSync'] = mobileSync;
    _data['mobileNumber'] = mobileNumber;
    _data['settings'] = settings.toJson();
    _data['createdAt'] = createdAt;
    _data['isAdmin'] = isAdmin;
    _data['receiptEmail'] = receiptEmail;
    _data['tin'] = tin;
    _data['businessName'] = businessName;
    _data['businessType'] = businessType;
    _data['receipt'] = receipt.toJson();
    _data['bank'] = bank.toJson();
    return _data;
  }
}

class Tours {
  Tours({
    required this.users,
    required this.profile,
    required this.popup,
  });
  late final bool users;
  late final bool profile;
  late final bool popup;

  Tours.fromJson(Map<String, dynamic> json) {
    users = json['users'];
    profile = json['profile'];
    popup = json['popup'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['users'] = users;
    _data['profile'] = profile;
    _data['popup'] = popup;
    return _data;
  }
}

class Settings {
  Settings({
    required this.timezone,
    required this.timeFormat,
    required this.dateFormat,
    required this.locale,
    required this.currency,
    required this.country,
  });
  late final String timezone;
  late final String timeFormat;
  late final String dateFormat;
  late final String locale;
  late final String currency;
  late final String country;

  Settings.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    timeFormat = json['timeFormat'];
    dateFormat = json['dateFormat'];
    locale = json['locale'];
    currency = json['currency'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timezone'] = timezone;
    _data['timeFormat'] = timeFormat;
    _data['dateFormat'] = dateFormat;
    _data['locale'] = locale;
    _data['currency'] = currency;
    _data['country'] = country;
    return _data;
  }
}

class Receipt {
  Receipt({
    required this.email,
    required this.sms,
  });
  late final bool email;
  late final bool sms;

  Receipt.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    sms = json['sms'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['sms'] = sms;
    return _data;
  }
}

class Bank {
  Bank({
    required this.accountNo,
    required this.bankName,
  });
  late final String accountNo;
  late final String bankName;

  Bank.fromJson(Map<String, dynamic> json) {
    accountNo = json['accountNo'];
    bankName = json['bankName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accountNo'] = accountNo;
    _data['bankName'] = bankName;
    return _data;
  }
}
