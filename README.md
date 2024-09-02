### Clonando o projeto

Primeiro, você precisa clonar o repositório localmente. Você deve fazer isso acessando o repositório do projeto no Bitbucket. O projeto pode ser clonado via SSH ou HTTPS usando o comando git clone no link. Ex.:

- `git clone git@github.com:nicole-malaquias/adventureWorks.git`

### Criando um ambiente virtual

Você precisa criar um ambiente virtual na pasta raiz do projeto (caso ainda não tenha feito isso).

- `python3 -m venv venv` or

- `py -3.8 -m venv venv` for Bash on Windows.

Se você também tiver uma versão posterior ao Python 3.8 instalada **(Python 3.9, por exemplo, ainda contém bugs para executar o dbt)**, prefira usar a versão 3.8. A versão do Python usada neste projeto é a 3.8.10.

Além disso, o ambiente virtual deve ser ativado toda vez que você abrir o projeto através do comando:

- `source venv/bin/activate` on Linux or

- `source venv/Scripts/activate` in bash on Windows, or else

- `.\venv\Scripts\activate.ps1` in Windows PowerShell

Certifique-se de que você está na pasta onde o ambiente virtual foi criado. Se estiver habilitado corretamente, o terminal terá uma indicação **(venv)** na frente do nome de usuário antes de cada comando. Para desativar o ambiente virtual, basta executar:

- `deactivate`

### Instalando bibliotecas de projeto

O próximo passo é instalar as bibliotecas listadas no arquivo **requirements.txt**.  Isso pode ser feito via [pip](https://pypi.org/project/pip/):

- `pip install -r requirements.txt` ou

- `python -m pip install -r requirements.txt`

Para verificar se todas as bibliotecas foram instaladas corretamente, use **pip list** e valide as bibliotecas e suas respectivas versões listadas.

### Configurando *profiles.yml*

Como boa prática, será necessário criar um arquivo **.env (dotenv)** dentro do ambiente do seu projeto, seguindo o modelo do arquivo env.example. Para fazer isso, basta copiar o arquivo e colá-lo no mesmo local, renomeando-o para .env e preenchendo as informações solicitadas. 

Para obter o arquivo token.json, é preciso criar uma service_account dentro do ambiente da GCP para conectar o dbt com o Big Query.
    [Passo a Passo](https://medium.com/@camila-marquess/criando-um-projeto-no-dbt-utilizando-o-bigquery-c49fc8375aa2)


### Ingestão dos dados 

A ingestão dos dados no BigQuery foi realizada utilizando o comando seeds do dbt.

O comando seeds permite carregar rapidamente dados estáticos ou pequenos conjuntos de dados em tabelas do data warehouse. Esses dados geralmente estão armazenados em arquivos CSV que são colocados na pasta data do projeto dbt. Ao executar o comando dbt seed, os arquivos CSV são lidos e transformados em tabelas no BigQuery, facilitando a criação de dados de referência ou configurando dados iniciais que podem ser utilizados nas transformações posteriores.

### Techoloagias Utilizadas


#### DBT CORE

O dbt (data build tool) é uma framework de código aberto que permite a transformação de dados diretamente no data warehouse, usando SQL. Ele facilita o desenvolvimento, a organização e a manutenção de pipelines de dados, promovendo uma abordagem modular e colaborativa. Com o dbt, é possível criar, testar e documentar modelos SQL, tornando o processo de ETL (Extract, Transform, Load) mais eficiente e versionado, integrando práticas de engenharia de software ao desenvolvimento de pipelines de dados. [Mais informações](https://medium.com/@felipeprintes/fundamentos-dbt-4ded66016b25),[Documentação Oficial](https://www.getdbt.com/product/what-is-dbt)


#### BIG QUERY

O BigQuery é um serviço de armazenamento e análise de dados em nuvem oferecido pelo Google Cloud. Ele é projetado para processar grandes volumes de dados de forma rápida e eficiente, utilizando a infraestrutura escalável do Google. [Mais informações](https://medium.com/@vkrntkmrsngh/getting-started-with-bigquery-c1d69c262dcb)


#### Hierarchical Forecast da NIXTLA

O Hierarchical Forecast da Nixtla é uma ferramenta avançada para previsão de séries temporais hierárquicas. Ela permite realizar previsões em diferentes níveis de uma hierarquia, como país, região, loja e produto, garantindo que as previsões sejam consistentes em todos os níveis da hierarquia. Utilizando métodos de reconciliação hierárquica, a ferramenta ajusta as previsões para que elas façam sentido tanto no nível mais granular quanto no nível mais agregado. [Documentação Oficial](https://nixtlaverse.nixtla.io/hierarchicalforecast/index.html)

#### Sklearn

O scikit-learn (ou sklearn) é uma biblioteca de código aberto em Python amplamente utilizada para machine learning e análise de dados. Ela oferece ferramentas simples e eficientes para mineração de dados e análise preditiva. [Documentação Oficial](https://scikit-learn.org/stable/modules/linear_model.html)


### Arquitetura do projeto

```
├── analyses
├── dbt_packages
│   └── dbt_utils
│       ├── CHANGELOG.md
│       ├── CONTRIBUTING.md
│       ├── dbt_project.yml
│       ├── dev-requirements.txt
│       ├── doc
│       ├── docker-compose.yml
│       ├── etc
│       ├── integration_tests
│       ├── LICENSE
│       ├── macros
│       ├── Makefile
│       ├── pytest.ini
│       ├── README.md
│       ├── RELEASE.md
│       ├── run_functional_test.sh
│       ├── run_test.sh
│       └── tests
├── dbt_project.yml
├── macros
│   └── generate_schema_name.sql
├── models
│   ├── aggregate
│   │   ├── agg_sales_forecast.sql
│   │   └── agg_sales_forecast.yml
│   ├── intermediate
│   │   ├── int_order_reason.sql
│   │   ├── int_order_reason.yml
│   │   ├── int_product.sql
│   │   └── int_product.yml
│   ├── marts
│   │   ├── dim_order_reason.sql
│   │   ├── dim_order_reason.yml
│   │   ├── dim_person_address.sql
│   │   ├── dim_person_address.yml
│   │   ├── dim_person.sql
│   │   ├── dim_person.yml
│   │   ├── dim_product_inventory.sql
│   │   ├── dim_product_inventory.yml
│   │   ├── dim_product.sql
│   │   ├── dim_product.yml
│   │   ├── dim_purchase_order_detail.sql
│   │   ├── dim_purchase_order_detail.yml
│   │   ├── dim_sales_creditcard.sql
│   │   ├── dim_sales_customer.sql
│   │   ├── dim_sales_customer.yml
│   │   ├── dim_sales_territory.sql
│   │   ├── dim_sales_territory.yml
│   │   ├── dim_shipmethod.sql
│   │   ├── dim_shipmethod.yml
│   │   ├── fct_order_detail.sql
│   │   └── fct_order_detail.yml
│   └── staging
│       ├── source_person.yml
│       ├── source_product.yml
│       ├── source_purchase.yml
│       ├── source_sales.yml
│       ├── stg_person_address.sql
│       ├── stg_person_country.sql
│       ├── stg_person_person.sql
│       ├── stg_person_state_province.sql
│       ├── stg_product_category.sql
│       ├── stg_product_inventory.sql
│       ├── stg_product.sql
│       ├── stg_product_subcategory.sql
│       ├── stg_purchase_order_detail.sql
│       ├── stg_purchase_order_header.sql
│       ├── stg_purchase_ship_method.sql
│       ├── stg_sales_creditcard.sql
│       ├── stg_sales_customer.sql
│       ├── stg_sales_order_detail.sql
│       ├── stg_sales_order_header_reason.sql
│       ├── stg_sales_order_header.sql
│       ├── stg_sales_person.sql
│       ├── stg_sales_reason.sql
│       ├── stg_sales_store.sql
│       └── stg_sales_territory.sql
├── notebooks
│   └── time_series_forecasting.ipynb
├── package-lock.yml
├── packages.yml
├── profiles.yml
├── README.md
├── requirements.txt
├── seeds
│   └── sap_adventure_works
│       ├── human_resources
│       ├── person
│       ├── production
│       ├── purchasing
│       ├── sales
│       └── seed_schema.yml
├── target
│   ├── compiled
│   │   └── adventure_works
│   ├── graph.gpickle
│   ├── graph_summary.json
│   ├── manifest.json
│   ├── partial_parse.msgpack
│   ├── run
│   │   └── adventure_works
│   ├── run_results.json
│   └── semantic_manifest.json
├── tests
│   └── group_territory_values_test.sql
```

## Arquitetura da Pasta Models

### Staging

Após concluir a organização inicial do projeto, dentro de uma área de foco, os marts que deseja criar e identificar as tabelas fonte necessárias para a modelagem.

A criação da pasta "stagings" foi estabelecida para simplificar o processo de localização dos arquivos que o analista precisa. As atividades realizadas na pasta "staging" incluem:

- Seleção de colunas
- Renomeação de colunas
- Conversão de tipos de dados (cast)
- Achatamento de objetos estruturados
- Aplicação de filtros iniciais
- Execução de testes (source.yml)


### Intermediate

Na camada Intermediate é onde ocorre a preparação dos dados para direcioná-los aos marts. Nem todas as tabelas da camada staging serão transformadas em intermediate. Nessa etapa, é possível combinar diferentes tabelas para começar a definir as regras de negócio.

O que se faz na camada Intermediate:

- Realização de joins entre diferentes queries da camada staging
- Aplicação de funções mais complexas que não se encaixam na camada staging
- Realização de agregações
- Desenvolvimento de métricas e regras de negócio

O que não se faz na camada Intermediate:

- Carregamento de fontes (sources)
- Modelagem dimensional (separação entre fatos, dimensões e marts)

### Marth

Na pasta Marts, realizamos a organização dos dados para o modelo dimensional.

O que se faz na camada Marts:

- Estruturação dos dados em um modelo dimensional (esquema em estrela)
- Criação de chaves surrogate keys (SK)
- Realização de ajustes específicos para o mart
- Execução de joins entre tabelas da camada staging e/ou intermediate
Documentação e realização de testes

- O que não se faz na camada Marts:
- Limpeza de dados
- Carregamento de tabelas da camada staging

### Aggregate

A Aggregate é uma tabela que armazena os dados da fato com o menor nível de granularidade. Nesta tabela, os dados são consolidados para permitir análises mais rápidas e eficientes, mantendo informações essenciais para relatórios e dashboards. A Aggregate facilita o acesso a dados resumidos, preservando o detalhamento necessário para insights aprofundados.

## Pasta Notebooks

A pasta notebook é onde estão localizados os notebooks que contêm as análises e implementações relacionadas à parte de data science do projeto.


## Futuras Melhorias

#### Ingestão de Dados
Explorar métodos mais eficientes de ingestão, como o uso de pipelines de ETL automatizados, para melhorar o fluxo de dados e a escalabilidade do projeto.

#### Utilização de Spark
Integrar o Apache Spark para realizar predições mais robustas e escaláveis, aproveitando seu poder de processamento distribuído para lidar com grandes volumes de dados e modelos mais complexos.
