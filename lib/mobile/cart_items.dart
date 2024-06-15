import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import '../hero_dialog_route.dart';
import 'add_ons_hero.dart';
import 'order_slip.dart';
import 'globals.dart' as globals;

class CartItems extends StatefulWidget{
  List<Map<String, dynamic>> orders = [];
  final void Function() onDelete;
  CartItems({
    super.key,
    required this.orders,
    required this.onDelete
  });

  @override
  _CartItemsState createState() => _CartItemsState();
}
class _CartItemsState extends State<CartItems>{

  final _controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: const Color(0xf0967259),

            ),
            child: const Center(
              child: Text(
                "Current Order",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            )
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Container(
            width: 340,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
                color: const Color(0xf0EBEBEB)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextField(
                autocorrect: false,
                controller: _controllerName,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name',
                  hintStyle: TextStyle(fontSize: 20),
                ),
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            )
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Container(
            width: 340,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(10),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: DataTable(
                  dataRowMaxHeight: 80,
                  columnSpacing: 20,
                  dataRowMinHeight: 50,
                  horizontalMargin: 5,
                  columns: const [
                    DataColumn(label: Center(
                      child: Text(
                          'Item',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    ),
                    DataColumn(label: Center(
                      child: Text(
                          'Size',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    ),
                    DataColumn(label: Center(
                      child: Text(
                          'Qty',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    ),
                    DataColumn(label: Center(
                      child: Text(
                          'Price',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    ),
                    DataColumn(label: Center(
                      child: Text(
                          ''
                      ),
                    ),
                    ),
                  ], rows: widget.orders.map((e) =>
                    DataRow(
                        cells: [
                          DataCell(Text(e["name"],
                            style: const TextStyle(fontSize: 16),),
                          ),
                          DataCell(Center(
                            child: Text(e["size"],
                              style: const TextStyle(fontSize: 16),),
                          )),
                          DataCell(Center(
                            child: Text(e["qty"].toString(),
                              style: const TextStyle(fontSize: 16),),
                          )),
                          DataCell(Center(
                            child: Text(e["price"].toString(),
                              style: const TextStyle(fontSize: 16),),
                          )),
                          DataCell(
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      globals.total -= e["price"];
                                      widget.orders.remove(e);
                                      widget.onDelete();
                                    });
                                  },
                                  icon: Image.asset(
                                    "assets/images/delete.png",
                                    width: 32,
                                  )
                              )
                          )
                        ]
                    )
                ).toList(),
                ),
              ),
            )
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Total:",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 10)),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${globals.total}",
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xf0ECE0D1).withAlpha(150),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Builder(
                  builder: (context) {
                    return TextButton(
                      onPressed: (){
                        showPopover(
                            context: context,
                            bodyBuilder: (context){
                              return const AddOnsHero();
                            }
                        ).then((value) =>
                            setState(() {
                              globals.computeTotal();
                              widget.onDelete();
                            }));
                      },
                      child: const Text(
                        "Add-ons",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    );
                  }
                ),
              ),
              Container(
                width: 160,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xf0ECE0D1).withAlpha(150),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: widget.orders.isEmpty ? null : () {
                    globals.customerName = _controllerName.text;
                    Navigator.push(context, HeroDialogRoute(
                        builder: (context){
                          return const OrderPaymentScreen();
                        })
                    ).then((value) => setState(() {
                      if(!value){
                        globals.orderList = [];
                        widget.orders = [];
                        _controllerName.text = "";
                      }
                    })
                    );
                  },
                  child: const Text(
                    "Complete Order",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

}