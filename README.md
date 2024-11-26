# EventsSi
Para este projeto, não foi utilizada storyboard, foi utizado view code, pelo motivo de evitar possíveis conflitos na hora de comitar o código.

Neste projeto comecei pela conexão com API, criando a classe de conexão e os modelos.

## Bibliotecas

Para este projeto não foi utilizada nenhuma biblioteca
 
## Instrução

Acessar a pasta do projeto;

Abra o Xcode -> File -> Open -> Selecione a pasta onde o projeto foi salvo -> Abra o arquivo Digio.xcodeproj;

Após o projeto aberto precionar o botão de execução, ou atráves das teclas cmd + R. 

### Objetivo do Aplicativo

O aplicativo tem como objetivo de apresentar os produtos que a empresa oferece.

### Breve Descrição

Ao abrir o app, poderá demorar alguns segundo para aparecer os produtos. Na tela principal do app, existe uma lista de categorias, dentro de cada categoria existe uma lista na horizontal, onde o usuário poderá realizar a rolagem para a direita e esquerda, caso haja mais produtos nas listas de categorias. O usuário pode clicar em qualquer produto, quando fizer isso será mostrada as informações do mesmo. Na tela dos detalhes o usuário também poderá realizar a rolagem, para que possa visualizar mais informações do produto caso seja necessário. Também na tela de detalhes existe um botão ao final da tela para que o usuário possa contratar o produto, mas esse botão hoje ainda não tem nenhuma função, apenas mostra uma mensagem no console para que seja itentificado que o botão está sendo precionado.

### Funcionalidades Implementadas

- Listagem de produtos dividida por categorias;
- Detalhes do produto.

### Tomadas de Decições

  - Optei por utilizar a arquitetura MVVM-C, onde o C é de Coordinator, para facilitar as rotas das telas do app;
  - Optei por separar a View da ViewController para facilitar a alteração de layout no futuro;
  - Para criar as listas de produtos por categoria criei um Factory, para facilicar a criação da lista de produtos na tela principal; 
  - Me basei no layout da tela que me foi passado, para desenvolver a tela principal, mas como não tinha as dimenssões exatas, tive que tentar encontrar no olho os valores, por isso, pode haver algum espaçamento ou fonte que não está conforme o layoute passado;
  - O logo que está na tela principal e na abertura do app, também não foi fornecido e tentei criar o mais próximo possível do que foi definido;
  - A tela de detalhes, criei com o que eu acedito ser o mais interessante para o usuário. Tendo a imagem do produto que ele selecionou, o nome, a descrição e o botão para comprar;
  - Defini cores para o app, assim quando mudar o estilo do celular para o dark mode, não sofrerá com as alterações de cores;
  - Para esse projeto, optei em desenvolver em view code, para não haver problemas de conflito com a storyboard e nem com a xib, e para ter um controle melhor sobre os componentes que estou adicionando na tela;
  - Optei por não colocar nenhum efeito, pois o tempo do projeto não daria tempo, pois teria que estudar efeitos visuais em view code.

### Testes

Para executar os testes, com o projeto aberto no Xcode é só pressionar as teclas Command + u.

### Melhorias

Colocar loading na tela onde os dados são carregados, e no carregamento da imagem, não coloquei pelo tempo curto do projeto, e pelo fato de me focar na solução das principais funcionalidades e nos testes unitários, que estão em 85% de coverge.
