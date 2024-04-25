
class PersonVo {
  //필드
  int personId;
  String name;
  String hp;
  String company;

  //생성자
  PersonVo({
    required this.personId,
    required this.name,
    required this.hp,
    required this.company,
  });

  //map(=json)--> personVo형식으로 변환
  factory PersonVo.fromJson(Map<String, dynamic> apiData) {
    return PersonVo(
      personId: apiData['personId'],
      name: apiData['name'],
      hp: apiData['hp'],
      company: apiData['company'],
    );
  }

  //현재의 PersonVo를 Map형식으로 내보내줌
  Map<String, dynamic> toJson() {
    return {
      'personId': personId,
      'name': name,
      'hp': hp,
      'company': company,
    };
  }
}
