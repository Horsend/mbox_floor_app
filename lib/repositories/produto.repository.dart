
import 'package:mbox_floor_app/models/produto.model.dart';
import 'package:mbox_floor_app/repositories/produto.dao.dart';
import 'package:mbox_floor_app/repositories/produto.database.dart';


class ProdutoRepository{
  static ProdutoRepository _instance;
  ProdutoRepository._();
  AppDatabase database;
  ProdutoDao produtoDao;
  static Future<ProdutoRepository> getInstance() async{
    if(_instance != null) return _instance;
    _instance = ProdutoRepository._();
    await _instance.init();
    return _instance;
  }
  Future<void> init() async {
    database = await $FloorAppDatabase
        .databaseBuilder('produtos.db')
        .build();
    produtoDao = database.produtoDao;
  }
  Future<List<Produto>> getAll() async {
    try {
      return await produtoDao.getAll();
    } catch (e) {
      return List<Produto>();
    }
  }
  Future<bool> create(Produto p) async {
    try {
      await produtoDao.insertProduto(p);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> update(Produto p) async {
    try {
      await produtoDao.updateProduto(p);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> delete(int id) async {
    try {
      Produto p = await produtoDao.getProdutoById(id);
      await produtoDao.deleteProduto(p);
      return true;
    } catch (e) {
      return false;
    }
  }
}
