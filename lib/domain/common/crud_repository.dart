/// Repository which exposes basic CRUD functionalities
abstract class CrudRepository<Entity> {
  /// Creates a new entity
  Future<void> create(Entity entity);

  /// Creates a new entity at a specific location
  Future<void> createAt(Entity entity, String location);

  /// Retrieves a specific entity
  Future<Entity> read(String id);

  /// Updates an entity
  Future<void> update(Entity entity, String id);

  /// Remove an entity
  Future<void> delete(String id);
}
