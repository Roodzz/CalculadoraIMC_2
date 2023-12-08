import 'package:flutter/material.dart';

void main() => runApp(const CalculaIMCApp());

class CalculaIMCApp extends StatelessWidget {
  const CalculaIMCApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Definindo o tema da aplicação, incluindo cores e estilos globais.
        primaryColor: const Color(0xff8e44ad),
        colorScheme: const ColorScheme.light().copyWith(
          secondary: const Color(0xffffc107),
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff8e44ad)),
          bodyText1: TextStyle(fontSize: 16.0, color: Colors.black),
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.black54),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xffffc107),
            textStyle:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          ),
        ),
      ),
      home: const IMCScreen(),
    );
  }
}

class IMCScreen extends StatefulWidget {
  const IMCScreen({Key? key}) : super(key: key);

  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  double _idadeValor = 20;
  double _pesoValor = 60;
  double _alturaValor = 1.70;
  String _generoSelecionado = '';
  double _resultadoIMC = 0.0;
  String _categoriaIMC = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Exibindo a idade com um valor inicial de 20.
              Text('Idade: ${_idadeValor.toInt()}',
                  style: Theme.of(context).textTheme.bodyText2),
              // Slider para selecionar a idade.
              Slider(
                value: _idadeValor,
                max: 100,
                divisions: 100,
                label: _idadeValor.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _idadeValor = value;
                  });
                },
              ),
              // Exibindo o peso com um valor inicial de 60.
              Text('Peso: ${_pesoValor.toInt()} kg',
                  style: Theme.of(context).textTheme.bodyText2),
              // Slider para selecionar o peso.
              Slider(
                value: _pesoValor,
                max: 200,
                divisions: 200,
                label: _pesoValor.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _pesoValor = value;
                  });
                },
              ),
              // Exibindo a altura com um valor inicial de 1.70.
              Text('Altura: ${_alturaValor.toStringAsFixed(2)} m',
                  style: Theme.of(context).textTheme.bodyText2),
              // Slider para selecionar a altura.
              Slider(
                value: _alturaValor,
                max: 2.5,
                divisions: 250,
                onChanged: (double value) {
                  setState(() {
                    _alturaValor = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Exibindo o gênero selecionado (Masculino ou Feminino).
              Text('Gênero: $_generoSelecionado',
                  style: Theme.of(context).textTheme.bodyText2),
              // Botões para selecionar o gênero.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _generoSelecionado = 'Masculino';
                      });
                    },
                    child: const Text('Masculino'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _generoSelecionado = 'Feminino';
                      });
                    },
                    child: const Text('Feminino'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Botão para calcular o IMC.
              ElevatedButton(
                onPressed: _calcularIMC,
                child: const Text('Calcular IMC'),
              ),
              const SizedBox(height: 20),
              // Exibindo o resultado do IMC e a categoria correspondente.
              if (_resultadoIMC != 0.0) ...[
                Text('Resultado IMC: ${_resultadoIMC.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 20),
                Text('Categoria IMC: $_categoriaIMC',
                    style: Theme.of(context).textTheme.headline6),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Função para calcular o IMC com base nos valores selecionados.
  void _calcularIMC() {
    if (_idadeValor > 0 &&
        _pesoValor > 0 &&
        _alturaValor > 0 &&
        _generoSelecionado.isNotEmpty) {
      double altura = _alturaValor;
      double peso = _pesoValor;
      // Fórmula do IMC: peso / (altura * altura)
      _resultadoIMC = peso / (altura * altura);

      // Determinando a categoria do IMC com base nos valores padrão da OMS.
      if (_resultadoIMC < 18.5) {
        _categoriaIMC = 'Muito abaixo do peso';
      } else if (_resultadoIMC >= 18.5 && _resultadoIMC < 24.9) {
        _categoriaIMC = 'Peso normal';
      } else if (_resultadoIMC >= 25 && _resultadoIMC < 29.9) {
        _categoriaIMC = 'Acima do peso';
      } else if (_resultadoIMC >= 30 && _resultadoIMC < 34.9) {
        _categoriaIMC = 'Obesidade Grau 1';
      } else if (_resultadoIMC >= 35 && _resultadoIMC < 39.9) {
        _categoriaIMC = 'Obesidade Grau 2';
      } else {
        _categoriaIMC = 'Obesidade Grau 3';
      }

      setState(() {});
    }
  }
}
