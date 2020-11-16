
import 'package:mbox_floor_app/models/produto.model.dart';
import 'package:mbox_floor_app/repositories/produto.repository.dart';
import 'package:mobx/mobx.dart';


import '../app_status.dart';
part 'produto.controller.g.dart';

class ProdutoController = _ProdutoController with _$ProdutoController;
abstract class _ProdutoController with Store{
  ProdutoRepository repository;
  _ProdutoController(){
    _init();
  }
  Future<void> _init() async {
    repository = await ProdutoRepository.getInstance();
    await getAll();
  }
  @observable
  AppStatus status = AppStatus.none;
  @observable
  ObservableList<Produto> list = ObservableList<Produto>();
  @action
  Future<void> getAll() async {
    status = AppStatus.loading;
    try {
      if(repository != null) {
        final allList = await repository.getAll();
        list.clear();
        list.addAll(allList);
      }
      status = AppStatus.success;
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }
  @action
  Future<void> create(Produto p) async {
    status = AppStatus.loading;
    try {
      await repository.create(p);
      await getAll();
      status = AppStatus.success;
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }
  @action
  Future<void> update(Produto p) async {
    status = AppStatus.loading;
    try {
      await repository.update(p);
      await getAll();
      status = AppStatus.success;
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }
  @action
  Future<void> delete(int id) async {
    status = AppStatus.loading;
    try {
      await repository.delete(id);
      await getAll();
      status = AppStatus.success;
    }catch(e){
      status = AppStatus.error..value = e;
    }
  }
}