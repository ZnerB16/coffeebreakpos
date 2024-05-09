library globals;

List<Map<String, dynamic>> orderList= [];
double total = 0.0;
String customerName = "";

void computeTotal() {
  total = total + orderList[orderList.length - 1]["price"];
}
