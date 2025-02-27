// Repository để xử lý dữ liệu
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/order.dart';

class OrderRepository {
  // Danh sách các đơn hàng
  List<Order> _orders = [];

  // Lấy tất cả đơn hàng
  Future<List<Order>> getAllOrders() async {
    try {
      if (_orders.isEmpty) {
        // Đọc dữ liệu từ file JSON
        String jsonString = '[{"Item": "A1000","ItemName": "Iphone 15","Price": 1200,"Currency": "USD","Quantity":1},{"Item": "A1001","ItemName": "Iphone 16","Price": 1500,"Currency": "USD","Quantity":1}]';
        List<dynamic> jsonList = json.decode(jsonString);
        _orders = jsonList.map((json) => Order.fromJson(json)).toList();
      }
      return _orders;
    } catch (e) {
      throw Exception('Không thể đọc dữ liệu: $e');
    }
  }

  // Thêm đơn hàng mới
  Future<void> addOrder(Order order) async {
    try {
      _orders.add(order);
    } catch (e) {
      throw Exception('Không thể thêm đơn hàng: $e');
    }
  }

  // Xóa đơn hàng
  Future<void> deleteOrder(String id) async {
    try {
      _orders.removeWhere((order) => order.id == id);
    } catch (e) {
      throw Exception('Không thể xóa đơn hàng: $e');
    }
  }

  // Tìm kiếm đơn hàng theo tên
  Future<List<Order>> searchByItemName(String itemName) async {
    try {
      return _orders.where((order) => 
        order.itemName.toLowerCase().contains(itemName.toLowerCase())
      ).toList();
    } catch (e) {
      throw Exception('Lỗi tìm kiếm: $e');
    }
  }
}