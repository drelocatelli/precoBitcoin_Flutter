import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _valor = "00.00";

  void _obterValor() async {

    String webservice = "https://blockchain.info/ticker";

    http.Response request = await http.get(Uri.parse(webservice));

    Map<String, dynamic> response = json.decode(request.body);

    // print("Resultado : " + response.toString());

    setState(() {
      _valor = response["BRL"]["buy"].toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Preço Bitcoin"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Padding(
               padding: EdgeInsets.only(top: 30, bottom: 30),
               child: Image.asset("images/bitcoin.png", width: MediaQuery.of(context).size.width * 0.65),
             ),
           ],
          ),
          Column(
            children: [
              Text("R\$ ${_valor}", style: TextStyle(fontSize: 26)),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child:  ElevatedButton(
                    onPressed: _obterValor,
                    style: ElevatedButton.styleFrom(primary: Colors.orangeAccent),
                    child: Text("Atualizar"),
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
