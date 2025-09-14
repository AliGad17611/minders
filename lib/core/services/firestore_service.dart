import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:minders/core/constants/firestore_constants.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String users = FirestoreConstants.users;

  // Generic CRUD Operations

  /// Create a document with auto-generated ID
  Future<String?> create({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final docRef = await _firestore.collection("/$users/$userId/$collection").add(data);
      debugPrint('Document created with ID: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      debugPrint('Error creating document: $e');
      rethrow;
    }
  }

  /// Create a document with custom ID
  Future<void> createWithId({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      await _firestore
          .collection("/$users/$userId/$collection")
          .doc(documentId)
          .set(data);
      debugPrint('Document created with ID: $documentId');
    } catch (e) {
      debugPrint('Error creating document: $e');
      rethrow;
    }
  }

  /// Update a document
  Future<void> update({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      await _firestore
          .collection("/$users/$userId/$collection")
          .doc(documentId)
          .update(data);
      debugPrint('Document updated: $documentId');
    } catch (e) {
      debugPrint('Error updating document: $e');
      rethrow;
    }
  }

  /// Delete a document
  Future<void> delete({
    required String collection,
    required String documentId,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      await _firestore.collection("/$users/$userId/$collection").doc(documentId).delete();
      debugPrint('Document deleted: $documentId');
    } catch (e) {
      debugPrint('Error deleting document: $e');
      rethrow;
    }
  }

  /// Read a single document
  Future<Map<String, dynamic>?> read({
    required String collection,
    required String documentId,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final doc = await _firestore
          .collection("/$users/$userId/$collection")
          .doc(documentId)
          .get();
      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      debugPrint('Error reading document: $e');
      rethrow;
    }
  }

  /// Read all documents from a collection
  Future<List<Map<String, dynamic>>> readAll({
    required String collection,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final querySnapshot =
          await _firestore.collection("/$users/$userId/$collection").get();
      return querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data(),
              })
          .toList();
    } catch (e) {
      debugPrint('Error reading all documents: $e');
      rethrow;
    }
  }

  /// Read documents with query
  Future<List<Map<String, dynamic>>> readWhere({
    required String collection,
    required String field,
    required dynamic value,
    String operator = '==',
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      Query query = _firestore.collection("/$users/$userId/$collection");

      switch (operator) {
        case '==':
          query = query.where(field, isEqualTo: value);
          break;
        case '!=':
          query = query.where(field, isNotEqualTo: value);
          break;
        case '>':
          query = query.where(field, isGreaterThan: value);
          break;
        case '>=':
          query = query.where(field, isGreaterThanOrEqualTo: value);
          break;
        case '<':
          query = query.where(field, isLessThan: value);
          break;
        case '<=':
          query = query.where(field, isLessThanOrEqualTo: value);
          break;
        case 'array-contains':
          query = query.where(field, arrayContains: value);
          break;
        case 'in':
          query = query.where(field, whereIn: value);
          break;
        case 'not-in':
          query = query.where(field, whereNotIn: value);
          break;
        default:
          query = query.where(field, isEqualTo: value);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();
    } catch (e) {
      debugPrint('Error reading documents with query: $e');
      rethrow;
    }
  }

  /// Get document reference
  DocumentReference getDocumentReference({
    required String collection,
    required String documentId,
  }) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return _firestore.collection("/$users/$userId/$collection").doc(documentId);
  }

  /// Get collection reference
  CollectionReference getCollectionReference(String collection) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return _firestore.collection("/$users/$userId/$collection");
  }
  // Real-time Operations

  /// Stream a single document
  Stream<Map<String, dynamic>?> streamDocument({
    required String collection,
    required String documentId,
  }) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return _firestore
        .collection("/$users/$userId/$collection")
        .doc(documentId)
        .snapshots()
        .map((doc) => doc.exists ? doc.data() : null);
  }

  /// Stream a collection
  Stream<List<Map<String, dynamic>>> streamCollection({
    required String collection,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    Query query = _firestore.collection("/$users/$userId/$collection");

    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => {
              'id': doc.id,
              ...doc.data() as Map<String, dynamic>,
            })
        .toList());
  }

  /// Stream with query
  Stream<List<Map<String, dynamic>>> streamWhere({
    required String collection,
    required String field,
    required dynamic value,
    String operator = '==',
    String? orderBy,
    bool descending = false,
    int? limit,
  }) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    Query query = _firestore.collection("/$users/$userId/$collection");

    // Apply where clause
    switch (operator) {
      case '==':
        query = query.where(field, isEqualTo: value);
        break;
      case '!=':
        query = query.where(field, isNotEqualTo: value);
        break;
      case '>':
        query = query.where(field, isGreaterThan: value);
        break;
      case '>=':
        query = query.where(field, isGreaterThanOrEqualTo: value);
        break;
      case '<':
        query = query.where(field, isLessThan: value);
        break;
      case '<=':
        query = query.where(field, isLessThanOrEqualTo: value);
        break;
      case 'array-contains':
        query = query.where(field, arrayContains: value);
        break;
      case 'in':
        query = query.where(field, whereIn: value);
        break;
      case 'not-in':
        query = query.where(field, whereNotIn: value);
        break;
    }

    // Apply ordering
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }

    // Apply limit
    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => {
              'id': doc.id,
              ...doc.data() as Map<String, dynamic>,
            })
        .toList());
  }

  // Transaction Operations

  /// Perform transaction
  Future<T> transaction<T>(
    Future<T> Function(Transaction transaction) updateFunction,
  ) async {
    try {
      return await _firestore.runTransaction(updateFunction);
    } catch (e) {
      debugPrint('Error in transaction: $e');
      rethrow;
    }
  }

  // Utility Methods

  /// Check if document exists
  Future<bool> exists({
    required String collection,
    required String documentId,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final doc = await _firestore
          .collection("/$users/$userId/$collection")
          .doc(documentId)
          .get();

      return doc.exists;
    } catch (e) {
      debugPrint('Error checking document existence: $e');
      rethrow;
    }
  }
}
