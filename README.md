# FEUP - Software Engineering - 2023/2024
> Curricular Unit: ES - [Engenharia de Software](https://sigarra.up.pt/feup/pt/ucurr_geral.ficha_uc_view?pv_ocorrencia_id=520322)

## 2nd Year - 2st Semester - Group Project

Welcome to the documentation pages of the "Nome da Aplicação"!

You can find here detailed about "Nome da Aplicação", hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report , organized by discipline (as of RUP):

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
  * [Functionalities](#Functionalities)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

----
## Product Vision
As pessoas usam  a "Nome da Aplicação" para gerir o stock das suas dispensas e evitar o desperdício alimentar.

----
## Elevator Pitch

Alguma vez foste às compras e trouxeste produtos que não precisavas?

Instala o/a "Nome da Aplicação". A aplicação que permite gerir o stock da dispensa, evitando assim o consumismo desnecessário, através da criação de uma lista de compras com os bens alimentares necessários. Para além disso, ajudará a controlar o desperdício alimentar, provocado por alimentos cujos prazos de validade se encontram ultrapassados, ao emitir notificações com lembretes, quando a data de validade de um alimento estiver prestes a expirar.

De que estás à espera? Regista-te hoje mesmo!

---
## Functionalities

#### Signing In:
Obrigatório para os users:
* E-mail, username, password     (possibilidade de Google acc);

Opcional:
* Personalizaçãodo stock pessoal – Possibilidade de seleccionar produtos de uma lista já prédefinida e/ou adicionar um produto personalizado pela pessoa;

#### Login / Logout:
* Possibilidade de manter a sessão iniciada;
* Users devem iniciar com e-mail ou username e password;
* Recuperar a password se necessário através de username ou e-mail;


<img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/blob/main/Images/LoginLogout.png?raw=true" alt="Login Logout Image" width="300" height="200">

#### Validades:
* Lista ordenada com sorting options (Alfabético, Quantitativo, Validade, Limiar);
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

---
## User Stories

**FEATURE**: Pesquisar Produtos <br />
    Como cliente <br />
    Eu quero poder procurar por produtos específicos <br />
    Para que possa encontrar facilmente os itens que desejo <br />

### Acceptance tests
```Gherkin
Scenario:  Pesquisar produtos
  Given Existem produtos previamente inseridos numa base de dados
  When Executo uma pesquisa de um produto presente na base de dados
  Then Encontro o produto desejado
```


### Value and effort
* Value: Must have
* Effort: 5

**FEATURE**: Analisar Produtos <br />
    Como utilizador <br />
    Eu quero poder ver informação detalhada sobre cada produto <br />
    Para que possa tomar decisões conscientes relativamente às minhas compras <br />

### Acceptance tests
```Gherkin
Scenario:  Analisar Produtos
  Given Eu tenho uma lista de produtos
  When Eu clico num produto
  Then Eu acedo a toda a informação detalhada disponível sobre o produto
```


### Value and effort
* Value: Should have
* Effort: 1

**FEATURE**: Adicionar Produtos À Lista De Compras <br />
    Como utilizador <br />
    Eu quero poder adicionar produtos à minha lista de compras <br />
    Para que possa saber quais produtos preciso de comprar <br />

### Acceptance tests
```Gherkin
Scenario:  Adicionar Produtos À Lista De Compras
  Given Eu tenho uma lista de compras criada
  When clico no botão "+"
  And Seleciono o produto que quero
  Then O produto é adicionado à minha lista de compras
```
 

### Value and effort
* Value: Must have
* Effort: 3

**FEATURE**: Atualizar Catálogo De Produtos <br />
    Como gestor de stock <br />
    Eu quero poder adicionar, editar e remover produtos do inventário <br />
    Para que possa manter o catálogo de produtos atualizado <br />

### Acceptance tests
```Gherkin
Scenario:  Atualizar Descrição De Produtos
  Given Eu sou gestor de stock
  When Eu altero a descrição de um produto
  Then Essa descrição fica disponível para os utilizadores
```

```Gherkin
Scenario:  Remover Produtos do catálogo
  Given Eu sou gestor de stock
  When Eu removo um produto do catálogo
  Then Esse produto deixa de estar disponível para os utilizadores
```

```Gherkin
Scenario:  Adicionar Produtos do catálogo
  Given Eu sou gestor de stock
  When Eu adiciono um produto do catálogo
  Then Esse produto fica disponível para os utilizadores
```


### Value and effort
* Value: Must have
* Effort: 5

**FEATURE**: Partilhar De Inventário <br />
    Como utilizador <br />
    Eu quero poder partilhar o meu inventário com quem vive comigo <br />
    Para que possamos colaborar nas compras e evitar compras desnecessárias <br />

### Acceptance tests
```Gherkin
Scenario:  Partilhar iventários
  Given Eu e outras pessoas temos um inventário em comum
  When Eu entro na conta associada a esse inventário
  Then Consigo aceder a todas as informações relativas a esse inventário
```


### Value and effort
* Value: Could have
* Effort: 100

**FEATURE**: Notificações Falta De Stock <br />
    Como utilizador <br />
    Quero poder receber notificações de falta de produto em stock <br />
    Para evitar que me esqueça de comprar certos produtos que necessito <br />

### Acceptance tests
```Gherkin
Scenario:  Notificações Falta de Stock
  Given Eu tenho um determinado produto
  When Esse produto fica fora de stock ou baixa do limiar que eu estabeleci
  Then Recebo uma notificação, para me lembrar de comprar esse produto
```


### Value and effort
* Value: Should have
* Effort: 40

**FEATURE**: Notificações Data De Validade Prestes A Expirar <br />
    Como utilizador <br />
    Quero poder receber notificações quando a data de validade dos meus produtos estiver prester a expirar <br />
    Para evitar que estes se estraguem e me ajudar a combater o desperdício alimentar <br />

### Acceptance tests
```Gherkin
Scenario:  Notificações Data De Validade Prestes A Expirar
  Given Eu tenho um determinado produto
  When A data de validade desse produto estiver prestes a expirar
  Then Recebo uma notificação, para me lembrar de consumir o produto, evitando que este se estrague
```


### Value and effort
* Value: Must have
* Effort: 40

**FEATURE**: Filtrar Resultados De Pesquisa <br />
    Como utilizador <br />
    Eu quero poder filtrar produtos por ordem alfabética, quantitativa, ou por proximidade de limiares <br />
    Para que possa melhorar os resultados da minha pesquisa <br />

### Acceptance tests
```Gherkin
Scenario:  Filtrar Resultados de Pesquisa por ordem alfabética
  Given Eu executo uma determinada pesquisa
  When Filtro os resultados dessa pesquisa por ordem alfabética
  Then Os produtos devem me aparecer no ecrã por ordem alfabética
```


```Gherkin
Scenario:  Filtrar Resultados de Pesquisa por ordem quantitativa
  Given Eu executo uma determinada pesquisa
  When Filtro os resultados dessa pesquisa por ordem quantitativa
  Then Os produtos devem me aparecer conforme as suas quantidades em stock
```


```Gherkin
Scenario:  Filtrar Resultados de Pesquisa por proximidade de limiares
  Given Eu executo uma determinada pesquisa
  When Filtro os resultados dessa pesquisa por proximidade de limiares
  Then Os produtos devem me aparecer conforme a sua proximidade ao limiar estabelecido
```


### Value and effort
* Value: Could have
* Effort: 1

**FEATURE**: Recuperar Password <br />
    Como utilizador <br />
    Eu quero poder recuperar a minha password <br />
    Para que possa aceder à minha conta mesmo que esqueça a password <br />

### Acceptance tests
```Gherkin
Scenario:  Recuperar password
  Given Eu perdi a minha password
  When Eu solicito uma nova passe
  And Confirmo a minha identidade através do email associado a conta
  Then Consigo escolher uma nova password
```


### Value and effort
* Value: Will not have yet
* Effort: 40

**FEATURE**: Visualizar E Alterar Definições De Conta <br />
    Como utilizador <br />
    Eu quero poder visualizar e alterar as definições da minha conta <br />
    Para que possa manter a minha informação atualizada e personalizar a minha experiência <br />

### Acceptance tests
```Gherkin
Scenario:  A implementar...
  Given 
  When 
  Then 
```


### Value and effort
* Value: Could have
* Effort: 20

**FEATURE**: Criar E Gerir Listas De Compras <br />
    Como utilizador <br />
    Eu quero poder criar e gerir várias listas de compras <br />
    Para que possa organizar-me para várias ocasiões e contextos diferentes  <br />

### Acceptance tests
```Gherkin
Scenario:  A implementar...
  Given 
  When 
  Then 
```


### Value and effort
* Value: Must have
* Effort: 8


**FEATURE**: Modo Offline <br />
    Como utilizador <br />
    Eu quero poder aceder à app em modo offline <br />
    Para que possa ter os seus beneficios sem necessidade de internet <br />

### Acceptance tests
```Gherkin
Scenario:  A implementar...
  Given 
  When 
  Then 
```


### Value and effort
* Value: Could have
* Effort: 13


**FEATURE**: Manter Sessão Iniciada <br />
    Como utilizador <br />
    Eu quero poder manter a minha sessão iniciada <br />
    Para que não tenha de inserir as minhas credenciais sempre que abra a App <br />

### Acceptance tests
```Gherkin
Scenario:  A implementar...
  Given 
  When 
  Then 
```

### Value and effort
* Value: Will not have yet
* Effort: 20

---
### Developed by:

1. Diogo Ferreira - E-mail: up202205295@edu.fe.up.pt
2. Gabriel Carvalho - E-mail: up202208939@edu.fe.up.pt
3. Rafael Cunha - E-mail: up202208957@edu.fe.up.pt
4. Vasco Melo - E-mail: up202207564@edu.fe.up.pt
