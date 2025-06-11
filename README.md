# Aplicativo de Lista de Compras (Simulação Local)

Este é um aplicativo Flutter que permite aos usuários criar e gerenciar listas de compras com simulação de dados locais. Ele foi desenvolvido como parte de um projeto para demonstrar as funcionalidades de um aplicativo de lista de compras.

## Funcionalidades

*   **Criação de Listas:** Crie novas listas de compras com nome e categoria (ex: Supermercado, Farmácia).
*   **Gerenciamento de Itens:** Adicione, edite e exclua itens dentro de cada lista, especificando nome e quantidade.
*   **Marcar como Comprado:** Marque itens como comprados para acompanhar o que já foi adquirido.
*   **Limpar Lista:** Remova todos os itens marcados como comprados de uma lista.

## Estrutura do Projeto

O projeto segue uma estrutura modular para facilitar a organização e manutenção do código:

```
shopping_list_app/
├── lib/
│   ├── main.dart             # Ponto de entrada do aplicativo
│   ├── models/               # Definições dos modelos de dados (ShoppingList, ShoppingItem)
│   │   ├── shopping_list.dart
│   │   └── shopping_item.dart
│   ├── services/             # Serviço de dados local para gerenciar as listas e itens
│   │   └── local_data_service.dart
│   └── views/                # Telas da interface do usuário
│       ├── shopping_list_screen.dart
│       ├── shopping_list_form_screen.dart
│       ├── shopping_list_detail_screen.dart
│       └── shopping_item_form_screen.dart
├── pubspec.yaml            # Dependências e metadados do projeto
├── README.md               # Este arquivo
└── ... (outros arquivos gerados pelo Flutter)
```

## Como Executar o Projeto

Para executar este projeto Flutter, você precisará ter o Flutter SDK instalado em sua máquina. Siga as instruções em [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install) para instalar o Flutter.

Após a instalação do Flutter, siga os passos abaixo:

1.  **Clone o repositório:**
    ```bash
    git clone <URL_DO_SEU_REPOSITORIO>
    cd shopping_list_app
    ```

2.  **Obtenha as dependências:**
    ```bash
    flutter pub get
    ```

3.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```

    Você pode executar o aplicativo em um emulador Android/iOS, navegador web ou dispositivo físico conectado.

## Testes

Para executar os testes de unidade e widget (se houver) no projeto, utilize o seguinte comando:

```bash
flutter test
```

## Considerações Finais

Este projeto serve como uma base para um aplicativo de lista de compras com simulação de dados locais. Para uma versão com persistência de dados real, a integração com um backend como o Firebase Firestore seria o próximo passo lógico, substituindo o `LocalDataService` por um serviço que interaja com o Firebase.


