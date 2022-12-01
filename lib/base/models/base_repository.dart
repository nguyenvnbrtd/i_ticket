import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animation/base/models/base_model.dart';

class BaseRepository<T extends BaseModel>{
  late final CollectionReference collection;

  BaseRepository(String collection){
    this.collection = FirebaseFirestore.instance.collection(collection);
  }

  Future<void> create(T data) async {
    await collection.doc().set(data.toJson());
  }

  Future<T> getById(String id) async {
    final response = await collection.doc(id).get(const GetOptions(source: Source.serverAndCache));
    final data = response.data();
    if(data != null){
      return (BaseModel as T).fromJson(response.data());
    }else{
      return (BaseModel as T).init();
    }
  }

  Future<void> update({required String id, required T data}) async {
    await collection.doc(id).set(data.toJson());
  }

  Stream<List<T>> getAll(){
    return collection.snapshots().map(_listDataFromSnapShot);
  }

  List<T> _listDataFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return (BaseModel as T).fromJson(doc.data());
    }).toList() as List<T>;
  }
}