
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mbox_floor_app/controllers/produto.controller.dart';
import 'package:mbox_floor_app/models/produto.model.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProdutoListView extends StatefulWidget {
  @override
  _ProdutoListViewState createState() => _ProdutoListViewState();
}
class _ProdutoListViewState extends State<ProdutoListView> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  ProdutoController _controller = null;

  String _theme = 'Light';
  var _themeData = ThemeData.light();

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Widget build(BuildContext context) {
    _controller = Provider.of<ProdutoController>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _themeData,
      home: Scaffold(
       appBar: AppBar(title: Text('Sua lista'),
           backgroundColor: Color.fromRGBO(123, 104, 238, 5),
           actions: [_PopupMenuButton()],
           centerTitle: true),
       body: Scrollbar(
        child: Observer(builder: (_) {
          if (_controller.status == AppStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_controller.status == AppStatus.success) {
            return ListView(
              children: [
                for (int i = 0; i < _controller.list.length; i++)
                  ListTile(
                      title: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: _controller.list[i].concluido
                            ? Text(
                          _controller.list[i].nome,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough),
                        )
                            : Text(_controller.list[i].nome),
                        value: _controller.list[i].concluido,
                        secondary: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 20.0,
                            color: Colors.red[900],
                          ),
                          onPressed: () async {
                            await _controller.delete(_controller.list[i].id);
                          },
                        ),
                        onChanged: (c) async {
                          Produto edited = _controller.list[i];
                          edited.concluido = c;
                          await _controller.update(edited);
                        },
                      )),
              ],
            );
          }else{
            return Text("Carregando... ");
          }
        }),
      ),
        floatingActionButton: FloatingActionButton(
         child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(123, 104, 238, 20),
         onPressed: () => _displayDialog(context),
      ),
    ));
  }
  _displayDialog(context) async {


    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _itemController,
                validator: (s) {
                  if (s.isEmpty)
                    return "Digite o produto.";
                  else
                    return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Produto"),

              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();

                },

              ),
              FlatButton(
                child: new Text('SALVAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _controller.create(Produto(nome: _itemController.text,
                        concluido: false));
                    _itemController.text = "";
                    Navigator.of(context).pop();

                  }
                },
              )
            ],
          );
        });
  }
  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = (prefs.getString('theme') ?? 'Light');
      _themeData = _theme == 'Dark' ? ThemeData.dark() : ThemeData.light();
    });
  }

// Carregando o tema salvo pelo usuário
  _setTheme(theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = theme;
      _themeData = theme == 'Dark' ? ThemeData.dark() : ThemeData.light();
      prefs.setString('theme', theme);
    });
  }

  _PopupMenuButton() {
    return PopupMenuButton(
      onSelected: (value) => _setTheme(value),
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(
          PopupMenuItem(
              child: Text("Configurar Tema")
          ),
        );
        list.add(
          PopupMenuDivider(
            height: 10,
          ),
        );
        list.add(
          CheckedPopupMenuItem(
            child: Text("Light"),
            value: 'Light',
            checked: _theme == 'Light',
          ),
        );
        list.add(
          CheckedPopupMenuItem(
            child: Text("Dark"),
            value: 'Dark',
            checked: _theme == 'Dark',
          ),
        );
        return list;
      },
    );
  }

}
