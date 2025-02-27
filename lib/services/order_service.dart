// Service xử lý logic nghiệp vụ
import '../models/order.dart';
import '../repositories/order_repository.dart';

class OrderService {
  final OrderRepository _repository;

  OrderService(this._repository);

  Future<List<Order>> getAllOrders() async {
    try {
      return await _repository.getAllOrders();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addOrder(Order order) async {
    try {
      await _repository.addOrder(order);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteOrder(String id) async {
    try {
      await _repository.deleteOrder(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Order>> searchOrders(String itemName) async {
    try {
      return await _repository.searchByItemName(itemName);
    } catch (e) {
      rethrow;
    }
  }
}