library globals;

List<Map<String, dynamic>> orderList= [];
double total = 0.0;
String customerName = "";
int listLength = 0;

void computeTotal() {
  total = total + orderList[orderList.length - 1]["price"];
}


