# Changelog

Log com todas as adições e mudanças que foram realizadas ao longo do projeto.

## Sprint 2 30-4-2024

### Novas Adições:

- Criar lista de compras
- Editar lista de compras
- Eliminar lista de compras
- Finalizar a lista de compras (todos os produtos que estão selecionados são adicionados automáticamente ao Stock)
- Criar, Editar e Eliminar datas de Validade para os produtos
- Integração do sistema de validades na interface de adição de produtos
- Animações de transição de página
- Implementação de filtros de pesquisa para produtos e para validades

### Alterações:

- Reformulação do formulário de Log-In / Sign Up
- Reformulação da interface de adição do produto
- Reestruturação do design de diversas páginas

### Remoções:

- Remoção de páginas intermediárias na interface de adição de produtos


### Descrição:

Neste sprint, houve um grande foco na continuação da implementação das funcionalidades previstas para a aplicação. Foi desenvolvida toda uma nova página (relativa às listas de compras) e aprofundada a lógica de outras páginas já pré-estabelecidas. Desta forma, procura-se concluir o back-end da aplicação com mais antecedência, para que as tarefas finais sejam maioritariamente relativas a retoques a nível de front-end e correcção de bugs, para deixar o ciclo de criação da aplicação mais estável.


### Apontamentos:

Uma vez que, tal como no Sprint anterior, a interface do Calendário ainda não foi implementada, essa página continua inacessível no APK.


## Links para as releases:

- <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/releases/tag/Sprint_1">Sprint2</a>





## Sprint 1 12-4-2024

### Novas Adições:

- Criar um produto 
- Editar um produto
- Eliminar um produto
- Visualizar detalhes do produto
- Pesquisar por um produto
- Adicionar um produto à Dispensa através de código de barras
- Manter a sessão iniciada após o log-in

### Descrição:


Inicialmente, nós acreditavamos que haveriam softwares de conversão de mock-ups para Flutter (Dart), o que iria facilitar na criação dos Designs já pré-establecidos pelo grupo no Sprint 0. 
No entanto, fomos confrontados pelo facto que estes softwares não funcionaram, de todo, como esperado. 
Decidimos então desenvolver toda a aplicação de raíz, o que levou, numa fase inícial, à alocação de algum tempo dedicado a estabelecer a aplicação em si, de forma a que fosse possível realmente programar algo em concreto. 
Após algum trabalho, conseguimos não só implementar as páginas criadas em mock-ups, mas também as features propostas com base de dados inserida (Firebase). 
Além disso, já foram implementados testes de Gherklin em formato .feature (não estão optimizados, uma vez que o Package responsável pela realização desses testes está desatualizado), assim como testes unitários para os modelos pelos quais optamos, por enquanto.

### Apontamentos:

Vale notar que, no APK desta Release, a página do Calendário (4a a contar da Esquerda), embora funcione perfeitamente no Emulador do Android Studio, fica completamente em branco quando é clicada. 
Procuraremos resolver este problema antes da próxima entrega.

## Links para as releases:

- <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/releases/tag/Sprint_1">Sprint 1</a>
