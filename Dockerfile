# Use a imagem oficial do Node.js 18.16.0 como base
FROM node:18.16.0

# Defina o diretório de trabalho no container
WORKDIR /usr/src/app

# Copie os arquivos package.json e package-lock.json
COPY package*.json ./

# Instale as dependências do projeto
RUN npm install

# Copie o código da aplicação para o container
COPY . .

# Build do TypeScript
RUN npm run build

# Comando para iniciar a aplicação
CMD [ "npm", "start" ]


