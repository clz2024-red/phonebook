import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'personVo.dart';

//레이아웃 클래스
class EditForm extends StatelessWidget {
  const EditForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("수정폼")),
      body: Container(
        padding: EdgeInsets.all(15),
        color: Color(0xffd6d6d6),
        child: _EditForm()
      ),

    );
  }
}

//등록
class _EditForm extends StatefulWidget {
  const _EditForm({super.key});

  @override
  State<_EditForm> createState() => _EditFormState();
}

//할일
class _EditFormState extends State<_EditForm> {
  //선택한 사용자 번호
  late int personId;

  /*input박스의 변화를 체크하는 변수 생성*/
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  //초기화(1번실행됨)
  @override
  void initState() {
    super.initState();
  }

  //화면에 그리기
  @override
  Widget build(BuildContext context) {
    // ModalRoute를 통해 현재 페이지에 전달된 arguments를 가져옵니다.
    late final args = ModalRoute.of(context)!.settings.arguments as Map;
    // 'personId' 키를 사용하여 값을 추출합니다.
    personId = args['personId'];

    //personId의 데이터를 서버로 부터 가져오기 함수 실행
    getPersonByNo(personId);

    return Container(
      color: Color(0xffffffff),
      child: Form(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '이름',
                  hintText: '이름을 입력해 주세요',
                  border: OutlineInputBorder()
                )
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: TextFormField(
                controller: _hpController,
                decoration: InputDecoration(
                  labelText: '핸드폰',
                  hintText: '핸드폰번호를 입력해 주세요',
                  border: OutlineInputBorder()
                )
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 30),
              child: TextFormField(
                controller: _companyController,
                decoration: InputDecoration(
                  labelText: '회사',
                  hintText: '회사번호를 입력해 주세요',
                  border: OutlineInputBorder()
                )
              ),
            ),
            SizedBox(
              width: 450,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  print("데이터 전송");
                  updatePerson(personId);
                  Navigator.pushNamed( context, '/list', );
                },
                child: Text("수정")
              ),
            )
          ],
        ),
      ),
    );
  }

  //수정폼에 출력할 정보를 서버로 부터 받아옵니다
  Future<void> getPersonByNo(int pId) async {

    print(pId);
    print("getPersonByNo(): 데이터 가져오기 중");
    try {
      /*----요청처리-------------------*/
      //Dio 객체 생성 및 설정
      var dio = Dio();

      // 헤더설정:json으로 전송
      dio.options.headers['Content-Type'] = 'application/json';

      // 서버 요청
      final response = await dio.get(
        'http://15.164.245.216:9000/api/persons/${pId}',
      );

      /*----응답처리-------------------*/
      if (response.statusCode == 200) {
        //접속성공 200 이면
        print(response.data); // json->map 자동변경
        //서버로 부터 받은 값을 personVo로 변환
        PersonVo personVo = PersonVo.fromJson(response.data["apiData"]);

        //받은값을 input의 변화를 감지하는 변수에 전달
        //value값은 _nameController.text = 값 으로 넣는다
        _nameController.text = personVo.name;
        _hpController.text =  personVo.hp;
        _companyController.text =  personVo.company;

      } else {
        //접속실패 404, 502등등 api서버 문제
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      //예외 발생
      throw Exception('Failed to load person: $e');
    }
  }


  //수정하기, 입력폼의 내용을 서버에 전송하여 수정합니다.
  Future<void> updatePerson(int pId) async {
    try {
      /*----요청처리-------------------*/
      //Dio 객체 생성 및 설정
      var dio = Dio();

      // 헤더설정:json으로 전송
      dio.options.headers['Content-Type'] = 'application/json';

      // 서버 요청
      final response = await dio.put(
        'http://15.164.245.216:9000/api/persons/${pId}',
        data: {
          'name': _nameController.text,
          'hp': _hpController.text,
          'company': _companyController.text,
        },

      );

      /*----응답처리-------------------*/
      if (response.statusCode == 200) {
        //접속성공 200 이면
        print(response.data); // json->map 자동변경
        //return PersonVo.fromJson(response.data["apiData"]);
        Navigator.pushNamed( context, '/list', );

      } else {
        //접속실패 404, 502등등 api서버 문제
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      //예외 발생
      throw Exception('Failed to load person: $e');
    }
  }

}





