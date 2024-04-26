import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'personVo.dart';


class ListPage extends StatelessWidget {
  const ListPage({super.key});

  //기본레이아웃
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("리스트페이지")),
      body: Container(
        padding: EdgeInsets.all(15),
        color: Color(0xffd6d6d6),
        child: _ListPage()
      )
    );
  }
}

//등록
class _ListPage extends StatefulWidget {
  const _ListPage({super.key});

  @override
  State<_ListPage> createState() => _ListPageState();
}

//할일
class _ListPageState extends State<_ListPage> {

  //공통변수


  //생애주기별 훅

  //초기화할대
  @override
  void initState() {
    super.initState();
    getPersonList();
  }


  //그림그릴때
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  //리스트가져오기 dio통신
  Future< List<PersonVo> > getPersonList() async {
    try {
      /*----요청처리-------------------*/
      //Dio 객체 생성 및 설정
      var dio = Dio();

      // 헤더설정:json으로 전송
      dio.options.headers['Content-Type'] = 'application/json';

      // 서버 요청
      final response = await dio.get(
        'http://15.164.245.216:9000/api/persons',
      );

      /*----응답처리-------------------*/
      if (response.statusCode == 200) {
        //접속성공 200 이면
        print(response.data["apiData"]); // json->map 자동변경
        print(response.data["apiData"].length); // json->map 자동변경
        print(response.data["apiData"][0]);
        //수신한 데이터  [map, map, map]
        //비어있는 리스트 생성  []
        //map -> {} 변환
        //[{}, {} ,{}]

        List<PersonVo> personList = [];
        for(int i=0; i<response.data["apiData"].length; i++){
          PersonVo personVo = PersonVo.fromJson(response.data["apiData"][i]);
          personList.add(personVo);
        }
        return personList;

      } else {
        //접속실패 404, 502등등 api서버 문제
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      //예외 발생
      throw Exception('Failed to load person: $e');
    }
  } //getPersonList()


}

