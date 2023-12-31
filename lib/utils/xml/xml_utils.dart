import 'package:windows_data/windows_data.dart';

import 'xml_serializable.dart';

class XmlUtils {
  static List<T> parseXmlToList<T extends XmlSerializable>(
      String xmlString, T Function() creator, String tagName) {
    final xmlDoc = XmlDocument();
    xmlDoc.loadXml(xmlString);
    final elements = xmlDoc.getElementsByTagName(tagName);

    return elements.toList().map((node) {
      T item = creator();
      item.fromXmlNode(node);
      return item;
    }).toList();
  }

  static String objectToXmlString<T extends XmlSerializable>(
      List<T> objects, String rootTagName) {
    final doc = XmlDocument();
    final root = doc.createElement(rootTagName);
    doc.appendChild(
        root); // Garantindo que root é válido antes de chamar appendChild

    for (var object in objects) {
      IXmlNode node = object.toXmlNode(doc);
      // Verificação adicional para garantir que node não é nulo
      root!.appendChild(node);
    }

    return doc.getXml();
  }
}
