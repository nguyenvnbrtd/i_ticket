import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animation/base/models/base_model.dart';
import 'package:flutter_animation/core/utils/log_utils.dart';

class BaseRepository<T extends BaseModel>{
  late final CollectionReference collection;
  T sample;

  BaseRepository(String collection, this.sample){
    this.collection = FirebaseFirestore.instance.collection(collection);
  }

  Future<void> create(T data) async {
    await collection.doc(data.id).set(data.toJson());
  }

  Future<T> getById(String id) async {
    final response = await collection.doc(id).get(const GetOptions(source: Source.serverAndCache));
    final data = response.data();
    if(data != null){
      return sample.fromJson(data);
    }else{
      return sample.init();
    }
  }

  Future<void> update({required String id, required T data}) async {
    await collection.doc(id).update(data.toJson());
  }

  Future<void> delete({required String id}) async {
    await collection.doc(id).delete();
  }

  Stream<List<T>> get getAll {
    return collection.snapshots().map(convert);
  }

  List<T> convert(QuerySnapshot<Object?> event) {
    return event.docs.map((e) => sample.fromJson(e.data()) as T).toList();
  }
}