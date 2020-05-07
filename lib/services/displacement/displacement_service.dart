import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/displacement.dart';

part 'firebase_displacement_service.dart';
part 'mock_displacement_service.dart';

abstract class DisplacementService {
  Future<void> addDisplacement(Displacement displacement);
  Stream<List<Displacement>> displacements();
  Future<void> updateDisplacement(Displacement displacement);
}
