part of 'displacement_service.dart';

class MockDisplacementService implements DisplacementService {
  final List<Displacement> allDisplacements = [];

  @override
  Future<void> addDisplacement(Displacement displacement) async {
    await Future.delayed(Duration(seconds: 2));
    allDisplacements.add(displacement);
  }

  @override
  Stream<List<Displacement>> displacements() async* {
    await Future.delayed(Duration(seconds: 4));
    yield allDisplacements;
  }

  @override
  Future<void> updateDisplacement(Displacement displacement) async {
    await Future.delayed(Duration(seconds: 2));
    final selectedDisplacement =
        allDisplacements.firstWhere((d) => d.id == displacement.id);
  }
}
