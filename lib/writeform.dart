import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//레이아웃 클래스
class WriteForm extends StatelessWidget {
  const WriteForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("등록폼")),
      body: Container(
        padding: EdgeInsets.all(15),
        color: Color(0xffd6d6d6),
        child: _WriteForm()
      ),

    );
  }
}

//등록
class _WriteForm extends StatefulWidget {
  const _WriteForm({super.key});

  @override
  State<_WriteForm> createState() => _WriteFormState();
}

//할일
class _WriteFormState extends State<_WriteForm> {

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
                  writePerson();
                  print("데이터 전송");
                },
                child: Text("저장")
              ),
            )
          ],
        ),
      ),
    );
  }

  //저장하기
  Future<void> writePerson() async {
    try {
      /*----요청처리-------------------*/
      //Dio 객체 생성 및 설정
      var dio = Dio();

      // 헤더설정:json으로 전송
      dio.options.headers['Content-Type'] = 'application/json';

      // 서버 요청
      final response = await dio.post(
        'http://15.164.245.216:9000/api/persons',
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





