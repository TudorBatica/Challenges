import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/common/common_failures.dart';
import '../../domain/common/json_serializer.dart';

/// Repository which provides basic CRUD
/// functionalities for a Firestore database.
/// The repository stores one entity of type T per Firestore document.
abstract class FirestoreCrudRepository<T> {
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

  /// Creates a new doc with documentId.
  /// Will auto generate an id if one is not provided.
  /// If [writeInDoc] parameter is true, the method will update the document,
  /// after creation with a field `{id: documentId}`.
  ///
  /// *WARNING: If the document already exists, it will OVERWRITE it.*
  Future<String> create(T entity, String? documentId,
      {bool writeIdInDoc = false}) async {
    late final createdDocId;
    if (documentId == null) {
      final newDoc = await _collection.add(_serializer.toJson(entity));
      createdDocId = newDoc.id;
    } else {
      await _collection.doc(documentId).set(_serializer.toJson(entity));
      createdDocId = documentId;
    }
    if (writeIdInDoc) {
      update({'id': createdDocId}, createdDocId);
    }
    return createdDocId;
  }

  /// Delete a document.
  Future<void> delete(String documentId) async {
    await _collection.doc(documentId).delete();
  }

  /// Retrieves the entity located inside a specific document
  /// Throws a [DataNotFound] exception
  /// if the document does not exist or is empty.
  Future<T> read(String documentId) async {
    final document = await _collection.doc(documentId).get();
    final docData = document.data() ?? <String, dynamic>{};
    if (!document.exists || docData.isEmpty) {
      throw DataNotFound();
    }
    docData.addAll({'id': documentId});
    return _serializer.fromJson(docData);
  }

  /// Update a specific doc.
  Future<void> update(
      Map<String, dynamic> updatedFields, String documentId) async {
    await _collection.doc(documentId).update(updatedFields);
  }

  /// Retrieves the entire collection.
  Future<List<T>> readEntireCollection() async {
    final entireCollection = await _collection.get();
    return entireCollection.docs.map(
      (document) {
        final data = document.data();
        data.addAll({'id': document.id});
        return _serializer.fromJson(data);
      },
    ).toList();
  }
}
