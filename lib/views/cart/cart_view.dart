import 'package:flutter/material.dart';
import 'package:shop_grocery_app/core/locator.dart';
import 'package:shop_grocery_app/core/models/data_model.dart';
import 'package:shop_grocery_app/views/cart/cart_view_model.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatefulWidget {
  List<DataModel>? datas;
  CartView({Key? key, required this.datas}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => CartViewModel(),
      onModelReady: (viewModel) async {
        await viewModel.initialize(
          cartData: widget.datas!,
        );
      },
      builder: (context, viewModel, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'My Cart',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context,viewModel.data),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 245, 193, 198)),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.category_outlined,
                        color: Color.fromARGB(255, 231, 14, 36),
                      ),
                      Text(
                        '  You have ${widget.datas?.length ?? 0} items in your list cart.',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 231, 14, 36),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: viewModel.data.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 231, 228, 228),
                                  borderRadius: BorderRadius.circular(15)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  '${viewModel.data[index].image}',
                                  height: 60,
                                  width: 50,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${viewModel.data[index].title}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${viewModel.data[index].category} . ${viewModel.data[index].rating!.count}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '\$${viewModel.data[index].price}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              viewModel.selectedData[index]--;
                                              if (viewModel
                                                      .selectedData[index] ==
                                                  0) {
                                                viewModel.selectedData
                                                    .removeAt(index);
                                                viewModel.data.removeAt(index);
                                              }
                                              viewModel.calculateAmount();
                                              viewModel.notifyListeners();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(),
                                              ),
                                              child: const Text(
                                                ' - ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${viewModel.selectedData[index]}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              viewModel.selectedData[index]++;
                                              if (viewModel
                                                      .selectedData[index] >
                                                  viewModel.data[index].rating!
                                                      .count!) {
                                                viewModel.selectedData[index]--;
                                              }
                                              viewModel.calculateAmount();
                                              viewModel.notifyListeners();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(),
                                              ),
                                              child: const Text(
                                                ' + ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                ),
                viewModel.data.isEmpty
                    ? const Offstage()
                    : _buildAmountPart(
                        title: 'items',
                        amount: viewModel.amount.toStringAsFixed(2)),
                viewModel.data.isEmpty
                    ? const Offstage()
                    : _buildAmountPart(title: 'Discount', amount: '5.00'),
                viewModel.data.isEmpty ? const Offstage() : const Divider(),
                viewModel.data.isEmpty
                    ? const Offstage()
                    : _buildAmountPart(
                        title: 'Total',
                        amount: (viewModel.amount - 5).toStringAsFixed(2)),
                viewModel.data.isEmpty
                    ? const Offstage()
                    : ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 26),
                          child: Text(
                            'Checkout',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAmountPart(
      {required String title, required String amount, bool isMinus = false}) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            '${isMinus ? '- ' : ''}\$$amount',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
