// Giao diện người dùng
import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/order_service.dart';
import '../repositories/order_repository.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final OrderService _orderService = OrderService(OrderRepository());
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      final orders = await _orderService.getAllOrders();
      setState(() {
        _orders = orders;
      });
    } catch (e) {
      _showError('Không thể tải danh sách đơn hàng');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Order'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form nhập liệu
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: const InputDecoration(labelText: 'Item'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _itemNameController,
                    decoration: const InputDecoration(labelText: 'Item Name'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _currencyController,
                    decoration: const InputDecoration(labelText: 'Currency'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _addOrder,
                child: const Text('Add Item to Cart'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Item')),
                    DataColumn(label: Text('Item Name')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Currency')),
                    DataColumn(label: Text('')),
                  ],
                  rows: _orders.map((order) => DataRow(
                    cells: [
                      DataCell(Text(order.id)),
                      DataCell(Text(order.item)),
                      DataCell(Text(order.itemName)),
                      DataCell(Text(order.quantity.toString())),
                      DataCell(Text(order.price.toString())),
                      DataCell(Text(order.currency)),
                      DataCell(IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteOrder(order.id),
                      )),
                    ],
                  )).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addOrder() async {
    try {
      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        item: _itemController.text,
        itemName: _itemNameController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        currency: _currencyController.text,
      );

      await _orderService.addOrder(order);
      _clearForm();
      await _loadOrders();
    } catch (e) {
      _showError('Không thể thêm đơn hàng');
    }
  }

  Future<void> _deleteOrder(String id) async {
    try {
      await _orderService.deleteOrder(id);
      await _loadOrders();
    } catch (e) {
      _showError('Không thể xóa đơn hàng');
    }
  }

  void _clearForm() {
    _itemController.clear();
    _itemNameController.clear();
    _priceController.clear();
    _quantityController.clear();
    _currencyController.clear();
  }

  @override
  void dispose() {
    _itemController.dispose();
    _itemNameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _currencyController.dispose();
    super.dispose();
  }
}