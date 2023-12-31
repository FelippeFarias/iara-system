import 'package:windows_data/windows_data.dart';

abstract class XmlSerializable {
  void fromXmlNode(IXmlNode? node);
  IXmlNode toXmlNode(XmlDocument doc);
}