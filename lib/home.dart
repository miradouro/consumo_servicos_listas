import 'package:consumo_servicos_listas/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPostagens() async {

    http.Response response;
    response = await http.get(Uri.parse(_urlBase+"/posts"));
    var dadosJson = json.decode(response.body);

    List<Post> postagens = [];
    for( var post in dadosJson ){
      //print("post: " + post["title"]);
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }
    return postagens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consumo Serviços Listas"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Post>>(
        future: _recuperarPostagens(),
        builder: (context, snapshot){
          switch( snapshot.connectionState ){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if( snapshot.hasError ){
                print("lista: Erro ao carregar");
              }else{
                print("lista: Carregada");
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){

                    List<Post> lista = snapshot.data!;
                    Post post = lista[index];

                    return ListTile(
                      title: Text(post.title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                      subtitle: Text(post.id.toString()),
                    );
                  },
                );
              }
              break;
          }
          return const Center(child: Text("Erro"));
        },
      ),
    );
  }
}
