# 📱 Calha Parshall App Mobile

Aplicativo móvel desenvolvido para auxiliar no dimensionamento de Calhas Parshall utilizadas em sistemas de saneamento, tratamento de água e tratamento de esgoto.

O aplicativo realiza cálculos automáticos de vazão, identifica a calha adequada para a vazão informada e auxilia na verificação de possíveis condições de transbordamento.

---

## 🎯 Objetivo

Facilitar o dimensionamento de Calhas Parshall por meio de uma interface simples e intuitiva, reduzindo erros manuais e agilizando cálculos utilizados por estudantes, técnicos e profissionais da área de engenharia.

---

## ✨ Funcionalidades

* Cálculo de vazão em m³/s
* Conversão automática de unidades
* Seleção da Calha Parshall adequada
* Cálculo da altura da lâmina d'água (H)
* Verificação de percentual de utilização da calha
* Identificação de risco de transbordamento
* Interface simples para uso em campo

---

## 🧮 Como Funciona

O usuário informa:

* População atendida
* Consumo diário por habitante (L/hab.dia)

O sistema calcula automaticamente:

* Vazão diária
* Vazão por segundo
* Vazão em m³/s
* Modelo de Calha Parshall recomendado
* Altura da lâmina d'água
* Percentual de utilização da calha

---

## 🚀 Tecnologias Utilizadas

### Frontend Mobile

* Flutter
* Dart

### Ferramentas

* VS Code
* Android SDK
* Flutter SDK

---

## 📸 Screenshots

### Tela Inicial

Adicione uma captura de tela aqui.

### Entrada de Dados

Adicione uma captura de tela aqui.

### Resultado do Dimensionamento

Adicione uma captura de tela aqui.

---

## 📦 Instalação

Clone o projeto:

```bash
git clone https://github.com/AdautoFurich/calha-parshall-app-mobile.git
```

Entre na pasta:

```bash
cd calha-parshall-app-mobile
```

Instale as dependências:

```bash
flutter pub get
```

Execute o aplicativo:

```bash
flutter run
```

---

## 🔨 Gerando APK

Para gerar a versão Android:

```bash
flutter build apk --release
```

O APK será gerado em:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🏗️ Estrutura do Projeto

```text
lib/
├── screens/
├── widgets/
├── models/
├── services/
└── main.dart
```

---

## 📚 Aplicações

O aplicativo pode ser utilizado em:

* Estações de Tratamento de Água (ETA)
* Estações de Tratamento de Esgoto (ETE)
* Projetos hidráulicos
* Estudos acadêmicos
* Dimensionamento preliminar de sistemas de saneamento

---

## 🛣️ Roadmap

### Concluído

* [x] Cálculo de vazão
* [x] Seleção de calha
* [x] Verificação de transbordamento
* [x] Aplicativo Android

### Futuras Melhorias

* [ ] Histórico de cálculos
* [ ] Exportação em PDF
* [ ] Relatórios técnicos
* [ ] Gráficos de vazão
* [ ] Compartilhamento dos resultados
* [ ] Versão iOS

---

## 👨‍💻 Autor

**Adauto Furich**

Acadêmico de Análise e Desenvolvimento de Sistemas

Projeto desenvolvido para aplicação prática de programação e engenharia de saneamento.

---

## 📄 Licença

Projeto desenvolvido para fins acadêmicos, educacionais e profissionais.
