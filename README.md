### Clonando o projeto

Primeiro, você precisa clonar o repositório localmente. Você deve fazer isso acessando o repositório do projeto no Bitbucket. O projeto pode ser clonado via SSH ou HTTPS usando o comando git clone no link. Ex.:

- `git clone git@bitbucket.org:indiciumtech/base_dbt_clustering_project.git`

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

### Installing project libraries

O próximo passo é instalar as bibliotecas listadas no arquivo **requirements.txt**.  Isso pode ser feito via [pip](https://pypi.org/project/pip/):

- `pip install -r requirements.txt` or

- `python -m pip install -r requirements.txt` for some cases where the previous command doesn't work.

Para verificar se todas as bibliotecas foram instaladas corretamente, use **pip list** e valide as bibliotecas e suas respectivas versões listadas.

### Configurando *profiles.yml* 

Como boa prática, será necessário criar um arquivo **.env (dotenv)** dentro do ambiente do seu projeto, seguindo o modelo do arquivo env.example. Para fazer isso, basta copiar o arquivo e colá-lo no mesmo local, renomeando-o para .env e preenchendo as informações solicitadas. 

Para obter o arquivo token.json, é preciso criar uma service_account dentro do ambiente da GCP para conectar o dbt com o Big Query.
    [Passo a Passo](https://medium.com/@camila-marquess/criando-um-projeto-no-dbt-utilizando-o-bigquery-c49fc8375aa2)
