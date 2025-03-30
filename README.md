# 🚨 Panic Button - Personal Security App

> **Aplicativo de botão do pânico projetado para enviar alertas instantâneos com localização GPS para contatos pré-definidos em situações de emergência.**

---

## 📱 Sobre o Projeto

O **Panic Button - Personal Security** é um aplicativo Android simples, porém poderoso, criado com **Flutter**. Seu objetivo é fornecer segurança pessoal, especialmente para mulheres e indivíduos vulneráveis, permitindo o envio rápido de uma mensagem de emergência com localização exata via SMS.

---

## 🌟 Funcionalidades Principais

- **Botão SOS gigante:** fácil e rápido acionamento em situações críticas.
- **Envio automático de SMS:** mensagem de alerta com link de localização em tempo real.
- **Gerenciamento de contatos:** configure e armazene números de emergência diretamente pelo aplicativo.
- **Localização GPS:** alta precisão da posição atual do usuário.
- **Permissões simplificadas:** solicita automaticamente as permissões necessárias para funcionamento.

---

## 🛠️ Tecnologias Utilizadas

- [Flutter](https://flutter.dev/)
- [Geolocator](https://pub.dev/packages/geolocator)
- [Telephony](https://pub.dev/packages/telephony)
- [Permission Handler](https://pub.dev/packages/permission_handler)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)

---

## 📲 Como Usar

### Pré-requisitos

- Flutter instalado ([Guia Oficial](https://flutter.dev/docs/get-started/install))
- Android Studio
- Java 17
- Android SDK configurado

### Instalação e execução

Clone este repositório:

```bash
git clone https://github.com/CyberSecurityUP/Panic-Button-PersonalSecurity.git
cd Panic-Button-PersonalSecurity
```

Baixe as dependências:

```bash
flutter pub get
```

Conecte um dispositivo Android via USB com a depuração ativada ou inicie um emulador, e execute:

```bash
flutter run
```

### Gerar APK

Para gerar um APK de release:

```bash
flutter build apk --release
```

Seu APK estará disponível em:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## ⚠️ Atenção

- Lembre-se de substituir os números padrão pelos números reais de emergência ao usar o aplicativo.
- Certifique-se de testar o aplicativo cuidadosamente antes de utilizá-lo em situações reais.

---

## 🔐 Segurança e Privacidade

O aplicativo não armazena nem compartilha dados sensíveis, exceto aqueles armazenados localmente no dispositivo (números de contato definidos pelo usuário).

---

## 📌 Licença

Este projeto está sob licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 🤝 Contribuições

Contribuições são sempre bem-vindas! Abra uma Issue ou Pull Request diretamente no GitHub.

---

## 👨‍💻 Autor

Desenvolvido por [CyberSecurityUP](https://github.com/CyberSecurityUP).
