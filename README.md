🚀 Arquivos e Scripts Principais
1. buildImages.sh
Este script automatiza o processo de:

Clonar o repositório dos serviços (app e syncservice) na pasta temporária servicos.

Copiar arquivos de ambiente .envApp e .envSync para as respectivas pastas dos serviços.

Copiar a pasta prisma para os serviços, garantindo que o ORM Prisma esteja disponível.

Executar o script buildImages.sh dentro das pastas dos serviços para gerar as imagens Docker com a tag da versão fornecida.

Limpar a pasta temporária após a geração das imagens.

Como funciona:

```bash
version=':v1' # Versão da imagem, pode ser alterada para v2, v3 etc

# Remove a pasta temporária servicos caso exista
rm -rf servicos

# Clona o repositório do desafio na pasta servicos
git clone git@github.com:TiagoMCFreitas/desafio-tecnico-truther.git servicos

# Prepara e gera imagem para o serviço APP
cp .envApp servicos/app
cd servicos/app
mv .envApp .env
cp ../prisma -r .
bash buildImages.sh $version
cd ../..

# Prepara e gera imagem para o serviço SYNC SERVICE
cp .envSync servicos/syncservice
cd servicos/syncservice
mv .envSync .env
cp ../prisma -r .
bash buildImages.sh $version
cd ../..

# Remove a pasta temporária
rm -rf servicos

echo "FINALIZADO"
```
2. docker-compose.yml
Arquivo de configuração para orquestrar os containers Docker dos serviços e do banco PostgreSQL.

```yaml
yaml
Copiar
Editar
services:
  app:
    image: desafiotecnico-app:v1
    ports:
      - 127.0.0.1:8082:8080
    restart: always

  syncservice:
    image: desafiotecnico-syncservice:v1
    restart: always

  banco:
    image: postgres
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: postgres
    ports:
      - "54332:5432"
    volumes:
      - ./data:/var/lib/postgresql/data
```
Detalhes:

app: Serviço principal da aplicação, exposto localmente na porta 8082.

syncservice: Serviço secundário que roda em background.

banco: Container PostgreSQL configurado com usuário e senha padrão, persistindo dados na pasta local ./data.

⚙️ Como usar
Gerar as imagens

```bash bash buildImages.sh :v1```
Troque :v1 para a versão que desejar. O script atualizará as imagens para essa tag.

Rodar os containers
```bash docker-compose up -d```
Parar e remover containers

```bash docker-compose down```
📝 Observações
Certifique-se de ter o Docker e Docker Compose instalados na sua máquina.

O script buildImages.sh dentro das pastas app e syncservice deve conter os comandos para buildar as imagens Docker específicas desses serviços.

As variáveis de ambiente .envApp e .envSync devem conter as configurações necessárias para os serviços funcionarem corretamente.
