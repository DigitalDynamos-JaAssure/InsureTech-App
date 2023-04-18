class PolicyDetails {
  String? message;
  List<Policies>? policies;

  PolicyDetails({this.message, this.policies});

  PolicyDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['policies'] != null) {
      policies = <Policies>[];
      json['policies'].forEach((v) {
        policies!.add(new Policies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.policies != null) {
      data['policies'] = this.policies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Policies {
  CarDetails? carDetails;
  Premium? premium;
  String? sId;
  String? policyNumber;
  String? policyType;
  String? startDate;
  String? endDate;
  String? user;
  String? status;
  int? iV;

  Policies(
      {this.carDetails,
      this.premium,
      this.sId,
      this.policyNumber,
      this.policyType,
      this.startDate,
      this.endDate,
      this.user,
      this.status,
      this.iV});

  Policies.fromJson(Map<String, dynamic> json) {
    carDetails = json['carDetails'] != null
        ? new CarDetails.fromJson(json['carDetails'])
        : null;
    premium =
        json['premium'] != null ? new Premium.fromJson(json['premium']) : null;
    sId = json['_id'];
    policyNumber = json['policyNumber'];
    policyType = json['policyType'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    user = json['user'];
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carDetails != null) {
      data['carDetails'] = this.carDetails!.toJson();
    }
    if (this.premium != null) {
      data['premium'] = this.premium!.toJson();
    }
    data['_id'] = this.sId;
    data['policyNumber'] = this.policyNumber;
    data['policyType'] = this.policyType;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['user'] = this.user;
    data['status'] = this.status;
    data['__v'] = this.iV;
    return data;
  }
}

class CarDetails {
  String? carImg;
  String? model;
  String? year;
  String? chesisNo;
  List<String>? coverage;
  String? engineNo;

  CarDetails(
      {this.carImg,
      this.model,
      this.year,
      this.chesisNo,
      this.coverage,
      this.engineNo});

  CarDetails.fromJson(Map<String, dynamic> json) {
    carImg = json['carImg'];
    model = json['model'];
    year = json['year'];
    chesisNo = json['chesis_no'];
    coverage = json['coverage'].cast<String>();
    engineNo = json['Engine_No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carImg'] = this.carImg;
    data['model'] = this.model;
    data['year'] = this.year;
    data['chesis_no'] = this.chesisNo;
    data['coverage'] = this.coverage;
    data['Engine_No'] = this.engineNo;
    return data;
  }
}

class Premium {
  int? amount;

  Premium({this.amount});

  Premium.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    return data;
  }
}
