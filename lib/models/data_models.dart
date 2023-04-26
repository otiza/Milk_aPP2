import 'dart:convert';

class Tournee {
  int? id;
  int? number;
  ChauffeurId? chauffeurId;
  ChauffeurId? agentId;
  CamionId? camionId;
  List<TrajetIds>? trajetIds;

  Tournee(
      {this.number,
      this.chauffeurId,
      this.agentId,
      this.camionId,
      this.trajetIds,this.id});

  Tournee.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    id= json['id'] ;
    chauffeurId = json['chauffeur_id'] != null
        ? ChauffeurId.fromJson(json['chauffeur_id'])
        : null;
    agentId = json['agent_id'] != null
        ? ChauffeurId.fromJson(json['agent_id'])
        : null;
    camionId = json['camion_id'] != null
        ? CamionId.fromJson(json['camion_id'])
        : null;
    if (json['trajet_ids'] != null) {
      trajetIds = <TrajetIds>[];
      json['trajet_ids'].forEach((v) {
        trajetIds!.add(TrajetIds.fromJson(v));
      });
    }
  }

 // String get id => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = number;
    if (chauffeurId != null) {
      data['chauffeur_id'] = chauffeurId!.toJson();
    }
    if (agentId != null) {
      data['agent_id'] = agentId!.toJson();
    }
    if (camionId != null) {
      data['camion_id'] = camionId!.toJson();
    }
    if (trajetIds != null) {
      data['trajet_ids'] = trajetIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChauffeurId {
  String? name;

  ChauffeurId({this.name});

  ChauffeurId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    return data;
  }
}

class CamionId {
  String? license;

  CamionId({this.license});

  CamionId.fromJson(Map<String, dynamic> json) {
    license = json['license'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['license'] = license;
    return data;
  }
}

class TrajetIds {
  int? id;
  String? name;
  double? latitude;
  double? longitude;
  ProducerId? producerId;
  List<BacalaitIds>? bacalaitIds;

  TrajetIds(
      {this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.producerId,
      this.bacalaitIds});

  TrajetIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    producerId = json['producer_id'] != null
        ? ProducerId.fromJson(json['producer_id'])
        : null;
    if (json['bacalait_ids'] != null) {
      bacalaitIds = <BacalaitIds>[];
      json['bacalait_ids'].forEach((v) {
        bacalaitIds!.add(BacalaitIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (producerId != null) {
      data['producer_id'] = producerId!.toJson();
    }
    if (bacalaitIds != null) {
      data['bacalait_ids'] = bacalaitIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProducerId {
  int? id;
  String? name;
  String? phone;

  ProducerId({this.id,this.name, this.phone});

  ProducerId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['phone'] = phone;
    data['id'] = id;
    return data;
  }
}

class BacalaitIds {
  int? id;
  String? reference;
  double? capacite;

  BacalaitIds({this.id, this.reference, this.capacite});

  BacalaitIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    capacite = json['capacite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['reference'] = reference;
    data['capacite'] = capacite;
    return data;
  }
}






//CENTRES RESPONSE
class Resposne {
  List<Result>? result;
  Resposne(
      {
      this.result});
  Resposne.fromJson(Map<String, dynamic> json) {
 
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? name;

  Result({this.id, this.name});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}



class BacLaitResponse {
  List<Baclait>? result;

  BacLaitResponse({this.result});

  BacLaitResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Baclait>[];
      json['result'].forEach((v) {
        result!.add(new Baclait.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Baclait {
  String? reference;
  int? id;

  Baclait({this.reference, this.id});

  Baclait.fromJson(Map<String, dynamic> json) {
    reference = json['reference'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference'] = this.reference;
    data['id'] = this.id;
    return data;
  }
}