import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transferencia.dart';
import '../models/contato.dart';

class ApiService {
  static const String baseUrl = 'https://bank-api-ixt1.onrender.com';

  static Future<String> testarConexaoBanco() async {
    final resposta = await http.get(Uri.parse('$baseUrl/teste-banco'));
    if (resposta.statusCode != 200) {
      throw Exception('erro ao testar conexão com o banco');
    }

    final dados = jsonDecode(resposta.body);
    return dados['mensagem'];
  }

  static Future<List<Transferencia>> buscarTransferencias() async {
    // realiza uma requisição get para a rota /transferencias.
    final resposta = await http.get(Uri.parse('$baseUrl/transferencias'));

    if (resposta.statusCode != 200) {
      throw Exception('erro ao buscar transferências');
    }
    final List<dynamic> dados = jsonDecode(resposta.body);
    return dados.map((item) {
      return Transferencia.fromJson(item);
    }).toList();
  }

  static Future<void> salvarTransferencia(Transferencia transferencia) async {
    final resposta = await http.post(
      Uri.parse('$baseUrl/transferencias'),

      headers: {'Content-Type': 'application/json'},

      body: jsonEncode(transferencia.toJson()),
    );

    if (resposta.statusCode != 201) {
      throw Exception('erro ao salvar transferência');
    }
  }

  static Future<List<Contato>> buscarContatos() async {
    final resposta = await http.get(Uri.parse('$baseUrl/contatos'));

    if (resposta.statusCode != 200) {
      throw Exception('erro ao buscar contatos');
    }

    final List<dynamic> dados = jsonDecode(resposta.body);

    return dados.map((item) {
      return Contato.fromJson(item);
    }).toList();
  }

  static Future<void> salvarContato(Contato contato) async {    
    final resposta = await http.post(
      Uri.parse('$baseUrl/contatos'),      
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(contato.toJson()),
    );    
    if (resposta.statusCode != 201) {
      throw Exception('erro ao salvar contato');
    }    
  }
}
