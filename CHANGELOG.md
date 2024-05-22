# Changelog

Log com todas as adições e mudanças que foram realizadas ao longo do projeto.

## Sprint 3 22-05-2024

### Novas Adições:

- Utilizadores recebem alertas quanto à validade de produtos (<a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/26">Issue</a>)
- Utilizadores passam a poder colocar imagens como ícones de produtos (<a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/28">Issue</a>)
- Utilizadores passam a poder alterar as definições de conta (<a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/29">Issue</a>)

### Alterações:

- Continuação da melhoria do front-end da aplicação em geral (<a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/13">Issue 1</a>)
(<a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/30">Issue 2</a>)


- Melhoria na funcionalidade do calendário (<a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/27">Issue</a>)

### Bugs corrigidos:

- Bug na barra de Scan (<a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/14">Issue</a>)
- Erros nos formulários
- Atualização de dados sob certos contextos
- Bugs de reload de página
- Erros lógicos

### Remoções:

- Remoção de páginas intermediárias na interface de adição de produtos


### Descrição:

Neste sprint, o principal objectivo foi melhorar e optimizar aquilo que já estava implementado. Focamo-nos principalmente em melhorar a interface, deixando-a mais consistente e amigável para melhorar a experiência do utilizador na aplicação. Existiu também um foco em eliminar quaisqueres bugs existentes.

## Links para as releases:

- <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/releases/tag/Sprint_3">Sprint3</a>



## Sprint 2 30-4-2024

### Novas Adições:

- Criar lista de compras, Editar e Eliminar Listas de Compras <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/20">(Issue 1)</a> <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/16">(Issue 2)</a>
- Finalizar a lista de compras (todos os produtos que estão selecionados são adicionados automáticamente ao Stock)
- Criar, Editar e Eliminar datas de Validade para os produtos <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/21">(Issue)</a>
- Integração do sistema de validades na interface de adição de produtos <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/21">(Issue)</a>
- Animações de transição de página <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/19">(Issue)</a>
- Implementação de filtros de pesquisa para produtos e para validades <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/22">(Issue)</a>

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

- <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/releases/tag/Sprint_2">Sprint2</a>





## Sprint 1 12-4-2024

### Novas Adições:

- Criar um produto <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/7">(Issue)</a>
- Editar um produto <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/9">(Issue)</a>
- Eliminar um produto <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/8">(Issue)</a>
- Visualizar detalhes do produto <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/10">(Issue)</a>
- Pesquisar por um produto <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/11">(Issue)</a>
- Adicionar um produto à Dispensa através de código de barras <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/6">(Issue)</a>
- Manter a sessão iniciada após o log-in <a href="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC14T3/issues/12">(Issue)</a>

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
