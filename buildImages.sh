version=':v1' # Versao Inicial
#echo "TROCAR A VERSAO DAS IMAGENS EM docker-compose.yml"
#sed -i'' -e 's/:v1/:v2/g' docker-compose.yml

echo "GERAR IMAGENS DESAFIO-TECNICO-TRUTHER ${version}"

echo "IMAGENS DOS SERVICOS - app / syncservice"
if [ -d "servicos" ]; then
        rm -rf servicos
fi
git clone git@github.com:TiagoMCFreitas/desafio-tecnico-truther.git servicos



echo "SERVICO APP <= desafiotecnico-app"
cp .envApp servicos/app
cd servicos/app
mv .envApp .env

cp ../prisma -r .
bash buildImages.sh $version
cd ../..


echo "SERVICO FRONTEND <== desafiotecnico-syncservice"
cp .envSync servicos/syncservice
cd servicos/syncservice
mv .envSync .env 

cp ../prisma -r .
bash buildImages.sh $version
cd ../..


rm -rf servicos

echo "FINALIZADO"