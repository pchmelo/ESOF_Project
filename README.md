# "Stock Overflow" Development Report

Bem-vindo às páginas de documentação da "Stock Overflow"!

Aqui poderá encontrar detalhes sobre a "Stock Overflow", doravante referida como módulo, desde uma visão de alto nível até às decisões de implementação de baixo nível, uma espécie de Relatório de Desenvolvimento de Software, organizado por disciplina (conforme o RUP):

* [Business modeling](#Business-modeling)
  * [Product Vision](#Product-Vision)
  * [Functionalities](#Functionalities)
  * [Elevator Pitch](#Elevator-Pitch)
* [Requirements](#Requirements)
  * [Domain model](#Domain-model)
* [Architecture and Design](#Architecture-and-Design)
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Vertical Prototype](#Vertical-Prototype)
* [Project Management](#Project-Management)


Até agora, as contribuições são exclusivamente feitas pela equipa inicial, mas esperamos abri-las à comunidade, em todas as áreas e tópicos: requisitos, tecnologias, desenvolvimento, experimentação, teste, etc.

Por favor, contacte-nos!

Obrigado!

[Diogo Ferreira](https://github.com/DiogoFerreira2004)

[Gabriel Carvalho](https://github.com/GabrielCarvalhoLEIC)

[Rafael Cunha](https://github.com/rafaelcunha02)

[Vasco Melo](https://github.com/pchmelo)

----
## Business modeling

### Product Vision
_"To make the world greener, keep your pantry stock 'cleaner'"._


### Functionalities

#### Signing In:
Obrigatório para os utilizadores:
* E-mail, username, password     (possibilidade de Google acc);

Opcional:
* Personalizaçãodo stock pessoal – Possibilidade de seleccionar produtos de uma lista já prédefinida e/ou adicionar um produto personalizado pela pessoa;

#### Login / Logout:
* Possibilidade de manter a sessão iniciada;
* Users devem iniciar com e-mail ou username e password;
* Recuperar a password se necessário através de username ou e-mail;

#### Validades:
* Lista ordenada com opções de sorting (Alfabético, Quantitativo, Validade, Limiar);
* Calendário (widget) - Destaca os dias em que algum limiar acaba, ao clicar no dia destacado, o utilizador pode obter informação sobre o produto de forma geral;

#### Settings:
Personalização da conta:
* Mudar username, password, e-mail;
* Mudar tema (light/darkmode);

Adicionar/Remover/Editar novos tipos de produto ao stock:
* Ao adicionar/editar, o     usuário poderá adicionar/editar o nome de um produto, imagem, e limiar de     quantidade no stock antes de este ser automáticamente adicionado à lista de compras;
* Adicionar/Editar notificações de Stock/Validade;

#### Stock:
Enumeração dos produtos presentes em stock consoante um sorting escolhido pelo utilizador, com possibilidade de várias opções de sorting;
Tipos de sorting:
* Alfabético;
* Quantitativo;
* Próximidade do limiar establecido;

#### Lista de compras:
* (Onclick) Opção de criar lista ou de ver listas prévias;
* Lista com os produtos que já atingiram o limiar;
* Possibilidade de adicionar e remover produtos;
* Possibilidade de adicionar produtos "extra";
* Checkbox indicativa daquilo que já está no carrinho;

#### Adicionar produto ao Stock:
* Manualmente, ou com código de barras;
* Utilizadores deverão introduzir manualmente a data de validade, caso a considere relevante no produto em questão;
* Se, ao ler o código de barras, a base de dados local não possa identificar o produto, ela vai pedir ao utilizador para associar o código a um determinado produto existente, ou para ele criar um novo produto;


### Elevator Pitch

Alguma vez foste às compras e trouxeste produtos que não precisavas?
Alguma vez deixaste a data de validade de um produto expirar?

Então o "Stock Overflow" é a solução certa para ti! A aplicação que permite gerires o stock da tua dispensa, evitando assim o consumismo desnecessário, através da criação de uma lista de compras com os bens alimentares necessários. Para além disso, ajudará a controlar o desperdício alimentar, provocado por alimentos cujos prazos de validade se encontram ultrapassados, ao emitir notificações personalizaveis, quando a data de validade de um alimento estiver prestes a expirar.

Do que estás à espera? Regista-te hoje mesmo!

---

## Requirements

### Domain Model

#### Elementos:

* Dispensa:
Elemento central ao qual vão ser associados utilizadores, produtos e listas de compras.

* Conta:
Utilizador associado a uma dispensa criada ou à qual concordou ser adicionado.

* Lista de compras:
Associadas a uma dispensa e a vários produtos, conteem uma data de notificação que avisa o utilizador sobre quando comprar.

* Produto:
Adicionável à dispensa e às listas de compras, guarda-se a sua quantidade e um limiar de notificações para quantidade e/ou data de validade expirada

* Validade:
Associada a um produto, dita quantas unidades desse produto existem cuja data de validade expira numa certa data.
 

<img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/img.png?raw=true" alt="Image">


## Architecture and Design

### Logical Architecture

Por motivos relacionados com organização e compreensão do código, assim como do projeto na sua generalidade, este está dividio em duas partes com algumas subpartes.

#### Gerenciamento da Dispensa:
Lógica central do sistema, responsável pelas Interfaces do utilizador e pela comunicação com o back-end.

 
* UI/GUI (Interface do Usuário):
Responsáveis por como os usuários interagem e comunicam com o sistema, através de widgets, botões, entre outros.

* BackEnd:
Lida com tarefas em segundo plano com as quais os usuários não interagem diretamente, como armazenamento e processamento dados. Inclui também o acesso a serviços externos ocasionalmente necessários para reconhecimento de alguns itens

* Base de Dados (Interna):
Armazena os dados do sistema, sendo estes utilizadores, produtos, definições pessoais dos utilizadores, entre outros.

#### Serviços Externos:
Incluem apenas uma base de dados externa, para acesso quando necessário.

* Base de Dados (Externa):
Banco de dados externo ao sistema, com o qual o sistema interage para adquirir informação que não está presente na base de dados interna

#### Package diagram
<img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/packdiagram.png?raw=true" alt="Image">

### Physical Architecture

#### Tecnologias Utilizadas

Essencialmente, esta aplicação faz uso de várias tecnologias internas e externas ao dispositivo do utilizador.

##### Dispositivo Móvel:

* Camêra:
Necessária para o Scan de produtos através de código de barras.

* Acesso à Internet:
Necessário para pesquisa de produtos numa Base de Dados externa após o Scan dos códigos de barras.

##### Aplicação:

* Calendário:
Necessário para todas as funcionalidades envolvendo Datas de Validade e notificações.

* API de leitura de código de barras:
Possibilita a leitura de códigos de barras.

* Estrutura Principal e Base de Dados Interna (verificar o [Package Diagram](#Package-Diagram)


#### Deployment diagram
<img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/deploymentDiagram.png?raw=true" alt="Image">

### Vertical Prototype

#### Já implementado:

* Sign in (com Firebase)
* Log in & Log out (com Firebase)
* Adição e alteração de produtos à Base de Dados
* API de leitura de códigos de barras
* Calendário


##### Página Inicial

Nesta página, encontram-se três botoês que irão direccionar o utilizador a três diferentes APIs implementadas.
O botão de "Calendário" dirige o utilizador a uma API do calendário, o botão de "Scanner" dirige a uma API de scan de códigos de barras para produtos alimentares, enquanto o botão de "Form" dirige a um Form com Firebase implementado.

<img style="width: 20em; height: 35em" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/FirstPageApk.png?raw=true"> 

##### Calendário

Widget que permite a criação e verificação de datas respectivas a Eventos.
<div style="display: flex;">
    <img style="width: 20em; height: 35em" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/CalendarioApk.png?raw=true">
 <img style="width: 20em; height: 35em" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/EventoApk.png?raw=true"></div>


##### Scanner

API de leitura de código de barras que permite identificar produtos através do seu código de barras.

<div style="display: flex;">
    <img style="width: 20em; height: 35em" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/ScannerApk.png?raw=true">
<img style="width: 20em; height: 35em" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/TicketApk.png?raw=true"></div>


##### Firebase

* Sign Up e Log in / Log out:

Interface com dois campos para e-mail e palavra-passe, respectivamente. O e-mail deve, obrigatóriamente, ter um formato válido para que a aplicação o aceite, enquanto a palavra-passe deve ter, no mínimo, seis dígitos.

<div style="display: flex;">
    <img style="width: 20em; height: 35em" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/SignUpFirebase.png?raw=true">
<img style="width: 20em; height: 35em" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/SignInFirebase.png?raw=true"></div>

* Homepage:

Todas as contas criadas são, de momento, associadas à mesma dispensa (base de dados) e é criado um produto associado a cada utilizador, que pode ser alterado pelo utilizador em questão.

<div style="display: flex;">
    <img style="width: 20em; height: 35em" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/arrozFirebase.png?raw=true">
<img style="width: 20em; height: 35em" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/MassaFirebase.png?raw=true"></div>


##### Resultado visível aos administradores no Firebase, após criação de contas:
<img style="width: 60em; height: 35em" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/Firebase.png?raw=true">


## Project management
Nesta secção iremos mostrar como decidimos organizar o nosso projeto. Para isso escolhemos criar uma scrum board com cinco colunas que dividem o projeto em diferentes etapas.
Estas etapas são:

- Product Backlog: Secção onde guardamos todas as funcionalidades que iremos implementar ao longo do projeto
- Sprint Backlog: Secção onde guardamos todas as funcionalidades que iremos implementar durante o sprint atual
- In Progress: Secção onde guardamos todas as funcionalidades que estão neste momento a ser desenvolvidas
- Done: Secção onde guardamos todas as funcionalidades que foram desenvolvidas e à espera de aprovação
- Accepted: Secção onde guardamos todas as funcionalidades que foram desenvolvidas e aceites pelo cliente

### Sprint 1:
- Prints da scrum board durante a realização do primeiro sprint:
<img style="width: 100%; height: 100%" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/Sprint1.png?raw=true">
