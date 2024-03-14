# FEUP - Software Engineering - 2023/2024
> Curricular Unit: ES - [Engenharia de Software](https://sigarra.up.pt/feup/pt/ucurr_geral.ficha_uc_view?pv_ocorrencia_id=520322)

## 2nd Year - 2st Semester - Group Project

### Brief description:

Este projeto consiste na criação de uma aplicação, com fins ecológicos. Para tal, os alunos responsáveis pela elaboração deste projeto decidiram desenvolver uma aplicação que permite gerir o stock da dispensa, evitando assim o consumismo desnecessário, através da criação de uma lista de compras com os bens alimentares necessários. Para além disso, ajudará a controlar o desperdício alimentar, provocado por alimentos cujos prazos de validade se encontram ultrapassados, ao emitir notificações com lembretes, quando a data de validade de um alimento estiver prestes a expirar.

### Functionalities:

#### Signing In:
Obrigatório para os users:
* E-mail, username, password     (possibilidade de Google acc);

Opcional:
* Personalizaçãodo stock pessoal – Possibilidade de seleccionar produtos de uma lista já prédefinida e/ou adicionar um produto personalizado pela pessoa;

#### Login / Logout:
* Possibilidade de manter a sessão iniciada;
* Users devem iniciar com e-mail ou username e password;
* Recuperar a password se necessário através de username ou e-mail;

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

### User Stories

**FEATURE**: Pesquisar Produtos
    Como cliente
    Eu quero poder procurar por produtos específicos
    Para que possa encontrar facilmente os itens que desejo

**FEATURE**: Analisar Produtos
    Como utilizador
    Eu quero poder ver informação detalhada sobre cada produto
    Para que possa tomar decisões conscientes relativamente às minhas compras

**FEATURE**: Adicionar Produtos À Lista De Compras
    Como utilizador
    Eu quero poder adicionar produtos à minha lista de compras
    Para que possa saber quais produtos preciso de comprar

**FEATURE**: Atualizar Catálogo De Produtos
    Como gestor de stock
    Eu quero poder adicionar, editar e remover produtos do inventário
    Para que possa manter o catálogo de produtos atualizado

**FEATURE**: Partilhar De Inventário
    Como utilizador
    Eu quero poder partilhar o meu inventário com quem vive comigo
    Para que possamos colaborar nas compras e evitar compras desnecessárias

**FEATURE**: Notificações Falta De Stock
    Como utilizador
    Quero poder receber notificações de falta de produto em stock
    Para evitar que me esqueça de comprar certos produtos que necessito

**FEATURE**: Notificações Data De Validade Prestes A Expirar
    Como utilizador
    Quero poder receber notificações quando a data de validade dos meus produtos estiver prester a expirar
    Para evitar que estes se estraguem e me ajudar a combater o desperdício alimentar

**FEATURE**: Filtrar Resultados De Pesquisa
    Como utilizador
    Eu quero poder filtrar produtos por ordem alfabética, quantitativa, ou por proximidade de limiares
    Para que possa melhorar os resultados da minha pesquisa 

**FEATURE**: Recuperar Password
    Como utilizador
    Eu quero poder recuperar a minha password
    Para que possa aceder à minha conta mesmo que esqueça a password

**FEATURE**: Visualizar E Alterar Definições De Conta
    Como utilizador
    Eu quero poder visualizar e alterar as definições da minha conta
    Para que possa manter a minha informação atualizada e personalizar a minha experiência

**FEATURE**: Criar E Gerir Listas De Compras
    Como utilizador
    Eu quero poder criar e gerir várias listas de compras
    Para que possa organizar-me para várias ocasiões e contextos diferentes 

**FEATURE**: Gerir Privacidade
    Como utilizador preocupado com a privacidade
    Quero poder controlar as minhas preferências quanto à forma como a minha informação é usada
    Para poder fazer decisões informadas quanto à privacidade dos meus dados

**FEATURE**: Modo Offline
    Como utilizador
    Eu quero poder aceder à app em modo offline
    Para que possa ter os seus beneficios sem necessidade de internet

**FEATURE**: Reportar Erros
    Como utilizador preocupado com a qualidade
    Eu quero poder reportar problemas, ( tais como informação de produtos errada, etc.)
    Para que o Staff possa manter a qualidade da App

**FEATURE**: Manter Sessão Iniciada
    Como utilizador
    Eu quero poder manter a minha sessão iniciada
    Para que não tenha de inserir as minhas credenciais sempre que abra a App
    
### Developed by:

1. Diogo Ferreira - E-mail: up202205295@edu.fe.up.pt
2. Gabriel Carvalho - E-mail: up202208939@edu.fe.up.pt
3. Rafael Cunha - E-mail: up202208957@edu.fe.up.pt
4. Vasco Melo - E-mail: up202207564@edu.fe.up.pt