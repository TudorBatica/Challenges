import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/common/common_failures.dart';
import '../../domain/common/crud_repository.dart';
import '../../domain/common/json_serializer.dart';

/// Repository which provides basic CRUD
/// functionalities for a Firestore database.
/// The repository stores one entity of type T per Firestore document.
abstract class FirestoreCrudRepository<T> implements CrudRepository<T> {
  final FirebaseFirestore _firebaseFirestore;

  @protected
  final JsonSerializer<T> _serializer;

  @protected
  late final CollectionReference _collection;

  // ignore: public_member_api_docs
  FirestoreCrudRepository(
      this._firebaseFirestore, this._serializer, collectionPath) {
    _collection = _firebaseFirestore.collection(collectionPath);
  }

  /// Stores the entity in a new document with a random id
  @override
  Future<void> create(T entity) {
    // TODO: implement create
    throw UnimplementedError();
  }

  /// Stores the entity in a new document with a given id
  /// If the document already exists, it overrides the existing data.
  @override
  Future<void> createAt(T entity, String documentId) async {
    await _collection.doc(documentId).set(_serializer.toJson(entity));
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  /// Retrieves the entity located inside a specific document
  /// Throws a [DataNotFound] exception
  /// if the document does not exist or is empty.
  @override
  Future<T> read(String documentId) async {
    final document = await _collection.doc(documentId).get();
    final docData = document.data() ?? <String, dynamic>{};
    if (!document.exists || docData.isEmpty) {
      throw DataNotFound();
    }
    return _serializer.fromJson(docData);
  }

  @override
  Future<void> update(T entity, String id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
