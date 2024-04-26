import 'package:flutter/material.dart';

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
        child: Text("본문")
      )
    );
  }
}

class _ListPage extends StatefulWidget {
  const _ListPage({super.key});

  @override
  State<_ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<_ListPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

