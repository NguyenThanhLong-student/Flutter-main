import 'package:flutter/material.dart';
import 'package:login_with_signup/DatabaseHandler/DbHelper.dart';
import 'package:login_with_signup/Model/CarModel.dart';

class Car {
  String _make;
  String _model;
  String _description;
  String _imageSrc;
  Car(this._make, this._model, this._description, this._imageSrc);
  operator ==(other) =>
      (other is Car) && (_make == other._make) && (_model == other._model);
}

class CarList extends StatefulWidget {
  @override
  CarListState createState() => CarListState("Cars");
}
List<CarModel> listcar = [];
Future<void> GetCarListFunc() async{
   DbHelper dbHelper = new DbHelper();
   listcar = await dbHelper.getCars();
}

class CarListState extends State<CarList> {
  String _title;
  void initState() {
    GetCarListFunc();
    super.initState();
  }
  // List<Car> cars = [
  //   Car(
  //     "Bmw",
  //     "M3",
  //     "Được ra mắt gần đây với thiết kế ấn tượng, vượt trội hơn hẳn các dòng xe cũ làm chao đảo trái tim của những “quý ông“, “quý bà” yêu xe. Với các tính năng cao cấp cùng động cơ 6 xilanh thẳng hàng, công nghệ M TwinPower Turbo đã khiến BMW M3 trở thành dòng xe nổi bật trong cùng phân khúc.BMW M3 2021 hứa hẹn sẽ là một lựa chọn lý tưởng cho những người vừa muốn đáp ứng nhu cầu đi lại hàng ngày vừa muốn sở hữu một cỗ máy hiệu năng cao.",
  //     "https://photo-cms-xedoisong.zadn.vn/w700/Uploaded/2021/tqjwqyqjw/2021_03_06/manhart/xedoisong_bmw_m3_m4_manhart_1_pzdo.jpg",
  //   ),
  //   Car(
  //     "Nissan",
  //     "Sentra",
  //     "Nissan Sentra 2021 không phải là dòng xe SUV bán chạy nhất của hãng Nissan ở khu vực Bắc Mỹ. Đặc biệt Nissan Sentra 2021 ra mắt 3 phiên bản: tiêu chuẩn Sentra S, tầm trung Sentra SV và cao cấp nhất Sentra SR",
  //     "https://img.tinbanxe.vn/webp/images/Nissan/nissan-sentra/mau-sac/tinabnxe-2021-Nissan-Sentra-Colors-trang.jpg"
  //   )
  // mercedes s450
  //https://3.bp.blogspot.com/-T_dV5ZUEF88/XJexr2yeYaI/AAAAAAAAYTE/QU-3qPiM4wADN5jus2WnMegSko-ie4HJACLcBGAs/s1024/Mercedes-S450L-Star-2019-la-chiec-sedan-5-cho-thiet-ke-ngoai-that-va-noi-that-vo-cung-sang-trong-lich-lam.JPG
  // ];
  CarModel _selectedCar = new CarModel("", "", "", "");
  CarListState(this._title);
  void _selectionHandler(CarModel selectedCar) {
    setState(() {
      _selectedCar = selectedCar;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CarWidget> carWidgets = listcar.map((CarModel car) {
      return CarWidget(car, car == _selectedCar, _selectionHandler);
    }).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text("Cars"),
        ),
        body: ListView(children: carWidgets));
  }
}

class CarWidget extends StatelessWidget {
  CarWidget(this._car, this._isSelected, this._parentSelectionHandler)
      : super();
  final CarModel _car;
  final bool _isSelected;
  final ValueChanged<CarModel> _parentSelectionHandler;
  void _handleTap() {
    _parentSelectionHandler(_car);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20.0),
        child: GestureDetector(
          
            onTap: () {
              _handleTap();
              String _title = '${_car.make} ${_car.model}';
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailCartWidget(_car, _title)));
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: _isSelected ? Colors.blue : Colors.white),
                padding: EdgeInsets.all(20.0),
                child: Center(
                    child: Column(children: <Widget>[
                  Text('${_car.make} ${_car.model}',
                      style: TextStyle(fontSize: 20.0)),
                  Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Image.network(_car.imageSrc))
                ])))));
  }
}

class DetailCartWidget extends StatelessWidget {
  DetailCartWidget(this._car, this._title) : super();
  final CarModel _car;
  final String _title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Center(
            child: GestureDetector(
                child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                        child: Column(children: <Widget>[
                      Text('${_car.make} ${_car.model}',
                          style: TextStyle(fontSize: 24.0)),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Image.network(_car.imageSrc)),
                      Text('${_car.description}',
                          style: TextStyle(fontSize: 20.0)),
                    ]))))));
  }
}
